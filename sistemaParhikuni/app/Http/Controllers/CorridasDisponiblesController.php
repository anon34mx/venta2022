<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;

use App\Models\CorridasDisponibles;
use App\Models\TiposServicios;
use App\Models\Itinerario;
use App\Models\CorridasEstados;
use App\Models\Autobus;
use App\Models\conductores;
use App\Models\CorridasDisponiblesHistorial;
use App\Models\RegistroPasoPuntos;
use App\Models\Oficinas;
use App\Models\Disponibilidad;
use App\Models\DisponibilidadAsientos;
use App\Models\TarifasTramo;
use App\Models\CorridasConductores;
use App\Models\Promociones;
use App\Models\BoletosVendidos;

use App\Http\Controllers\SmsController;

use DB;
use Auth;
use Carbon\Carbon;
use PDF;

date_default_timezone_set('Etc/GMT+6');
class CorridasDisponiblesController extends Controller
{
    public $elementsPerPage=15;

    public function index(Request $request){
        if(@$request->send==='reset'){
            $request->only([]);
        }
        $today=date('Y-m-d');
        $yesterday=date('Y-m-d', strtotime($today. ' -1 days'));

        $corridasDisponibles = CorridasDisponibles::
            whereRaw('timestamp(`fSalida`, hSalida) >=  DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 HOUR)');
        if (@$request->origen!='') {
            $corridasDisponibles=$corridasDisponibles->whereRaw('corridasdisponibles.nItinerario IN (SELECT iti.nItinerario FROM itinerario iti
                INNER JOIN tramos tr on tr.nNumero=iti.nTramo WHERE iti.nConsecutivo=1 and tr.nOrigen=$request->origen)');
        }
        if (@$request->destino!='') {
            $corridasDisponibles=$corridasDisponibles->whereRaw('corridasdisponibles.nItinerario IN (SELECT
                iti.nItinerario
                FROM itinerario iti
                INNER JOIN tramos tr on tr.nNumero=iti.nTramo
                WHERE nConsecutivo=(
                    SELECT
                    MAX(itiSub.nConsecutivo)
                    FROM itinerario itiSub
                    WHERE itiSub.nItinerario=iti.nItinerario
                )
                and tr.nDestino=$request->destino)');
        }
        if (@$request->tipoDeServicio!='') {
            $corridasDisponibles->where('nTipoServicio', '=', $request->tipoDeServicio);
        }
        if (@$request->fecha!='') {
            $corridasDisponibles->where('fSalida', '=', $request->fecha);
        }
        if (@$request->estado!='') {
            $corridasDisponibles->where('aEstado', '=', $request->estado);
        }
        if (@$request->autobus!='') {
            $corridasDisponibles->where('nNumeroAutobus', '=', $request->autobus);
        }
        $corridasDisponibles=$corridasDisponibles->orderBy('fSalida', 'ASC')
        ->orderBy('hSalida', 'ASC')
        ->paginate($this->elementsPerPage);
        // ->toSql();
        return view('corridasDisponibles.index',[
            'corridasDisponibles' => $corridasDisponibles,
            'tiposServicio' => TiposServicios::all(),
            'oficinas' => Oficinas::all(),
            'request' => $request->all(),
            'estadosCorridas' => CorridasEstados::all(),
            'today' => $today,
            'yesterday' => $yesterday,
            'autobuses' => Autobus::orderBy('nNumeroEconomico', 'ASC')->get(),
            'conductores' => conductores::orderBy('nNumeroPersona', 'ASC')->get()
        ]);
    }

    public function edit(CorridasDisponibles $corridaDisponible, Request $request){
        $oficina=null;
        if(Auth::user()->hasRole('Admin')){
            $oficina=$request->oficinaOrigen;
        }else{
            $oficina=Auth::user()->personas->nOficina;
        }
        $conductores=conductores::
            whereRaw('conductores.nNumeroConductor NOT IN (
                SELECT IF(cordis.nNumeroConductor is NULL, 0 , cordis.nNumeroConductor) FROM corridasdisponibles cordis WHERE cordis.aEstado IN ("A","S", "R") GROUP BY cordis.nNumeroConductor
            ) AND conductores.aEstado!="BA"')
            ->orderBy('conductores.nNumeroConductor', 'ASC')
            ->get();
        $estadoActual=$corridaDisponible->estadoActual($oficina);
        // dd($estadoActual);

        return view('corridasDisponibles.edit',[
            'corridaDisponible' => $corridaDisponible,
            'itinerarios' => Itinerario::unicosDetallado(),
            'servicios' => TiposServicios::all(),
            'estados' => CorridasEstados::orderBy('orden', 'ASC')->get(),
            'autobuses' => Autobus::orderBy('nNumeroEconomico', 'ASC')->get(),
            'conductores' => $conductores,
            'oficinaOrigen' => $oficina,
            'estadoActual' => $estadoActual,
        ]);
    }

