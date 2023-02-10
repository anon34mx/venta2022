<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CorridasDisponibles;
use App\Models\Disponibilidad;
use App\Models\DisponibilidadAsientos;
use App\Models\Oficinas;
use App\Models\Promociones;
use App\Models\Venta;
use App\Models\TipoPasajero;
use App\Models\BoletosVendidos;
use App\Models\VentaPago;
use App\Models\Sesiones;

use Auth;
use Carbon\Carbon;
use Exception;
use DB,PDF,DNS1D,DNS2D;
/**
 * Pasos para la venta
 * 1    - Ver corridas
 * 2    - Ver asientos disponibles
 * 2.1  - Apartar asientos
 * 3    - Confirmación y descuentos
 * 3.1  - Guardar y crear adeudo
 * 4    - vista de pago
 * 4.1  - Abonar cantidad pagada
 * 5    - Ver boletos
 * 6    - Enviar boletos
*/
date_default_timezone_set("America/Mexico_City");
class VentaInternaController extends Controller
{
    public function __construct(){
        $this->middleware("auth");
    }
    // paso 0
    public function corridasFiltradas(Request $request){
        // dd($request->usarPromocion);
        $cordis=new CorridasDisponibles();
        
        $origen=$request->origen ?: session("oficinaid");
        $fechaSalida=$request->fechaDeSalida ?: date("Y-m-d");
        
        $cordis=$cordis->filtrar($request->corrida, $origen, $request->destino, $fechaSalida, null,//fecha maxima
                [
                    "adultos" => $request->adultos ?: 0,
                    "niños"=> $request->niños ?: 0,
                    "insen"=> $request->insen ?: 0,
                    "estudiantes"=> $request->estudiantes ?: 0,
                    "profesores"=> $request->profesores ?: 0,
                ],
                $request->hInicio, $request->hFin, $request->usarPromocion
            );
        $request->request->add(['pasoCompra' => 1]); //add request
        return view('venta.interna.corridasFiltradas',[
            "corridas" => $cordis->paginate(25),
            // "corridas" => $cordis->paginate(25),
            "origen" => Oficinas::find($request->origen),
            "destino" => Oficinas::find($request->destino),
            "adultos"=> $request->adultos!=null ? $request->adultos : 0,
            "niños"=> $request->niños!=null ? $request->niños : 0,
            "insen"=> $request->insen!=null ? $request->insen : 0,
            "estudiantes"=> $request->estudiantes!=null ? $request->estudiantes : 0,
            "profesores"=> $request->profesores!=null ? $request->profesores : 0,
            "promociones"=>false,
            "fechaDeSalida" => $fechaSalida,
            "fechaMax" => $request->fechaMax,
            "oficinas" => Oficinas::destinos(0,true),
            "horario" => $request->horario,
            "tipoDeViaje" => $request->tipoDeViaje ?: "sencillo",
        ]);
    }

    // Paso 0.1 // guardar la corrida seleccionada
    public function guardarFiltros(Request $request){
        // dd($request->usarPromocion==true);
        $disponibilidad=Disponibilidad::find($request->disp);
        $venceCompra=time() + ENV("TIEMPO_PARA_LA_COMPA")*60;
        $now=Carbon::now();
        $salidaCorrida=Carbon::createFromFormat("Y-m-d H:i:s", $disponibilidad->fSalida." ".$disponibilidad->hSalida);
        if($salidaCorrida->lte($now)){
            return redirect(route('venta.interna.cancelarCompra', [
                "cancelada" => "La corrida ya salió"
            ]));
        }
        session([
            "tipoDeViaje" => $request->tipoDeViaje,
            "corrida"=>$request->cor,
            "disponibilidad"=>$request->disp,
            "origen" => $disponibilidad->nOrigen."",
            "destino" => $disponibilidad->nDestino."",
            "usarPromocion" => $request->usarPromocion,
            
            "pasoVenta"=>1,
            "tiempoCompra" => $venceCompra,

            "adultos"=>$request->AD ?: 0,
            "estudiantes"=>$request->ES ?: 0,
            "insen"=>$request->IN ?: 0,
            "maestros"=>$request->MA ?: 0,
            "niños"=>$request->NI ?: 0,
            "paqueteria"=>$request->PQ ?: 0,
            "sedena"=>$request->SE ?: 0,
        ]);
        session()->save();
        // cookies
        setcookie("tiempoCompra", time()+900, time()+900, "/");
        return redirect(route('venta.interna.asientos'));
    }

