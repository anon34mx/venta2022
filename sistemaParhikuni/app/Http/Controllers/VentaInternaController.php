<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CorridasDisponibles;
use App\Models\Disponibilidad;
use App\Models\DisponibilidadAsientos;
use App\Models\Oficinas;
use App\Models\Promociones;

use DB;
use Auth;
use Carbon\Carbon;
use PDF;

class VentaInternaController extends Controller
{
    public function __construct(){
        $this->middleware("auth");
    }
    // paso 1
    public function corridasFiltradas(Request $request){
        $cordis=new CorridasDisponibles();
        $origen=$request->origen ?: session("oficinaid");
        $fechaSalida=$request->fechaDeSalida ?: date("Y-m-d");

        $request->request->add(['pasoCompra' => 1]); //add request
        return view('venta.interna.corridasFiltradas',[
            "corridas" => $cordis->filtrar($request->corrida, $origen, $request->destino, $fechaSalida, null,//fecha maxima
                [
                    "adultos" => $request->adultos ?: 0,
                    "niños"=> $request->niños ?: 0,
                    "insen"=> $request->insen ?: 0,
                    "estudiantes"=> $request->estudiantes ?: 0,
                    "profesores"=> $request->profesores ?: 0,
                ]
            ),
            "origen" => Oficinas::find($request->origen),
            "destino" => Oficinas::find($request->destino),
            "adultos"=> $request->adultos!=null ? $request->adultos : 0,
            "niños"=> $request->niños!=null ? $request->niños : 0,
            "insen"=> $request->insen!=null ? $request->insen : 0,
            "fechaDeSalida" => $fechaSalida,
            "fechaMax" => $request->fechaMax,
            "oficinas" => Oficinas::destinos(0,true),
        ]);
    }
    
    // paso 2
    public function asientos(Request $request){
        $disp=Disponibilidad::find($request->disp);
        $cordis=CorridasDisponibles::find($request->cor);
        $asientos=new DisponibilidadAsientos();
        // dd($disp->tarifas($cordis));
        if($cordis->aEstado!="D"){
            return back()->withError("La corrida no está disponible.");
        }
        return view('venta.interna.asientos',[
            "disponibilidad"=>$disp,
            "cordis"=>$cordis,
            "asientosOcupados"=>$asientos->ocupados($request->disp),
            "pasajeros" => array(
                "AD" => $request->AD ?: 0,
                "NI" => $request->NI ?: 0,
                "IN" => $request->IN ?: 0,
                "MA" => $request->MA ?: 0,
                "ES" => $request->ES ?: 0,
            )
        ]);
    }

    // paso 2.1
    public function apartar(Request $request){
        date_default_timezone_set("America/Mexico_City");
        $disponibilidad=Disponibilidad::find($request->disp);
        
        $venceCompra=null; // =strtotime($disponibilidad->fSalida." ".$disponibilidad->hSalida); // limite para hacer la compra a la hora de salida
        if(Auth::user()->personas->aTipo=="EI"){
            $venceCompra=strtotime($disponibilidad->fSalida." ".$disponibilidad->hSalida)+300; // limite para hacer la compra a la hora de salida + 5 minutos
        }else{
            $venceCompra=time() + ($tiempoParaLaVenta);
        }
        try {
            $rs=DisponibilidadAsientos::apartarAsiento(
                $request->cor,
                $disponibilidad->nOrigen,
                $disponibilidad->nDestino,
                implode(",",$request->asiento),
                Auth::user()->id
            );
            // session_start();
            session([
                "corrida" => $request->cor,
                "disponibilidad" => $request->disp,
                "asientosID" => $rs[0]->asientos,
                "tiempoCompra" => $venceCompra,
                "asientos" => json_encode($request->asiento), // numeros de asient,
                "origen" => $disponibilidad->nOrigen."",
                "destino" => $disponibilidad->nDestino."",
                "pasajeros" => json_encode($request->pasajero), //nombre,
                "pasajerosTipos" => json_encode($request->pasajeroTipo)
            ]);
            // cookies
            setcookie("tiempoCompra", $venceCompra, $venceCompra, "/");
            return redirect(route("venta.interna.confirmacion"));
        } catch (\Throwable $th) {
            // dd($th);
            return back()->withErrors("Alguno de los asientos ya están ocupados");
        }
        
    }