    public function update(CorridasDisponibles $corridaDisponible, Request $request){
        $data=array();
        $oficina=null;
        if(Auth::user()->hasRole('Admin')){
            $oficina=$request->oficina;
        }else{
            $oficina=Auth::user()->personas->nOficina;
        }

        if(@$request->estado === 'C'){
            return $this->cancelarCorrida($corridaDisponible ,$oficina);
            exit;
        }
        if($corridaDisponible->aEstado === 'T' || $corridaDisponible->aEstado === 'C' || $corridaDisponible->aEstado === 'L'){
            return back()->withErrors('No se puede editar');
        }
        if($request->estado === 'DB'){
            $corridaDisponible->desbloquear();
            return back()->with('status', 'Corrida desbloqueada');
        }
        if($request->conductor!=null && $corridaDisponible->aEstado!='T' && $corridaDisponible->aEstado!='L' && $corridaDisponible->aEstado!='C'){ //
            $data['nNumeroConductor']=$request->conductor;
            $historialConductor=CorridasConductores::create([
                'nNumeroCorrida' => $corridaDisponible->nNumero,
                'nNumeroConductor' => $request->conductor,
                'nNumeroUsuario' => Auth::user()->id,
            ]);
        }
        if($corridaDisponible->nNumeroConductor==null && $request->conductor!=null){
            $data['aEstado']='A';
        }
        if($request->autobus != $corridaDisponible->nNumeroAutobus){
            $data['nNumeroAutobus'] = $request->autobus;
        }
        if(@$request->estado!=null && @$request->estado != $corridaDisponible->aEstado){
            $data['aEstado']=$request->estado;
        }
        // dd($corridaDisponible->enVenta($oficina));
        if(@$request->estado === 'S' && $corridaDisponible->enVenta($oficina)>0){
            return back()->withErrors('Se está realizando una venta en esta oficina.');
        }
        if(sizeof($data)===0){
            return back()->withErrors('No se especificaron cambios');
        }else{
            if(isset($data['aEstado'])){
                CorridasDisponiblesHistorial::create([
                    'corrida_disponible' => $corridaDisponible->nNumero,
                    'nNumeroOficina' => $oficina,
                    'aEstadoAnterior' => $corridaDisponible->aEstado,
                    'aEstadoNuevo' => $data['aEstado'],
                    'user' => Auth::user()->id,
                ]);
            }
            $corridaDisponible->update($data);
            return back()->with('status', 'Actualizado con éxito');
        }
    }

    public function despachar(CorridasDisponibles $corridaDisponible, Request $request){
        $asientosApartados=null;
        $oficina=null;
        $historial=null;
        $consecutivo=null;

        if(Auth::user()->hasRole('Admin')){
            $oficina=$request->oficina;
            $consecutivo=$request->consecutivo;
        }else{
            $oficina=Auth::user()->personas->nOficina;
            $consecutivo=((array)$corridaDisponible->getTramoOficina($oficina))['consecutivo'];
        }
        // dd($consecutivo);
        $historial=CorridasDisponiblesHistorial::where('corrida_disponible', '=', $corridaDisponible->nNumero)
        ->where('nNumeroOficina', '=', $oficina)
        ->first();
        if($corridaDisponible->aEstado === 'C'){
            return back()->withErrors('La corrida '.$corridaDisponible->nNumero.' está cancelada');
        }
        if($corridaDisponible->nNumeroConductor === null || $corridaDisponible->nNumeroAutobus === null){
            return redirect(route('corridas.disponibles.edit', $corridaDisponible))->withErrors('Para despachar, primero registra un conductor y autobus para esta corrida');
        }
        $disa=new DisponibilidadAsientos();
        $enProcesoDeCompra=$disa->enProcesoCompra($corridaDisponible->nNumero, $oficina);
        if(sizeof($enProcesoDeCompra)>0){// revisar que no se esté realizando una venta para esta corrida
            return back()->withErrors('Se está realizando una venta para esta corrida');
        }else{
            if(sizeof($corridaDisponible->boletos) < $corridaDisponible->servicio->ocupacioMinima){
                if(false){ // verifica si hay que mandar SMS de que hubo baja ocupacion
                    SmsController::corridaBajaOcupacion($corridaDisponible->nNumero);
                }
            }
            //actualizar historial
            CorridasDisponiblesHistorial::create([
                'corrida_disponible' => $corridaDisponible->nNumero,
                'nNumeroOficina' => $oficina,
                'aEstadoAnterior' => @$historial->aEstadoNuevo ?: 'D',
                'aEstadoNuevo' => 'R',
                'user' => Auth::user()->id,
            ]);
            // 'nConductor' => @$historial->nConductor ?: null,
            $corridaDisponible->update(['aEstado'=>'R']); #-- ver donde pongo este cambio
            // dd($request->all());
            $corridaDisponible->despachar($consecutivo);
            // registrar salida de punto de control[!?]
                
            return redirect(route('corridas.disponibles.guiaPasajeros', $corridaDisponible))->with('status', 'Corrida despachada');
        }
    }
    
