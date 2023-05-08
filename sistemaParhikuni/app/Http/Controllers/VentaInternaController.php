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
use App\Models\PeriodosVacacionales;

use Auth;
use Carbon\Carbon;
use Exception;
use DB,PDF,DNS1D,DNS2D, QrCode;
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
        // dd(Oficinas::destinos(0,true)[0]["destinos"], Oficinas::destinos(8,true), Oficinas::destinos("todos",true));
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
            // "fechaMax" => $request->fechaMax,
            "oficinas" => Oficinas::destinos("todos",true)[0]["destinos"],
            "horario" => $request->horario,
            "viajeRedondo" => $request->has("tipoDeViaje"),
            "vacaciones" => PeriodosVacacionales::aplicable($fechaSalida, $request->fechaRegreso),
        ]);
    }
    // Paso 0.1 // guardar la corrida seleccionada
    public function guardarFiltros(Request $request){
        // dd($request->all());
        $cordis=CorridasDisponibles::find($request->cor);
        $disponibilidad=Disponibilidad::find($request->disp);
        $origen = Oficinas::find($disponibilidad->nOrigen);
        $destino = Oficinas::find($disponibilidad->nDestino);
        // dd($origen, $destino);
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
                "ida_origenNombre" => $origen->aNombre,
                "ida_destino" => $disponibilidad->nDestino."",
                "ida_destinoNombre" => $destino->aNombre,
                "ida_fecha" => $disponibilidad->fSalida."",
                
                "reg_origen" => $disponibilidad->nDestino,
                "reg_origenNombre" => $destino->aNombre,
                "reg_destino" => $disponibilidad->nOrigen,
                "reg_destinoNombre" => $origen->aNombre,
                "reg_fecha" => @$request->fechaRegreso,
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
                    $request->asiento[$i]
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
        $fechaSalida=$request->fechaDeSalida ?: session("reg_fecha"); //$corridaIda->fSalida;
        // if(isset($request->fechaDeSalida)){
        //     $fechaSalida=$request->fechaDeSalida;
        // }
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
            "vacaciones" => PeriodosVacacionales::aplicable($fechaSalida),
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
        $disp=Disponibilidad::find(session("reg_disponibilidad"));
        $asientos=new DisponibilidadAsientos();
        $pasajeros=json_decode(session("ida_pasajeros"));
        // dd($disp);
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
                $pasajeros[$i]["pasajero"]=$request->nombre[$i];
                $pasajeros[$i]["asiento"]=$request->asiento[$i];
                $pasajeros[$i]["tipoID"]=$request->tipoID[$i];
                $pasajeros[$i]["tipo"]=$request->tipo[$i];

                $disponibilidades=DisponibilidadAsientos::apartarAsiento(
                    session("reg_corrida"),
                    $disponibilidad->nOrigen,
                    $disponibilidad->nDestino,
                    $request->asiento[$i]
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
        $vista="venta.interna.confirmacion";

        //ida
        $cordis=CorridasDisponibles::find(session("ida_corrida"));
        $disponibilidad=Disponibilidad::find(session("ida_disponibilidad"));
        $tarifas=($disponibilidad->tarifas());
        $pasajerosTemp=json_decode(session("ida_pasajeros"));
        $promocionesAplicables=Promociones::aplicables($disponibilidad->nOrigen, $disponibilidad->nDestino, session("oficinaid"), $cordis->nNumero, session("cmpra_viajeRedondo"), $cordis->nTipoServicio);
        
        // regreso
        $reg_cordis=null;
        $reg_disponibilidad=null;
        $reg_tarifas=null;
        $reg_pasajeros=null;
        $reg_promocionesAplicables=null;

        if(session("cmpra_viajeRedondo")){
            $vista="venta.interna.confirmacion_redondo";
            $reg_cordis=CorridasDisponibles::find(session("reg_corrida"));
            $reg_disponibilidad=Disponibilidad::find(session("reg_disponibilidad"));
            $reg_tarifas=($reg_disponibilidad->tarifas());
            $reg_pasajeros=json_decode(session("reg_pasajeros"));
            $reg_promocionesAplicables=Promociones::aplicables($reg_disponibilidad->nOrigen, $reg_disponibilidad->nDestino, session("oficinaid"), $reg_cordis->nNumero, session("cmpra_viajeRedondo"), $reg_cordis->nTipoServicio);
        }

        $tiempoRestante=null;
        if( $fActual->lte($fVenta) ){
            $tiempoRestante=$fActual->diffInSeconds($fVenta);
        }else{
            return back()->withErrors("La corrida ya salió [3]confirmacion");
        }
        if(session("ida_origen")!="" && session("ida_destino")!=""){
            return view($vista,[
                "tiempoRestante"        => $tiempoRestante,
                "corrida"               => $cordis,
                "disponibilidad"        => $disponibilidad,
                "promociones"           => $promocionesAplicables,
                "tarifas"               => $tarifas,
                "pasajeros"             =>json_decode(session("ida_pasajeros")),
                "reg_cordis"            => $reg_cordis,
                "reg_disponibilidad"    => $reg_disponibilidad,
                "reg_tarifas"           => $reg_tarifas,
                "reg_pasajeros"         => $reg_pasajeros,
                "reg_promociones"       => $reg_promocionesAplicables,

            ]);
        }else{
            dd("else?");
        }
    }
    // paso 3.1 (Guardar confirmacion y mandar a vista de pago)
    public function confirmacionGuardar(Request $request){
        // dd(session("ida_corrida"), session("reg_corrida"));
        $cordis=CorridasDisponibles::find(session("ida_corrida"));
        $disp=Disponibilidad::find(session("ida_disponibilidad"));
        $pasajeros=json_decode(session("ida_pasajeros"));
        $promociones=@$request->except("_token")["promoIda"];
        $tarifas=$disp->tarifas();
        
        if(@session("cmpra_viajeRedondo")){
            $reg_cordis=CorridasDisponibles::find(session("reg_corrida"));
            $reg_disp=Disponibilidad::find(session("reg_disponibilidad"));
            $reg_pasajeros=json_decode(session("reg_pasajeros"));
            $reg_promociones=@$request->except("_token")["promoReg"];
            $reg_tarifas=$reg_disp->tarifas();
            $promosCorrReg=json_decode($reg_cordis->promociones());
            if(@session("cmpra_usarPromocion")==true && $reg_promociones!=null){
                if(count(array_filter($reg_promociones, function($value){return $value != "NA";})) > $promosCorrReg->disponibles){
                    return redirect(route("venta.interna.confirmacion"))->withErrors('Se pasó el límmite de promociones de ida');
                }
            }
        }
        if(@session("cmpra_usarPromocion")==true && $promociones!=null){
            $promosCorrIda=json_decode($cordis->promociones());
            if(count(array_filter($promociones, function($value){return $value != "NA";})) > $promosCorrIda->disponibles){
                return redirect(route("venta.interna.confirmacion"))->withErrors('Se pasó el límmite de promociones de ida');
            }
        }
        if(!session()->has("cmpra_IDventa")){
            $ventaID=Venta::create([
                "nSesion" => session("sesionVenta"),
                "nCorridaIda" => session("ida_corrida"),
                "nCorridaRegreso" => session("reg_corrida"),
            ]);
            session([
				"cmpra_IDventa" => $ventaID->nNumero,
            ]);
            session()->save();
        }
        
        for($i=0; $i<sizeof($pasajeros); $i++){
            if(!isset($pasajeros[$i]->boleto)){
                $boleto=null;
                if(session("cmpra_usarPromocion")){
                    $boleto=$this->registrarBoleto(false,session("cmpra_IDventa"), $cordis, $disp, $tarifas, @$promociones[$i], $pasajeros[$i]);
                }else{
                    $boleto=$this->registrarBoleto(false,session("cmpra_IDventa"), $cordis, $disp, $tarifas, "NA", $pasajeros[$i]);
                }
                $pasajeros[$i] = (object) array_merge((array) $pasajeros[$i], (array) array(
                    "boleto"=>$boleto->nNumero,
                    "IDpromo"=>@$promociones[$i] ?: null,
                    )
                );
                session( ["ida_pasajeros"=>json_encode($pasajeros)] );
                session()->save();
            }
        }
        ## REGRESO
        if(@session("cmpra_viajeRedondo")){
            for($i=0; $i<sizeof($reg_pasajeros); $i++){
                if(!isset($reg_pasajeros[$i]->boleto)){
                    $boleto=null;
                    if(session("cmpra_usarPromocion")){
                        $boleto=$this->registrarBoleto(true,session("cmpra_IDventa"), $reg_cordis, $reg_disp, $reg_tarifas, @$reg_promociones[$i], $reg_pasajeros[$i]);
                    }else{
                        $boleto=$this->registrarBoleto(true,session("cmpra_IDventa"), $reg_cordis, $reg_disp, $reg_tarifas, "NA", $reg_pasajeros[$i]);
                    }
                    $reg_pasajeros[$i] = (object) array_merge((array) $reg_pasajeros[$i], (array) array(
                        "boleto"=>$boleto->nNumero,
                        "IDpromo"=>@$promociones[$i] ?: null,
                        )
                    );
                    session( ["reg_pasajeros"=>json_encode($reg_pasajeros)] );
                    session()->save();
                }
            }
        }
        session([
            "cmpra_pasoVenta" => 5
        ]);
        return redirect(route("venta.interna.pago"));
    }
    // paso 3.1.1
    private function registrarBoleto($esRegreso, $idVenta, $corrida, $disponibilidad, $tarifas, $promo, $pasajero){
        // dd("debug");
        // registra el boleto para generar el adeudo
        $promoAplicada=null;
        $porcentajeAplicado=null;
        $descuentoAplicado=null;
        $costo=null;
        $iva=null;
        $total=null;

        $promoAplicada=Promociones::where("nNumero", "=", $promo)
            ->whereRaw("fFin>=current_date")->get()->first();
        if($promo!="NA" && $promoAplicada!=null){
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
            'nVenta' => $idVenta,
            'nCorrida' => $corrida->nNumero,
            'lRegreso' => $esRegreso,
            'fSalida' => $corrida->fSalida,
            'hSalida' => $corrida->hSalida,
            'nOrigen' => $disponibilidad->nOrigen,
            'nDestino' => $disponibilidad->nDestino,
            'aTipoPasajero' => $pasajero->tipoID,
            'aPasajero' => $pasajero->pasajero,
            'nAsiento' => $pasajero->asiento,
            'aTipoVenta' => "CO",
            'nMontoBase' => $costo,
            'nMontoDescuento' => $descuentoAplicado,
            'nIva' => $iva,
            'aEstado' => "VE",
            'nTerminal' => 3,
        ]);
        $dispUpdt=DisponibilidadAsientos::registrarBoleto($pasajero->disponibilidad, $boleto->nNumero, $corrida->fSalida." ".$corrida->hSalida);
        return $boleto;
    }
    // paso 5
    public function pago(Request $request){ // vista
        $venta=Venta::find(session("cmpra_IDventa"));

        if($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado <= 0){
            // Ya está pagado
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
            session()->forget("cmpra_IDventa");

            session([
                "imprimirBoletos" => true
            ]);
            session()->save();


            return redirect(route('venta.interna.boletosPreview',[
                "venta" => $venta,
                "formato" => "PDF"
            ]));
        }else{
            return view("venta.interna.pago",[
                "venta"=>$venta
            ]);
        }
    }
    // paso 5.1
    function abonar(Request $request){
        if(!$request->has("cantidadRecibida") || $request->cantidadRecibida==null){
            return back()->with("status", "Cantidad inválida.");
        }
        $cantidadRecibida=preg_replace('/\_/', "", $request->cantidadRecibida);
        // dd($cantidadRecibida);
        switch ($request->formaDePago) {
            case 'EF':
                VentaPago::create([
                    "nVenta" => session("cmpra_IDventa"),
                    "aFormaPago" => "EF",
                    "nMonto" => $cantidadRecibida,
                ]);
                break;
            case 'TB':
                VentaPago::create([
                    "nVenta" => session("cmpra_IDventa"),
                    "aFormaPago" => "TB",
                    "nMonto" => $cantidadRecibida,
                ]);
                break;
            default:
                return back();
                break;
        }
        return redirect(route("venta.interna.pago"));
    }
    // paso 6 [fin]
    function boletos(Venta $venta, $formato){
        $boletos = new BoletosVendidos();
        $boletos=$boletos->where("nVenta","=",$venta->nNumero)->get();

        // $venta->setCodbarAttribute(DNS1D::getBarcodePNG("34", 'C128'));
        // dd(QrCode::generate($venta->nNumero));
        $venta->setCodbarAttribute( base64_encode( QrCode::generate($venta->nNumero)  ));
        // generar codigo de barras para cada boleto (dentro del PDF)
        for($i=0; $i<sizeof($boletos); $i++){
            $boletos[$i]->setCodbarAttribute(DNS1D::getBarcodePNG($boletos[$i]->nNumero."", 'C128'));
        }
        if(0){ // vista previa html
            // return view('PDF.boleto.2020_porNadia',[
            //     "venta" => $venta,
            //     "boletos" => $boletos,
            //     "tipoPuntoVenta" => "taquilla",
            //     "color" => 'rgb(170,40,37)'
            // ]);
            return view('PDF.boleto.2023_taquilla',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => '#aa2825'
            ]);
        }
        if($formato == "B64"){//    base64 PARA IMPRIMIR DIRECTO
            $pdf = \PDF::loadView('PDF.boleto.2020_porNadia',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => '#aa2825'
            ])
            ->setPaper('letter', 'portrait');
            return base64_encode($pdf->output());exit;
        }elseif($formato == "PDF"){//   PDF PARA VER EN LINEA
            $pdf = \PDF::loadView('PDF.boleto.2020_porNadia',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => '#aa2825'
            ])
            ->setPaper('letter', 'portrait');
            return $pdf->stream('boletos_'.$venta->nNumero.'_parhikuni.pdf');
        }elseif($formato == "TAQ"){ // PARA IMPRIMIR DIRECTO EN TAQUILLA
            /*
                https://stackoverflow.com/questions/40843050/how-to-make-pdf-exact-10cm-width-with-dompdf-and-laravel
                1 inch = 72 point
                1 inch = 2.54 cm
                10 cm = 10/2.54*72 = 283.464566929
            */

            $tamanoPapel=array(0,0,286.2992126, 340.1574803);
            $pdf = \PDF::loadView('PDF.boleto.2023_taquilla',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => '#aa2825'
            ])
            ->setPaper($tamanoPapel, 'portrait'); // tamaño de papel personalizado
            return base64_encode($pdf->stream('boletos_'.$venta->nNumero.'_parhikuni.pdf'));
        }elseif($formato == "DWN"){//DESCARGAR SIN VER
            $pdf = \PDF::loadView('PDF.boleto.2020_porNadia',[
                "venta" => $venta,
                "boletos" => $boletos,
                "tipoPuntoVenta" => "taquilla",
                "color" => '#aa2825'
            ])
            ->setPaper('letter', 'portrait');
            return $pdf->download('boletos_'.$venta->nNumero.'_parhikuni.pdf');
            // ->setPaper('letter', 'portrait')
        }
    }

    function boletosPreview(Venta $venta, $formato){
        $boletos = new BoletosVendidos();
        $boletos=$boletos->where("nVenta","=",$venta->nNumero)->get();
        return view("PDF.boleto.preview",[
            "venta" => $venta,
            "formato" => $formato,
            "boletos" => $boletos,
            "corridaIda" => CorridasDisponibles::find($venta->nCorridaIda),
            "corridaReg" => CorridasDisponibles::find($venta->nCorridaRegreso),
        ]);
    }
    function enviarBoletos(){
        //
    }
    function cancelarCompra(Request $request){
        // dd("cancelar");
        if(session()->has("ida_asientosID")){
            $desocupados=DisponibilidadAsientos::desocupar(session("ida_asientosID"));
        }
        if(session()->has("reg_asientosID")){
            $desocupados=DisponibilidadAsientos::desocupar(session("reg_asientosID"));
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
		session()->forget("cmpra_IDventa");

		session()->forget("ida_corrida");
		session()->forget("ida_disponibilidad");
		session()->forget("ida_origen");
		session()->forget("ida_destino");
		session()->forget("ida_pasajeros");
		session()->forget("ida_asientosID");
		session()->forget("ida_origenNombre");
		session()->forget("ida_destinoNombre");
		session()->forget("ida_fecha");

		session()->forget("reg_corrida");
		session()->forget("reg_disponibilidad");
		session()->forget("reg_origen");
		session()->forget("reg_destino");
		session()->forget("reg_pasajeros");
		session()->forget("reg_asientosID");
		session()->forget("reg_fecha");
		session()->forget("reg_origenNombre");
		session()->forget("reg_destinoNombre");
		
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