    // paso 1
    public function asientos(Request $request){
        
        $disp=Disponibilidad::find(session("disponibilidad"));
        $cordis=CorridasDisponibles::find(session("corrida"));
        $asientos=new DisponibilidadAsientos();
        $fVenta=Carbon::createFromFormat("Y-m-d H:i:s", $disp->fSalida." ".$disp->hSalida);
        $fActual=Carbon::now();
        if( $fActual->gte($fVenta) ){
            dd("corrida pasada");
            return back()->withErrors("La corrida ya salió");
        }

        // if($cordis->aEstado!="D"){
            // dd($cordis->aEstado);
            // return back()->withError("La corrida no está disponible.");
        // }
        return view('venta.interna.asientos',[
            "disponibilidad"=>$disp,
            "cordis"=>$cordis,
            "asientosOcupados"=>$asientos->ocupados($disp->nNumero),
            "pasajerosSolic" => array(
                "AD" => session("adultos"),
                "ES" => session("estudiantes"),
                "IN" => session("insen"),
                "MA" => session("maestros"),
                "NI" => session("niños"),
                "SE" => session("sedena"),
            ),
        ]);
    }

    // paso 2
    public function apartar(Request $request){
        
        $disponibilidad=Disponibilidad::find(session("disponibilidad"));
        $pasajeros=array();

        $dispAsiento="";
        // se apartan todos o ninguno
        try {
            DB::beginTransaction();
            for($i=0; $i<sizeof($request->asiento); $i++){
                $pasajeros[$i]["pasajero"]=$request->pasajero[$i];
                $pasajeros[$i]["asiento"]=$request->asiento[$i];
                $pasajeros[$i]["tipoID"]=$request->pasajeroTipo[$i];
                $pasajeros[$i]["tipo"]=TipoPasajero::find($request->pasajeroTipo[$i])->aDescripcion;

                $disponibilidades=DisponibilidadAsientos::apartarAsiento(
                    session("corrida"),
                    $disponibilidad->nOrigen,
                    $disponibilidad->nDestino,
                    $request->asiento[$i],
                    Auth::user()->id
                );
                $dispAsiento.=$disponibilidades.",";
                $pasajeros[$i]["disponibilidad"]=$disponibilidades;
                }
            DB::commit();
        } catch (\Throwable $th) {
            // throw new Exception("Error al apartar asientos", 1);
            DB::rollback();
            return back()->withErrors("El asiento ".$request->asiento[$i]." ya está ocupado");
        }
        session([
            "pasajeros" => json_encode($pasajeros), //nombre,
            "asientosID" => $dispAsiento,
            "pasoVenta" => 3,
        ]);
        return redirect(route("venta.interna.confirmacion"));
    }

    // paso 3 confirmacion(vista)
    public function confirmacion(Request $request){
        $fVenta=Carbon::createFromTimestamp(session("tiempoCompra"));
        $fActual=Carbon::now();
        $cordis=CorridasDisponibles::find(session("corrida"));
        $disponibilidad=Disponibilidad::find(session("disponibilidad"));
        $tarifas=($disponibilidad->tarifas());
        $pasajerosTemp=json_decode(session("pasajeros"));
        $tiposPasAux="";
        for($i=0; $i<sizeof($pasajerosTemp); $i++){
            $tiposPasAux.="'".$pasajerosTemp[$i]->tipoID."',";
        }
        $promocionesAplicables=Promociones::aplicables($tiposPasAux, $disponibilidad->nOrigen, $disponibilidad->nDestino);
        $tiempoRestante=null;
        if( $fActual->lte($fVenta) ){
            $tiempoRestante=$fActual->diffInSeconds($fVenta);
        }else{
            // session_unset();
            // echo "TIEMPO FIN<br>";
            // echo $fVenta."<br>";
            // echo $fActual."<br>";
            // exit;
            return back()->withErrors("La corrida ya salió [3]confirmacion");
        }
        if(session("origen")!="" && session("destino")!=""){
            return view("venta.interna.confirmacion",[
                "tiempoRestante" => $tiempoRestante,
                "corrida" => $cordis,
                "disponibilidad" => $disponibilidad,
                "promociones" => $promocionesAplicables,
                "tarifas" => $tarifas,
                "pasajeros"=>json_decode(session("pasajeros"))
            ]);
        }else{
            dd("else?");
        }
    }

