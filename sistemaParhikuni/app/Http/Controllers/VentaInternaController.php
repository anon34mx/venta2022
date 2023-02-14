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
        // dd($request->has("tipoDeViaje"));
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
            "promociones"=>$request->has("usarPromocion"),
            "fechaDeSalida" => $fechaSalida,
            "fechaMax" => $request->fechaMax,
            "oficinas" => Oficinas::destinos(0,true),
            "horario" => $request->horario,
            // "tipoDeViaje" => $request->tipoDeViaje ?: "sencillo",
            "viajeRedondo" => $request->has("tipoDeViaje"),
        ]);
    }

    // Paso 0.1 // guardar la corrida seleccionada
    public function guardarFiltros(Request $request){
        if(!session()->has("cmpra_tiempoCompra")){ // para evitar sobreescribir
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
                "cmpra_viajeRedondo" => $request->tipoDeViaje,
                "cmpra_pasoVenta"=>1,
                "cmpra_tiempoCompra" => $venceCompra,
                "cmpra_usarPromocion" => $request->has("usarPromocion"),
    
                "cmpra_adultos"=>$request->AD ?: 0,
                "cmpra_estudiantes"=>$request->ES ?: 0,
                "cmpra_insen"=>$request->IN ?: 0,
                "cmpra_maestros"=>$request->MA ?: 0,
                "cmpra_niños"=>$request->NI ?: 0,
                "cmpra_sedena"=>$request->SE ?: 0,
                
                "ida_corrida"=>$request->cor,
                "ida_disponibilidad"=>$request->disp,
                "ida_origen" => $disponibilidad->nOrigen."",
                "ida_destino" => $disponibilidad->nDestino."",
                
                // "cmpra_paqueteria"=>$request->PQ ?: 0,
                // "reg_corrida"=> null,
                // "reg_disponibilidad"=> null,
                // "reg_origen" => $disponibilidad->nDestino,
                // "reg_destino" => $disponibilidad->nOrigen,
            ]);
        }
        session()->save();
        return redirect(route('venta.interna.asientos'));
    }

    // paso 1
    public function asientosIda(Request $request){
        
        $disp=Disponibilidad::find(session("ida_disponibilidad"));
        $cordis=CorridasDisponibles::find(session("ida_corrida"));
        $asientos=new DisponibilidadAsientos();
        $fVenta=Carbon::createFromFormat("Y-m-d H:i:s", $disp->fSalida." ".$disp->hSalida);
        $fActual=Carbon::now();
        if( $fActual->gte($fVenta) ){
            return redirect(route('venta.interna.cancelarCompra', [
                    "cancelada" => "La corrida ya salió"
                ]));
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
                "AD" => session("cmpra_adultos"),
                "ES" => session("cmpra_estudiantes"),
                "IN" => session("cmpra_insen"),
                "MA" => session("cmpra_maestros"),
                "NI" => session("cmpra_niños"),
                // "SE" => session("cmpra_sedena"),
            ),
        ]);
        dd();
    }

    // paso 2
    public function apartarIda(Request $request){
        
        $disponibilidad=Disponibilidad::find(session("ida_disponibilidad"));
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
                    session("ida_corrida"),
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
            dd($th);
            // throw new Exception("Error al apartar asientos", 1);
            DB::rollback();
            return back()->withErrors("El asiento ".$request->asiento[$i]." ya está ocupado");
        }
        session([
			"ida_pasajeros" => json_encode($pasajeros), //nombre,
			"ida_asientosID" => $dispAsiento,
			"cmpra_pasoVenta" => 3,
        ]);
		session()->save();
        return redirect(route("venta.interna.confirmacion"));
    }

    // paso 3 confirmacion(vista)
    public function confirmacion(Request $request){
        $fVenta=Carbon::createFromTimestamp(session("cmpra_tiempoCompra"));
        $fActual=Carbon::now();
        $cordis=CorridasDisponibles::find(session("ida_corrida"));
        $disponibilidad=Disponibilidad::find(session("ida_disponibilidad"));
        $tarifas=($disponibilidad->tarifas());
        $pasajerosTemp=json_decode(session("ida_pasajeros"));
        $promocionesAplicables=Promociones::aplicables($disponibilidad->nOrigen, $disponibilidad->nDestino, session("oficinaid"), $cordis->nNumero, session("cmpra_viajeRedondo"), $cordis->nTipoServicio);
        // dd($promocionesAplicables);
        $tiempoRestante=null;
        if( $fActual->lte($fVenta) ){
            $tiempoRestante=$fActual->diffInSeconds($fVenta);
        }else{
            // echo "TIEMPO FIN<br>";
            // echo $fVenta."<br>";
            // echo $fActual."<br>";
            // exit;
            return back()->withErrors("La corrida ya salió [3]confirmacion");
        }
        if(session("ida_origen")!="" && session("ida_destino")!=""){
            return view("venta.interna.confirmacion",[
                "tiempoRestante" => $tiempoRestante,
                "corrida" => $cordis,
                "disponibilidad" => $disponibilidad,
                "promociones" => $promocionesAplicables,
                "tarifas" => $tarifas,
                "pasajeros"=>json_decode(session("ida_pasajeros"))
            ]);
        }else{
            dd("else?");
        }
    }

    // paso 3.1 (Guardar confirmacion y mandar a vista de pago)
    public function confirmacionGuardar(Request $request){
        $cordis=CorridasDisponibles::find(session("ida_corrida"));
        $disp=Disponibilidad::find(session("ida_disponibilidad"));
        $pasajeros=json_decode(session("ida_pasajeros"));

        $promociones=@$request->except("_token")["promo"];
        $tarifas=$disp->tarifas();
        if(!session()->has("ida_IDventa")){
            $ventaID=Venta::create([
                "nSesion" => session("sesionVenta"),
            ]);
            session([
				"ida_IDventa" => $ventaID->nNumero,
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
                    'nVenta' => session("ida_IDventa"),
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
                session([
					"ida_pasajeros"=>json_encode($pasajeros)
                ]
                );
                session()->save();
            }
        }
        session([
            "cmpra_pasoVenta" => 4
        ]);
        return redirect(route("venta.interna.pago"));
    }

    // paso 4
    public function pago(Request $request){ // vista
        $venta=Venta::find(session("ida_IDventa"));

        if($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado <= 0){
            // Ya está pagado
            // Se borran los datos temporales
            //PASAR COMO PARAMETROS
            session()->forget("ida");
            session()->forget("cmpra_pasoVenta");
            session()->forget("cmpra_viajeRedondo");
            session()->forget("cmpra_tiempoCompra");
            session()->forget("cmpra_usarPromocion");
            session()->forget("cmpra_adultos");
            session()->forget("cmpra_estudiantes");
            session()->forget("cmpra_insen");
            session()->forget("cmpra_maestros");
            session()->forget("cmpra_niños");
            session()->forget("cmpra_sedena");
            session()->forget("ida_corrida");
            session()->forget("ida_disponibilidad");
            session()->forget("ida_origen");
            session()->forget("ida_destino");
            session()->forget("ida_pasajeros");
            session()->forget("ida_asientosID");
            session()->forget("ida_IDventa");


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
                    "nVenta" => session("ida_IDventa"),
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
        if(session()->has("ida_asientosID")){
            $desocupados=DisponibilidadAsientos::desocupar(session("ida_asientosID"));
        }

        // venta
		session()->forget("cmpra_pasoVenta");
		session()->forget("cmpra_viajeRedondo");
		session()->forget("cmpra_tiempoCompra");
		session()->forget("cmpra_usarPromocion");
		session()->forget("cmpra_adultos");
		session()->forget("cmpra_estudiantes");
		session()->forget("cmpra_insen");
		session()->forget("cmpra_maestros");
		session()->forget("cmpra_niños");
		session()->forget("cmpra_sedena");
		session()->forget("ida_corrida");
		session()->forget("ida_disponibilidad");
		session()->forget("ida_origen");
		session()->forget("ida_destino");
		session()->forget("ida_pasajeros");
		session()->forget("ida_asientosID");
		
        session([
			"cmpra_pasoVenta"=>0,
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
    function cerrarSesionVenta(){
        echo "mostrar corte de venta";
    }
}
