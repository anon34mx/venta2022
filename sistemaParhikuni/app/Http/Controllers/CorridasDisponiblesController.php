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

use DB;
use Auth;
use Carbon\Carbon;
use PDF;

class CorridasDisponiblesController extends Controller
{
    public $elementsPerPage=15;

    public function index(){
        $corridasDisponibles = CorridasDisponibles::
            // whereDate('fSalida', '>=', Carbon::now()->addDays(-1)->toDateString())
            // whereRaw('timestamp(`fSalida`, hSalida) >= DATE_SUB( CURRENT_TIMESTAMP, INTERVAL 12 HOUR) AND fSalida>=DATE_SUB( CURRENT_DATE, INTERVAL 1 DAY)')
            whereRaw('timestamp(`fSalida`, hSalida) >=  DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 24 HOUR)')
            ->orderBy("fSalida", "ASC")
            ->orderBy("hSalida", "ASC")
            ->paginate($this->elementsPerPage);
            // ->toSql();
            // ->get();
        // dd($corridasDisponibles);
        return view('corridasDisponibles.index',[
            "corridasDisponibles" => $corridasDisponibles
        ]);
    }

    public function edit(CorridasDisponibles $corridaDisponible){
        // dd($corridaDisponible->estado);
        // dd(CorridasDisponibles::find($corridasDisponible));
        // dd(CorridasEstados::all()[0]->aEstado);
        // dd(Autobus::all());
        return view('corridasDisponibles.edit',[
            "corridaDisponible" => $corridaDisponible,
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
            "estados" => CorridasEstados::orderBy("orden", "ASC")->get(),
            "autobuses" => Autobus::orderBy("nNumeroEconomico", "ASC")->get(),
            "conductores" => conductores::orderBy("nNumeroPersona", "ASC")->get()
        ]);
    }

    public function update(CorridasDisponibles $corridaDisponible, Request $request){
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
                "fLlegada" => date("Y-m-d H:i:s"), #--  cambiar por now, dato de mysql
                "fSalida" => date("Y-m-d H:i:s") #--    cambiar por now, dato de mysql
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
        // dd($corridaDisponible->puntosDeControl());
        return view('corridasDisponibles.puntosDeControl',[
            "corridaDisponible" => $corridaDisponible
        ]);
    }
    public function checkpoint(){

    }
}
