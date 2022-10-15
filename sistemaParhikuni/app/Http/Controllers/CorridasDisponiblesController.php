<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\CorridasDisponibles;
use App\Models\TiposServicios;
use App\Models\Itinerario;
use App\Models\CorridasEstados;
use App\Models\Autobus;
use App\Models\conductores;

use DB;
use Carbon\Carbon;

class CorridasDisponiblesController extends Controller
{
    public $elementsPerPage=15;

    public function index(){
        $corridasDisponibles = CorridasDisponibles::
            whereDate('fSalida', '>=', Carbon::now()->addDays(-1)->toDateString())
            // ->whereDate('fSalida', '<=', Carbon::now()->addDays(60)->toDateString()) // valorar
            // ->toSql();
            ->orderBy("fSalida", "ASC")
            ->orderBy("hSalida", "ASC")
            ->paginate($this->elementsPerPage);
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
        // dd($request->all());
        if(isset($request->estado)){
            $corridaDisponible->update([
                "aEstado"=> $request->estado,
                "nNumeroAutobus"=> $request->autobus,
                "nNumeroConductor"=> $request->conductor,
            ]);
        }else{
            $corridaDisponible->update([
                "nNumeroAutobus"=> $request->autobus,
                "nNumeroConductor"=> $request->conductor,
            ]);
        }

        return back()->with('status',"Actualizado con éxito");
    }

    public function venta(){
        return view("venta.filtros");
    }
}
