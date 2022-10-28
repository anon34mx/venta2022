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

use DB;
use Auth;
use Carbon\Carbon;

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
        elseif($request->estado=="B" || $request->estado=="C"){
            $corridaDisponible->cambiarEstado($request->estado);
            return back()->with('status', 'Actualizado con éxito');
        }else{
            if($request->conductor!=null && $corridaDisponible->aEstado=="D" || $corridaDisponible->aEstado=="A"){
                $data["aEstado"]="A";
                $data["nNumeroConductor"]=$request->conductor;
            }
            if($request->autobus != $corridaDisponible->nNumeroAutobus){
                $data["nNumeroAutobus"] = $request->autobus;
            }
            if(sizeof($data)==0){
                return back()->withErrors("No se especificaron cambios");
            }else{
                $corridaDisponible->update($data);
                CorridasDisponiblesHistorial::create([
                    "corrida_disponible" => $corridaDisponible->nNumero,
                    "aEstadoAnterior" => $corridaDisponible->aEstado,
                    "aEstadoNuevo" => $data["aEstado"],
                    "user" => Auth::user()->id,
                ]);
                return back()->with('status', 'Actualizado con éxito');
            }
        }
    }

    public function venta(){
        return view("venta.filtros");
    }
}
