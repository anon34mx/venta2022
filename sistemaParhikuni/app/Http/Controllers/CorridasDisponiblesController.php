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
use App\Models\Promociones;

use App\Http\Controllers\SmsController;

use DB;
use Auth;
use Carbon\Carbon;
use PDF;

class CorridasDisponiblesController extends Controller
{
    public $elementsPerPage=15;

    public function index(Request $request){
        if(@$request->send=="reset"){
            $request->only([]);
        }
        $today=date('Y-m-d');
        $yesterday=date('Y-m-d', strtotime($today. ' -1 days'));
        // $corridasDisponibles = CorridasDisponibles::
        //     whereRaw('timestamp(`fSalida`, hSalida) >=  DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 HOUR)')
        //     ->orderBy("fSalida", "ASC")
        //     ->orderBy("hSalida", "ASC")
        //     ->paginate($this->elementsPerPage);

        $corridasDisponibles = CorridasDisponibles::
            whereRaw('timestamp(`fSalida`, hSalida) >=  DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 HOUR)');
        if (@$request->origen!="") {
            $corridasDisponibles=$corridasDisponibles->whereRaw("corridasdisponibles.nItinerario IN (SELECT iti.nItinerario FROM itinerario iti
                INNER JOIN tramos tr on tr.nNumero=iti.nTramo WHERE iti.nConsecutivo=1 and tr.nOrigen=$request->origen)");
        }
        if (@$request->destino!="") {
            $corridasDisponibles=$corridasDisponibles->whereRaw("corridasdisponibles.nItinerario IN (SELECT
                iti.nItinerario
                FROM itinerario iti
                INNER JOIN tramos tr on tr.nNumero=iti.nTramo
                WHERE nConsecutivo=(
                    SELECT
                    MAX(itiSub.nConsecutivo)
                    FROM itinerario itiSub
                    WHERE itiSub.nItinerario=iti.nItinerario
                )
                and tr.nDestino=$request->destino)");
        }
        if (@$request->tipoDeServicio!="") {
            $corridasDisponibles->where('nTipoServicio', '=', $request->tipoDeServicio);
        }
        if (@$request->fecha!="") {
            $corridasDisponibles->where('fSalida', '=', $request->fecha);
        }
        if (@$request->estado!="") {
            $corridasDisponibles->where('aEstado', '=', $request->estado);
        }
        if (@$request->autobus!="") {
            $corridasDisponibles->where('nNumeroAutobus', '=', $request->autobus);
        }
        $corridasDisponibles=$corridasDisponibles->orderBy("fSalida", "ASC")
        ->orderBy("hSalida", "ASC")
        ->paginate($this->elementsPerPage);
        // ->toSql();
        return view('corridasDisponibles.index',[
            "corridasDisponibles" => $corridasDisponibles,
            "tiposServicio" => TiposServicios::all(),
            "oficinas" => Oficinas::all(),
            "request" => $request->all(),
            "estadosCorridas" => CorridasEstados::all(),
            "today" => $today,
            "yesterday" => $yesterday,
            "autobuses" => Autobus::orderBy("nNumeroEconomico", "ASC")->get(),
            "conductores" => conductores::orderBy("nNumeroPersona", "ASC")->get()
        ]);
    }

    public function edit(CorridasDisponibles $corridaDisponible){
        $conductores=conductores::
            whereRaw("conductores.nNumeroConductor NOT IN (
                SELECT IF(cordis.nNumeroConductor is NULL, 0 , cordis.nNumeroConductor) FROM corridasdisponibles cordis WHERE cordis.aEstado IN ('A','S', 'R') GROUP BY cordis.nNumeroConductor
            )")
            ->orderBy("conductores.nNumeroConductor", "ASC")
            ->get();

        return view('corridasDisponibles.edit',[
            "corridaDisponible" => $corridaDisponible,
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
            "estados" => CorridasEstados::orderBy("orden", "ASC")->get(),
            "autobuses" => Autobus::orderBy("nNumeroEconomico", "ASC")->get(),
            "conductores" => $conductores,
        ]);
    }

    public function update(CorridasDisponibles $corridaDisponible, Request $request){
        $data=array();
        if($corridaDisponible->aEstado=="T" || $corridaDisponible->aEstado=="C" || $corridaDisponible->aEstado=="L"){
            return back()->withErrors("No se puede editar");
        }
        if($request->estado=="DB"){
            $corridaDisponible->desbloquear();
            return back()->with('status', 'Corrida desbloqueada');
        }
        if($request->conductor!=null && $corridaDisponible->aEstado!="T" && $corridaDisponible->aEstado!="L" && $corridaDisponible->aEstado!="C"){ //
            $data["nNumeroConductor"]=$request->conductor;
        }
        if($corridaDisponible->nNumeroConductor==null && $request->conductor!=null){
            $data["aEstado"]="A";
        }
        if($request->autobus != $corridaDisponible->nNumeroAutobus){
            $data["nNumeroAutobus"] = $request->autobus;
        }
        if(@$request->estado!=null && @$request->estado != $corridaDisponible->aEstado){
            $data["aEstado"]=$request->estado;
        }
        if(sizeof($data)==0){
            return back()->withErrors("No se especificaron cambios");
        }else{
            //#
            if(isset($data["aEstado"])){
                CorridasDisponiblesHistorial::create([
                    "corrida_disponible" => $corridaDisponible->nNumero,
                    "aEstadoAnterior" => $corridaDisponible->aEstado,
                    "aEstadoNuevo" => $data["aEstado"],
                    "user" => Auth::user()->id,
                    "nConsecutivo" => $corridaDisponible->getTramoOficina( $request->oficina)->consecutivo
                ]);
            }
            $corridaDisponible->update($data);
            return back()->with('status', 'Actualizado con éxito');
        }
    }

