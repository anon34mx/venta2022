<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Oficinas;
use App\Models\Corridasprogramadas;
use App\Models\TiposServicios;
use App\Models\Itinerario;
use DB;

class corridasProgramadasController extends Controller
{
    public function index(){
        $corridasProgramadas=Corridasprogramadas::paginate(20);

        return view('corridasProgramadas.index',[
            "corridasProgramadas" => $corridasProgramadas,
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
        ]);
    }

    public function store(Request $request){
        $validated = $request->validate([
            'itinerario' => 'required',
            'tipoDeServicio' => 'required',
            'horaDeSalida' => 'required',
            'fechaDeInicio' => 'required',
            'fechaDeFin' => 'required',
            'dias' => 'required',
        ],[
            'dias.required' => 'Elige al menos un día',
        ]);

        Corridasprogramadas::create([
            "nItinerario" => $request->itinerario,
            "nTipoServicio" => $request->tipoDeServicio,
            "hSalida" => $request->horaDeSalida,
            "lLunes" => (isset($request->dias["lLunes"])) ? 1:0,
            "lMartes" => (isset($request->dias["lMartes"])) ? 1:0,
            "lMiercoles" => (isset($request->dias["lMiercoles"])) ? 1:0,
            "lJueves" => (isset($request->dias["ljueves"])) ? 1:0,
            "lViernes" => (isset($request->dias["lViernes"])) ? 1:0,
            "lSabado" => (isset($request->dias["lSabado"])) ? 1:0,
            "lDomingo" => (isset($request->dias["lDomingo"])) ? 1:0,
            "fInicio" => $request->fechaDeInicio,
            "fFin" => $request->fechaDeFin,
        ]);
        DB::select("SELECT corridasPorDia(CURRENT_DATE, 30)");
        
        return back()->with('status', 'La corrida y su información relacionada se registró con éxito.');
    }

    public function edit($corridaProgramada){
        $corrida = Corridasprogramadas::find($corridaProgramada);
        // dd($corrida);
        // dd($corrida->getItinerario());
        // dd(Itinerario::unicosDetallado());
        
        return view('corridasProgramadas.edit',[
            "corridaProgramada" => Corridasprogramadas::find($corridaProgramada),
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
        ]);
    }

    public function destroy(Corridasprogramadas $corridaProgramada, Request $request){
        $corridaProgramada->delete();
        return back()->with('status', 'Eliminado con éxito');
    }
}