    public function cancelarCorrida(CorridasDisponibles $corrida, $oficina){
        $pasajeros=new BoletosVendidos();
        $pasajeros->where('nCorrida', '=', $corrida->nNumero)->update([
            'aEstado'=>'LM'
        ]);
        CorridasDisponiblesHistorial::create([
            'corrida_disponible' => $corrida->nNumero,
            'nNumeroOficina' => $oficina,
            'aEstadoAnterior' => $corrida->aEstado,
            'aEstadoNuevo' => 'C',
            'user' => Auth::user()->id,
        ]);
        return redirect(route('boletos.limbo.show',$corrida))->with('status', 'Usuario creado');
    }
    
    public function guiaPasajeros(CorridasDisponibles $corridaDisponible){
        return view('corridasDisponibles.guiaPasajeros',[
            'corridaDisponible' => $corridaDisponible
        ]);
    }

    public function puntosDeControl(CorridasDisponibles $corridaDisponible){
        if($corridaDisponible->aEstado === 'D' || $corridaDisponible->aEstado === 'A' || $corridaDisponible->aEstado === 'S'){
            return redirect(route('corridas.disponibles.index',$corridaDisponible))->withErrors('La corrida no ha sido despachada');
        }else{ //if($corridaDisponible->aEstado === 'R'){
            return view('corridasDisponibles.puntosDeControl',[
                'corridaDisponible' => $corridaDisponible
            ]);
        }
    }

    public function registrarPuntoDeControl(CorridasDisponibles $corridaDisponible, Request $request){
        $conductor=conductores::find($corridaDisponible->nNumeroConductor);
        if($conductor->nNumeroConductor === $request->contraseñaDeCondutor){
            if($corridaDisponible->registrarPasoPunto()){
                return back()->with('status', 'Registrado');
            }else{
                return back()->with('error', 'No se registraron cambios');
            }
        }else{
            return back()->withErrors('Registra la clave del conductor');
        }
    }

    public function itinerario(CorridasDisponibles $corridaDisponible){
        return json_encode($corridaDisponible->getItinerario());
    }

    public function recorrido(CorridasDisponibles $corridaDisponible, $origen, $destino){
        // return json_encode($corridaDisponible->getRecorrido());
        $html='';
        $recorridos = $corridaDisponible->getRecorrido($origen,$destino);
        $lon=sizeof($recorridos)-1;
        $cont=0;

        foreach($recorridos as $tramo){
            if($cont<$lon){
                $html.=$this->renderPuntoRecorrido($tramo->origenNombre, $tramo->hSalida);
            }else{
                $html.=$this->renderPuntoRecorrido($tramo->origenNombre, $tramo->hSalida);
                $html.=$this->renderPuntoRecorrido($tramo->destinoNombre, $tramo->hLlegada);
            }
            $cont++;
        }
        return '<div class="row col-12">'.$html.'</div>';
    }

    private function renderPuntoRecorrido($oficina, $hora){
        return '<div class="row col-6">
            <div class="col-12">'.$oficina.'</div>
            <div class="col-12">'.$hora.'</div>
        </div><br>';
    }