    public function despachar(CorridasDisponibles $corridaDisponible, Request $request){
        if($corridaDisponible->aEstado=="C"){
            return back()->withErrors("La corrida ".$corridaDisponible->nNumero." está cancelada");
        }
        if($corridaDisponible->nNumeroConductor==null || $corridaDisponible->nNumeroAutobus==null){
            return redirect(route('corridas.disponibles.edit', $corridaDisponible))->withErrors("Para despachar, primero registra un conductor y autobus para esta corrida");
        }

        if(false){// revisar que no se esté realizando una venta para esta corrida
            return back()->withErrors("Se está realizando una venta para esta corrida");
        }else{
            if(sizeof($corridaDisponible->boletos) < $corridaDisponible->servicio->ocupacioMinima){
                if(false){ // verifica si hay que mandar SMS de que hubo baja ocupacion
                    SmsController::corridaBajaOcupacion($corridaDisponible->nNumero);
                }
            }
            $corridaDisponible->update(["aEstado"=>"R"]); #-- ver donde pongo este cambio
            $corridaDisponible->despachar($request->consecutivo);
                
            return redirect(route('corridas.disponibles.guiaPasajeros', $corridaDisponible))->with("status", "Corrida despachada");
        }
    }
    
    public function guiaPasajeros(CorridasDisponibles $corridaDisponible){
        // if($request->mode=="Descargar"){
        //     $pdf = PDF::loadView('corridasDisponibles.guiaPasajeros', ["corridaDisponible" => $corridaDisponible]);
        //     return $pdf->download('articles.pdf');
        // }elseif($request->mode=="Ver pdf"){
        //     $pdf = PDF::loadView('corridasDisponibles.guiaPasajeros', ["corridaDisponible" => $corridaDisponible]);
        //     $pdf->render();
        //     return $pdf->stream();
        // }else{
        //     return view("corridasDisponibles.guiaPasajeros",[
        //         "corridaDisponible" => $corridaDisponible
        //     ]);
        // }
        return view("corridasDisponibles.guiaPasajeros",[
                "corridaDisponible" => $corridaDisponible
            ]);
    }

    public function puntosDeControl(CorridasDisponibles $corridaDisponible){
        if($corridaDisponible->aEstado=="D" || $corridaDisponible->aEstado=="A" || $corridaDisponible->aEstado=="S"){
            return redirect(route("corridas.disponibles.index",$corridaDisponible))->withErrors("La corrida no ha sido despachada");
        }else{ //if($corridaDisponible->aEstado=="R"){
            return view('corridasDisponibles.puntosDeControl',[
                "corridaDisponible" => $corridaDisponible
            ]);
        }
    }

    public function registrarPuntoDeControl(CorridasDisponibles $corridaDisponible, Request $request){
        $conductor=conductores::find(1);
        if($conductor->nNumeroConductor==$request->contraseñaDeCondutor){
            
            if($corridaDisponible->registrarPasoPunto()){
                return back()->with("status", "Registrado");
            }else{
                return back()->with("error", "No se registraron cambios");
            }
        }else{
            return back()->withErrors("Registra la clave del conductor");
        }
    }

    public function itinerario(CorridasDisponibles $corridaDisponible){
        return json_encode($corridaDisponible->getItinerario());
    }

    public function recorrido(CorridasDisponibles $corridaDisponible, $origen, $destino){
        // return json_encode($corridaDisponible->getRecorrido());
        $html="";
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
            /*
                if($cont==0){
                    echo($tramo->origenNombre);
                    echo($tramo->hSalida);
                    echo "<br>";
                }
                elseif($cont==$lon){
                    echo($tramo->destinoNombre);
                    echo($tramo->hLlegada);
                    echo "<br>";
                }else{
                    echo($tramo->origenNombre);
                    echo($tramo->hLlegada);
                    echo "<br>";

                    echo($tramo->destinoNombre);
                    echo($tramo->hLlegada);
                    echo "<br>";
                }
            */
            $cont++;
        }
        return "<div class=\"row col-12\">".$html."</div>";
    }

    private function renderPuntoRecorrido($oficina, $hora){
        return "<div class=\"row col-6\">
            <div class=\"col-12\">$oficina</div>
            <div class=\"col-12\">$hora</div>
        </div><br>";
    }
}
