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

use DB;
use Auth;
use Carbon\Carbon;
use PDF;

class CorridasDisponiblesController extends Controller
{
    public $elementsPerPage=15;

    public function index(Request $request){
        // dd($request->all());
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
        // dd($corridasDisponibles);
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
                SELECT cordis.nNumeroConductor FROM corridasdisponibles cordis WHERE cordis.aEstado IN ('A','S', 'R') GROUP BY cordis.nNumeroConductor
            )")
            ->orderBy("conductores.nNumeroConductor", "ASC")
            ->get();
            // ->toSql();
        // dd($conductores);

        return view('corridasDisponibles.edit',[
            "corridaDisponible" => $corridaDisponible,
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
            "estados" => CorridasEstados::orderBy("orden", "ASC")->get(),
            "autobuses" => Autobus::orderBy("nNumeroEconomico", "ASC")->get(),
            "conductores" => $conductores
        ]);
    }

    public function update(CorridasDisponibles $corridaDisponible, Request $request){
        if($corridaDisponible->aEstado="T" || $corridaDisponible->aEstado="C" || $corridaDisponible->aEstado="L"){
            return back()->withErrors("No se puede editar");
        }
        $data=array();
        if($request->estado=="DB"){
            $corridaDisponible->desbloquear();
            return back()->with('status', 'Corrida desbloqueada');
        }
        elseif(@$request->estado!=null){
            $data["aEstado"]=$request->estado;
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
        if(sizeof($data)==0){
            return back()->withErrors("No se especificaron cambios");
        }else{
            if(@$request->estado!=null){
                CorridasDisponiblesHistorial::create([
                    "corrida_disponible" => $corridaDisponible->nNumero,
                    "aEstadoAnterior" => $corridaDisponible->aEstado,
                    "aEstadoNuevo" => $data["aEstado"],
                    "user" => Auth::user()->id,
                ]);
            }
            $corridaDisponible->update($data);
            return back()->with('status', 'Actualizado con éxito');
        }
    }

    public function venta(){
        return view("venta.filtros");
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
                # dd("notificar baja ocupacion");
            }
            $corridaDisponible->update(["aEstado"=>"R"]);
            DB::table('registropasopuntos')->insert([
                "nCorrida" => $corridaDisponible->nNumero,
                "nConsecutivo" => 1,
                "fSalida" => date("Y-m-d H:i:s")
            ]);
            return redirect(route('corridas.disponibles.guiaPasajeros', $corridaDisponible))->with("status", "Corrida despachada");
        }
    }
    public function guiaPasajeros(CorridasDisponibles $corridaDisponible){
        // dd($corridaDisponible);
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
            // dd("1");
        }else{ //if($corridaDisponible->aEstado=="R"){
            return view('corridasDisponibles.puntosDeControl',[
                "corridaDisponible" => $corridaDisponible
            ]);
        }
    }
    public function registrarPuntoDeControl(CorridasDisponibles $corridaDisponible, Request $request){
        $conductor=conductores::find(1);
        if($conductor->nNumeroConductor==$request->contraseñaDeCondutor){
            $corridaDisponible->registrarPasoPunto();
            return back()->with("status", "Registrado");
        }else{
            return back()->withErrors("Registra la clave del conductor");
        }
    }

    public function checkpoint(){

    }
}