    public function renderDiagramaYocupacion($asientosOcupados){
        $contAuxAsien=0;
        $sizeAsientos=sizeof($asientosOcupados);

        $html='<table id="asientos-ida" class="tbl-diagrama-bus mx-auto mt-2" style="
                    max-width: 300px;
                    margin: auto;
                    ">
                    <tr>
                        <td>
                            <img alt="" style="" width="34"
                                class="logo-color mx-auto my-0" src="{{ Vite::asset("resources/images/diagramaAutobus/Conductor.png") }}">
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>';

            foreach(explode("|" ,$cordis->autobus->distribucionAsientos->aDistribucion) as $row){
                $html.='<tr>';
                    foreach(explode(",",$row) as $col){
                        $html.='<td>';
                            if($col=="00")
                                $html.='<div class="pasillo"></div>';
                            elseif($col=="PU")
                                $html.='<div class="pasillo">
                                    <img width="100%" src="{{ Vite::asset("resources/images/diagramaAutobus/puerta.png") }}" alt="Baño de hombres">
                                </div>';
                            elseif($col=="BU")
                                $html.='<div class="pasillo">
                                    <img width="100%" src="{{ Vite::asset("resources/images/diagramaAutobus/Baños Unisex.png") }}" alt="Baño de hombres">
                                </div>';
                            elseif($col=="BH")
                                $html.='<div class="pasillo">
                                    <img width="100%" src="{{ Vite::asset("resources/images/diagramaAutobus/Bano_h.png") }}" alt="Baño de hombres">
                                </div>';
                            elseif($col=="BM")
                                $html.='<div class="pasillo">
                                    <img width="100%" src="{{ Vite::asset("resources/images/diagramaAutobus/Bano_m.png") }}" alt="Baño de mujeres">
                                </div>';
                                elseif($col=="CA")
                                $html.='<div class="pasillo">
                                    <img width="100%" src="{{ Vite::asset("resources/images/diagramaAutobus/Cafeteria.png") }}" alt="Cafetera">
                                </div>';
                            else{
                                $numAsiento=substr($col,0,2);
                                $ocupado=0;
    
                                if( $asientosOcupados[$numAsiento]){
                                    if(strpos($col,"T")>0){
                                        $html.='<div id="asiento-{{$numAsiento}}" class="asiento tv ocupado" numero="{{$numAsiento}}">
                                            <span>{{$numAsiento}}</span>
                                            <br>
                                            <sub>tv</sub>
                                        </div>';
                                    }else{
                                        $html.='<div id="asiento-{{$numAsiento}}" class="asiento ocupado" numero="{{$numAsiento}}">
                                            <span>{{$numAsiento}}</span>
                                            <br>
                                            <sub></sub>
                                        </div>';
                                    }
                                    $contAuxAsien=$contAuxAsien+1;
                                }
                                else{
                                    if(strpos($col,"T")>0)
                                        $html.='<div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                            <span>{{"$numAsiento"}}</span>
                                            <br>
                                            <sub>tv</sub>
                                        </div>';
                                    else{
                                        $html.='<div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                            <span>{{$numAsiento}}</span>
                                            <br>
                                            <sub></sub>
                                        </div>';
                                    }
                                }
                            }
                        $html.='</td>';
                    }
                $html.='</tr>';
            }
            
            $html.='<tr>
                <td colspan="5">
                    <img src="{{ Vite::asset("resources/images/servicios/".$cordis->servicio->aClave.".png") }}" alt="">
                </td>
            </tr>
            <tr>
                <td colspan="5">
                    <div class="py-1" style="display: flex;justify-content: space-around;margin: 0 15px;border: 3px solid black;padding: 0 44px;">';
            foreach($cordis->servicio->serviciosAbordo() as $sab){
                $html.='<img src="{{Vite::asset("resources/images/diagramaAutobus/".$sab->imagen)}}" width="40"
                    alt="{{$sab->descripcion}}" style="display:block;">';
            }
            $html.='</div>
                </td>
            </tr>
        </table>';
    }

    public function getProxCorridas(CorridasDisponibles $corrida, $nOrigen, $nDestino){
        // dd($corrida);
        CorridasDisponibles::getProxCorridas($corrida->nNumero, $corrida->fSalida, $corrida->hSalida, $corrida->nTipoServicio, $nOrigen, $nDestino);
    }
    public function filtradas(Request $request){
        // dd($request->all());
        // ($corrida=null, $origen=null, $destino=null, $fechaSalida=null, $fechaMax=null, $pasajeros=null,
        // $hInicio="00:00:00", $hFin=null, $usarPromocion=null, $limit=999, $tipoBusqueda="exacta")
        $cordis=new CorridasDisponibles();
        $rs=$cordis->filtrar($request->corrida, $request->origen, $request->destino, $request->fechaSalida, $request->fechaMax, $request->cantidadPasajeros,
            $request->hInicio, $request->hFin, $request->usarPromocion, $request->limit, @$request->tipoBusqueda ?: "exacta", $request->claseServ
            );
        // dd($rs[0]);
        echo json_encode($rs);
    }
}