    // paso 3
    public function confirmacion(Request $request){
        date_default_timezone_set("America/Mexico_City");
        $fVenta=Carbon::createFromTimestamp(session("tiempoCompra"));
        $fActual=Carbon::now();
        $cordis=CorridasDisponibles::find(session("corrida"));
        $disponibilidad=Disponibilidad::find(session("disponibilidad"));
        $tarifas=($disponibilidad->tarifas());
        $tiposPasAux="'".implode("','",json_decode(session("pasajerosTipos")))."'";
        $promocionesAplicables=Promociones::aplicables($tiposPasAux, $disponibilidad->nOrigen, $disponibilidad->nDestino);
        $tiempoRestante=null;
        if( $fActual->lte($fVenta) ){
            $tiempoRestante=$fActual->diffInSeconds($fVenta);
        }else{
            session_unset();
            echo "TIEMPO FIN<br>";
            echo $fVenta."<br>";
            echo $fActual."<br>";
            return back()->withErrors("La corrida ya salió");
        }

        if(session("origen")!="" && session("destino")!="" && session("asientos")!=""){
            return view("venta.interna.confirmacion",[
                "tiempoRestante" => $tiempoRestante,
                "corrida" => $cordis,
                "disponibilidad" => $disponibilidad,
                "promociones" => $promocionesAplicables,
                "tarifas" => $tarifas,

                "tipos" => json_decode(session("pasajerosTipos")),
                "asientoApartado" => json_decode(session("asientos")),
                "pasajeros" => json_decode(session("pasajeros")),
            ]);
        }else{
        }
    }

    // paso 4
    public function pago(Request $request){ // vista
        /*
        datos de facturacion
        correo telefono

        datos de tarjeta / calculo de efectivo

        total
        */

        $disponibilidad=Disponibilidad::find(session("disponibilidad"));
        $cordis=CorridasDisponibles::find(session("corrida"));

        $promociones=$request->except("_token")["promo"];
        $tarifas=$disponibilidad->tarifas();
        $tipos=json_decode(session("pasajerosTipos"));
        $pasajeros = json_decode(session("pasajeros"));
        $total=0;

//         echo "<pre>
// tipo    ||  nombre          ||  tarifa  ||  iva ||  subtotal
// ";

        for($i=0; $i<sizeof($pasajeros); $i++) {
            if($promociones[$i]!="NA"){
                $promoAplicada=Promociones::where("nNumero", "=", $promociones[$i])->get()->first(); // registro en BD
                $porcentajeAplicado=number_format(($promoAplicada->nDescuento/100),2); // porcentaje de descuento ya en formato 00.00
                $descuentoAplicado=number_format($tarifas->tarifaRuta*$porcentajeAplicado, 2); // Cantidad que se descuenta de la tarifa base $00.00
                $tarifaDescuentoAplicado=number_format($tarifas->tarifaRuta-$descuentoAplicado, 2); // tarifa sin la parte descontada
                $ivaDescuento=number_format($tarifaDescuentoAplicado*(env("IVA")/100),2); // el IVA correspondiente
                $total+=number_format($tarifaDescuentoAplicado+$ivaDescuento, 2); // se suma al total el costo de este boleto
            }else{
                $total=number_format($tarifas->tarifaRutaConIVA,2);
            }
        }

         return view("venta.interna.pago",[
            "total"=>$total
         ]);
    }

    function comprobarCompra(){
        // si ya se ha liquidado el total se pasa a guardar los boletos e imprimirlos
        // si no se muestra la pantalla de pago
    }

    // paso 5
    function guardarDatosCompra(){

    }
    function crearBoletos(){

    }
    function enviarBoletos(){

    }

    function cancelarCompra(){
//           "_token",
//   "login_web_59ba36addc2b2f9401580f014c7f58ea4e30989d",
//   "pasoCompra",
//   "_previous",
//   "_flash",
//   "corrida",
//   "disponibilidad",
//   "asientosID",
//   "tiempoCompra",
//   "asientos",
//   "origen",
//   "destino",
//   "pasajeros",
//   "pasajerosTipos",
        // session()->flush();
        session()->invalidate();
        dd(session()->all());
    }
}