    // paso 3.1 (Guardar confirmacion y mandar a vista de pago)
    public function confirmacionGuardar(Request $request){
        $cordis=CorridasDisponibles::find(session("corrida"));
        $disp=Disponibilidad::find(session("disponibilidad"));
        $pasajeros=json_decode(session("pasajeros"));

        $promociones=@$request->except("_token")["promo"];
        $tarifas=$disp->tarifas();
        if(!session()->has("IDventa")){
            $ventaID=Venta::create([
                "nSesion" => session("sesionVenta"),
            ]);
            session([
                "IDventa" => $ventaID->nNumero,
            ]);
            session()->save();
        }
        for($i=0; $i<sizeof($pasajeros); $i++){
            if(!isset($pasajeros[$i]->boleto)){
                $promoAplicada=null;
                $porcentajeAplicado=null;
                $descuentoAplicado=null;
                $costo=null;
                $iva=null;
                $total=null;
                if($promociones!=null){
                    $promoAplicada=Promociones::where("nNumero", "=", $promociones[$i])->get()->first(); // registro en BD
                    $porcentajeAplicado=number_format(($promoAplicada->nDescuento/100),2); // porcentaje de descuento ya en formato 00.00
                    $descuentoAplicado=number_format($tarifas->tarifaRuta*$porcentajeAplicado, 2); // Cantidad que se descuenta de la tarifa base $00.00
                    $costo=number_format($tarifas->tarifaRuta-$descuentoAplicado, 2); // tarifa restando la parte descontada
                    $iva=number_format($costo*(env("IVA")/100),2); // el IVA correspondiente
                    $total+=number_format($costo+$iva, 2); // se suma al total el costo de este boleto
                }else{
                    $total+=number_format($tarifas->tarifaRutaConIVA,2);
                    $costo=$tarifas->tarifaRuta;
                    $iva=$tarifas->tarifaRutaIVA;
                    $descuentoAplicado=0;
                }
                $boleto=BoletosVendidos::create([
                    'nVenta' => session("IDventa"),
                    'nCorrida' => $cordis->nNumero,
                    'fSalida' => $cordis->fSalida,
                    'hSalida' => $cordis->hSalida,
                    'nOrigen' => $disp->nOrigen,
                    'nDestino' => $disp->nDestino,
                    'aTipoPasajero' => $pasajeros[$i]->tipoID,
                    'aPasajero' => $pasajeros[$i]->pasajero,
                    'nAsiento' => $pasajeros[$i]->asiento,
                    'aTipoVenta' => "CO",
                    'nMontoBase' => $costo,
                    'nMontoDescuento' => $descuentoAplicado,
                    'nIva' => $iva,
                    'aEstado' => "VE",
                    'nTerminal' => 3,
                ]);
                $dispUpdt=DisponibilidadAsientos::registrarBoleto($pasajeros[$i]->disponibilidad, $boleto->nNumero, $cordis->fSalida." ".$cordis->hSalida);
                $pasajeros[$i] = (object) array_merge((array) $pasajeros[$i], (array) array(
                    "boleto"=>$boleto->nNumero,
                    "IDpromo"=>@$promociones[$i] ?: null,
                    )
                );
                session([ //regresar
                    "pasajeros"=>json_encode($pasajeros) //regresar
                ]); //regresar
                session()->save(); //regresar
            }
        }
        session(["pasoVenta"=>4]);
        return redirect(route("venta.interna.pago")); //regresar
    }

