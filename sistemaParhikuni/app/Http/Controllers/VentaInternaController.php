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
 * 
 * 
 * 0    - Ver corridas
 * 0.1  - Guardar filtros(corrida)
 * 1    - Ver asientos (ida)
 * 1.1  - Apartar asientos
 * 
 * 2    - Corridas regreso
 * 2.1  - Guardar corrida
 * 3    - Ver asientos (ida)
 * 3.1  - Apartar asientos
 * 
 * 
 * 4    - Confirmación y descuentos
 * 4.1  - Guardar y crear adeudo
 * 5    - vista de pago
 * 5.1  - Abonar cantidad pagada
 * 6.1  - Ver boletos
 * 6.2  - Enviar boletos
*/
date_default_timezone_set("America/Mexico_City");
class VentaInternaController extends Controller
{
    public function __construct(){
        $this->middleware("auth");
    }
    // paso 0
    public function corridasFiltradas(Request $request){
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
        return view('venta.interna.corridasFiltradas',[
            "corridas" => $cordis->paginate(25),
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
            "viajeRedondo" => $request->has("tipoDeViaje"),
        ]);
    }
    // Paso 0.1 // guardar la corrida seleccionada
    public function guardarFiltros(Request $request){
        $cordis=CorridasDisponibles::find($request->cor);
        $disponibilidad=Disponibilidad::find($request->disp);
        // $estado=$cordis->estado($disponibilidad->nOrigen);
        // if($estado->estadoID!="D"){
        //     // echo "cancelar el estado de la corrida es ".$estado->estado;
        //     return redirect(route('venta.interna.cancelarCompra', [
        //         "cancelada" => "El estado de la corrida es: ".strtolower($estado->estado)
        //     ]));
        // }
        if(!session()->has("cmpra_tiempoCompra")){ // para evitar sobreescribir
            $venceCompra=time() + ENV("TIEMPO_PARA_LA_COMPA")*60;
            $now=Carbon::now();
            $salidaCorrida=Carbon::createFromFormat("Y-m-d H:i:s", $disponibilidad->fSalida." ".$disponibilidad->hSalida);
            if($salidaCorrida->lte($now)){
                return redirect(route('venta.interna.cancelarCompra', [
                    "cancelada" => "La corrida ya salió"
                ]));
            }
            if($salidaCorrida->lte($now)){
                return redirect(route('venta.interna.cancelarCompra', [
                    "cancelada" => "La corrida ya salió"
                ]));
            }
            session([
                "cmpra_viajeRedondo" => $request->has("tipoDeViaje"),
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
                
                "reg_origen" => $disponibilidad->nDestino,
                "reg_destino" => $disponibilidad->nOrigen,
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

        $totalPasajeros=0;
        $pasajeros=array();
        if(session("cmpra_adultos")!=0){
            $pasajeros["AD"]=array();
            $pasajeros["AD"]["max"]=session("cmpra_adultos");
            $pasajeros["AD"]["usados"]=0;
            $totalPasajeros+=session("cmpra_adultos");
        }
        if(session("cmpra_estudiantes")!=0){
            $pasajeros["ES"]=array();
            $pasajeros["ES"]["max"]=session("cmpra_estudiantes");
            $pasajeros["ES"]["usados"]=0;
            $totalPasajeros+=session("cmpra_estudiantes");
        }
        if(session("cmpra_insen")!=0){
            $pasajeros["IN"]=array();
            $pasajeros["IN"]["max"]=session("cmpra_insen");
            $pasajeros["IN"]["usados"]=0;
            $totalPasajeros+=session("cmpra_insen");
        }
        if(session("cmpra_maestros")!=0){
            $pasajeros["MA"]=array();
            $pasajeros["MA"]["max"]=session("cmpra_maestros");
            $pasajeros["MA"]["usados"]=0;
            $totalPasajeros+=session("cmpra_maestros");
        }
        if(session("cmpra_niños")!=0){
            $pasajeros["NI"]=array();
            $pasajeros["NI"]["max"]=session("cmpra_niños");
            $pasajeros["NI"]["usados"]=0;
            $totalPasajeros+=session("cmpra_niños");
        }
        if(session("cmpra_sedena")!=0){
            $pasajeros["SE"]=array();
            $pasajeros["SE"]["max"]=session("cmpra_sedena");
            $pasajeros["SE"]["usados"]=0;
            $totalPasajeros+=session("cmpra_sedena");
        }
        $tiposPasajeros=DB::table("tipopasajero")
            ->selectRaw("aClave, aDescripcion")
            ->get();

        return view('venta.interna.asientos',[
            "disponibilidad"=>$disp,
            "cordis"=>$cordis,
            "asientosOcupados"=>$asientos->ocupados($disp->nNumero),
            "totalPasajeros" => $totalPasajeros,
            "tiposPasajeros" =>  $tiposPasajeros,
            "pasajerosSolic" => $pasajeros,
        ]);
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

        $sigPasoVenta=null;
        $siguienteUrl="";
        if(session("cmpra_viajeRedondo")==true){
            $sigPasoVenta=2;
            $siguienteUrl="venta.interna.corridasRegreso";
        }else{
            $sigPasoVenta=4;
            $siguienteUrl="venta.interna.confirmacion";
        }
        session([
			"ida_pasajeros" => json_encode($pasajeros), //nombre,
			"ida_asientosID" => $dispAsiento,
			"cmpra_pasoVenta" => $sigPasoVenta,
        ]);
		session()->save();
        return redirect(route($siguienteUrl));
        // return redirect(route("venta.interna.confirmacion"));
    }
    public function corridasRegreso(Request $request){
        $cordis=new CorridasDisponibles();
        $corridaIda=CorridasDisponibles::find(session("ida_corrida"));
        $horaMin=0;
        $fechaSalida=$request->fechaDeSalida ?: $corridaIda->fSalida;
        if($fechaSalida==$corridaIda->fSalida){
            $horaMin=$corridaIda->hSalida;
        }else{
            $horaMin=$request->hInicio ?: "00:00:00";
        }
        $cordis=$cordis->filtrar(null, session("reg_origen"), session("reg_destino"), $fechaSalida, null,//fecha maxima
            [
                "adultos" => session("cmpra_adultos"),
                "niños" => session("cmpra_niños"),
                "insen" => session("cmpra_insen"),
                "estudiantes" => session("cmpra_estudiantes"),
                "profesores" => session("cmpra_maestros"),
            ],
            $horaMin, $request->hFin, session("cmpra_usarPromocion")
        );

        return view('venta.interna.corridasRegreso',[
            "corridas" => $cordis->paginate(25),
            // "origen" => Oficinas::find($request->origen),
            // "destino" => Oficinas::find($request->destino),
            "adultos" => session("cmpra_adultos"),
            "niños" => session("cmpra_niños"),
            "insen" => session("cmpra_insen"),
            "estudiantes" => session("cmpra_estudiantes"),
            "profesores" => session("cmpra_maestros"),
            // "promociones" =>$request->has("usarPromocion"),
            "fechaMin" => $corridaIda->fSalida,
            "fechaDeSalida" => $fechaSalida,
            "fechaMax" => $request->fechaMax,
            "oficinas" => Oficinas::destinos(0,true),
            "horario" => $request->horario,
            "viajeRedondo" => $request->has("tipoDeViaje"),
        ]);
    }
    public function corridasRegresoGuardar(Request $request){
        // dd($request->all());
        session([
            "reg_corrida"=>$request->cor,
            "reg_disponibilidad"=>$request->disp,
            "cmpra_pasoVenta"=>3,
        ]);
        session()->save();
        return redirect( route('venta.interna.asientosRegreso') );
    }
    public function asientosRegreso(Request $request){
        $cordis=CorridasDisponibles::find(session("reg_corrida"));
        $disp=Disponibilidad::find(session("ida_disponibilidad"));
        $asientos=new DisponibilidadAsientos();
        $pasajeros=json_decode(session("ida_pasajeros"));
        // dd($pasajeros);
        return view('venta.interna.asientosRegreso',[
            "disponibilidad"=>$disp,
            "cordis"=>$cordis,
            "asientosOcupados"=>$asientos->ocupados(session("reg_disponibilidad")),
            "pasajeros" => $pasajeros,
        ]);
    }
    public function apartarReg(Request $request){
        $disponibilidad=Disponibilidad::find(session("reg_disponibilidad"));
        $pasajeros=array();
        $dispAsiento="";
        try {
            DB::beginTransaction();
            for($i=0; $i<sizeof($request->nombre); $i++){
                $pasajeros[$i]["nombre"]=$request->nombre[$i];
                $pasajeros[$i]["asiento"]=$request->asiento[$i];
                $pasajeros[$i]["tipoID"]=$request->tipoID[$i];
                $pasajeros[$i]["tipo"]=$request->tipo[$i];

                $disponibilidades=DisponibilidadAsientos::apartarAsiento(
                    session("reg_corrida"),
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
            //throw $th;
            DB::rollback();
            return back()->withErrors("El asiento ".$request->asiento[$i]." ya está ocupado");
        }
        session([
			"reg_pasajeros" => json_encode($pasajeros), //nombre,
			"reg_asientosID" => $dispAsiento,
			"cmpra_pasoVenta" => 4,
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
            "cmpra_pasoVenta" => 5
        ]);
        return redirect(route("venta.interna.pago"));
    }
    // paso 5
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
    // paso 5.1
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
    // paso 6 [fin]
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

		session()->forget("reg_corrida");
		session()->forget("reg_disponibilidad");
		session()->forget("reg_origen");
		session()->forget("reg_destino");
		session()->forget("reg_pasajeros");
		session()->forget("reg_asientosID");
		
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