    // paso 4
    public function pago(Request $request){ // vista
        $venta=Venta::find(session("IDventa"));

        if($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado <= 0){
            // Ya está pagado
            // Se borran los datos temporales
            setcookie('tiempoCompra', null, -1);
            session()->forget("corrida");
            session()->forget("disponibilidad");
            session()->forget("pasajeros");
            session()->forget("asientosID");
            session()->forget("tiempoCompra");
            session()->forget("origen");
            session()->forget("destino");
            session()->forget("pasoVenta");
            session()->forget("IDventa");


            return redirect(route('venta.interna.boletos',[
                "venta" => $venta
            ]));
        }else{
            return view("venta.interna.pago",[
                "venta"=>$venta
            ]);
        }
    }

    // paso 4.1
    function abonar(Request $request){
        switch ($request->formaDePago) {
            case 'EF':
                VentaPago::create([
                    "nVenta" => session("IDventa"),
                    "aFormaPago" => "EF",
                    "nMonto" => $request->cantidadRecibida,
                ]);
                break;
            default:
                return back();
                break;
        }
        return redirect(route("venta.interna.pago"));
    }

    // paso 5 [fin]
    function boletos(Venta $venta){
        $boletos = new BoletosVendidos();
        $boletos=$boletos->where("nVenta","=",$venta->nNumero)->get();

        // generar codigo de barras para cada boleto
        for($i=0; $i<sizeof($boletos); $i++){
            $boletos[$i]->setCodbarAttribute(DNS1D::getBarcodePNG($boletos[$i]->nNumero."", 'C128'));
        }
        if(false){ // vista previa html
            return view('PDF.boleto.2020_porNadia',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => 'rgb(170,40,37)'
            ]);
        }else{
            return $pdf = \PDF::loadView('PDF.boleto.2020_porNadia',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => '#aa2825'
            ])
            ->setPaper('letter', 'portrait')
            ->stream('boletos_'.$venta->nNumero.'_parhikuni.pdf');
            // ->download("a.pdf");

            // return $pdf->download("boletos.pdf");
            // return $pdf;
        }
    }
    function enviarBoletos(){
        //
    }
    function cancelarCompra(Request $request){
        $desocupados=DisponibilidadAsientos::desocupar(session("asientosID"));

        // venta
        setcookie('tiempoCompra', null, -1);
        session()->forget("corrida");
        session()->forget("disponibilidad");
        session()->forget("tiempoCompra");
        session()->forget("origen");
        session()->forget("destino");
        session()->forget("pasoVenta");
        session()->forget("IDventa");
        // pasajeros
        session()->forget("pasajeros");
        session()->forget("asientosID");
            // cantidades
        session()->forget("adultos");
        session()->forget("estudiantes");
        session()->forget("insen");
        session()->forget("maestros");
        session()->forget("niños");
        session()->forget("paqueteria");
        session()->forget("sedena");
        session()->save();

        
        session([
            "pasoVenta" => 0,
        ]);
        session()->save();
        /*
            Motivos por los que se cancela
            
            -Teminó el tiempo de compra
            -La corrida ya pasó
            -Cancelada por el usuario
        */
        return redirect(route('venta.interna.corridas', [
            "cancelada" => $request->cancelada ?: "Compra cancelada"
        ]));
    }
    // function abrirSesionVenta(){
    //     if(!session()->has("sesionVenta")){
    //         $sesionVenta=Sesiones::create([
    //             "nNumeroPersona"=>Auth::user()->id,
    //             "fContable"=>date('Y-m-d'),
    //             "nOficina"=>session("oficinaid"),
    //         ]);
    //         session(["sesionVenta" => $sesionVenta->nNumero]);
    //     }
    //     return back();
    // }
    function cerrarSesionVenta(){
        // session()->forget("sesionVenta");
        echo "mostrar corte de venta";
    }
}
