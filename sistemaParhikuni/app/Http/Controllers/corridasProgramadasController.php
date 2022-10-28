<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Oficinas;
use App\Models\Corridasprogramadas;
use App\Models\CorridasVersiones;
use App\Models\TiposServicios;
use App\Models\Itinerario;
use DB;
use Auth;

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
            'itinerario' => 'required|integer',
            'tipoDeServicio' => 'required|integer',
            'horaDeSalida' => 'required|date_format:H:i',
            'fechaDeInicio' => 'required|date',
            'fechaDeFin' => 'required|date|after:fechaDeInicio',
            'dias' => 'required',
        ],[
            'dias.required' => 'Elige al menos un día',
        ]);

        $nuevaCorrida = Corridasprogramadas::create([
            "nItinerario" => $request->itinerario,
            "nTipoServicio" => $request->tipoDeServicio,
            "hSalida" => $request->horaDeSalida,
            "lLunes" => (isset($request->dias["lLunes"])) ? 1:0,
            "lMartes" => (isset($request->dias["lMartes"])) ? 1:0,
            "lMiercoles" => (isset($request->dias["lMiercoles"])) ? 1:0,
            "lJueves" => (isset($request->dias["lJueves"])) ? 1:0,
            "lViernes" => (isset($request->dias["lViernes"])) ? 1:0,
            "lSabado" => (isset($request->dias["lSabado"])) ? 1:0,
            "lDomingo" => (isset($request->dias["lDomingo"])) ? 1:0,
            "fInicio" => $request->fechaDeInicio,
            "fFin" => $request->fechaDeFin,
        ]);
        DB::select("SELECT corridasPorDia(CURRENT_DATE, 30)");
        
        // return back()->with('status', 'La corrida y su información relacionada se registró con éxito.');
         return redirect()
            ->route('corridas.programadas.show', $nuevaCorrida)
            ->with("status","La corrida y su información relacionada se registró con éxito.");
    }

    public function show($corridaProgramada){
        $corrida = Corridasprogramadas::find($corridaProgramada);
        // dd($corrida);
        // dd($corrida->getItinerario());
        // dd(Itinerario::unicosDetallado());
        
        return view('corridasProgramadas.show',[
            "corridaProgramada" => Corridasprogramadas::find($corridaProgramada),
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
        ]);
    }

    public function edit(Corridasprogramadas $corridaProgramada){
        //Vista para transferir
        return view('corridasProgramadas.transfer',[
            "corridaProgramada" => $corridaProgramada,
            "itinerarios" => Itinerario::unicosDetallado(),
            "servicios" => TiposServicios::all(),
        ]);
    }

    public function destroy(Corridasprogramadas $corridaProgramada, Request $request){
        $corridaProgramada->cancelar();
        $corridaProgramada->delete();
        return back()->with('status', 'Eliminado con éxito');
    }

    public function update(Corridasprogramadas $corridaProgramada, Request $request){
        // Guardar transferencia de corrida
        $validated = $request->validate([
            'itinerario' => 'required|integer',
            'tipoDeServicio' => 'required|integer',
            'horaDeSalida' => 'required|date_format:H:i',
            'fechaDeInicio' => 'required|date',
            'fechaDeFin' => 'required|date|after:fechaDeInicio',
            'dias' => 'required',
        ],[
            'dias.required' => 'Elige al menos un día',
        ]);
        $version = CorridasVersiones::create([
            'nNumero' => $corridaProgramada->nNumero,
            'nItinerario' => $corridaProgramada->nItinerario,
            'nTipoServicio' => $corridaProgramada->nTipoServicio,
            'hSalida' => $corridaProgramada->hSalida,
            'lLunes' => $corridaProgramada->lLunes,
            'lMartes' => $corridaProgramada->lMartes,
            'lMiercoles' => $corridaProgramada->lMiercoles,
            'lJueves' => $corridaProgramada->lJueves,
            'lViernes' => $corridaProgramada->lViernes,
            'lSabado' => $corridaProgramada->lSabado,
            'lDomingo' => $corridaProgramada->lDomingo,
            'fInicio' => $corridaProgramada->fInicio,
            'fFin' => $corridaProgramada->fFin,
            'user_id' => Auth::user()->id
        ]);
        $nuevaCorrida = Corridasprogramadas::create([
            'nItinerario' => $request->itinerario,
            'nTipoServicio' => $request->tipoDeServicio,
            'hSalida' => $request->horaDeSalida,
            'lLunes' => (isset($request->dias["lLunes"])) ? true : false,
            'lMartes' => (isset($request->dias["lMartes"])) ? true : false,
            'lMiercoles' => (isset($request->dias["lMiercoles"])) ? true : false,
            'lJueves' => (isset($request->dias["lJueves"])) ? true : false,
            'lViernes' => (isset($request->dias["lViernes"])) ? true : false,
            'lSabado' => (isset($request->dias["lSabado"])) ? true : false,
            'lDomingo' => (isset($request->dias["lDomingo"])) ? true : false,
            'fInicio' => $request->fechaDeInicio,
            'fFin' => $request->fechaDeFin,
            'version' => $corridaProgramada->version+1,
        ]);

        $corridaProgramada->cancelar();

        // MOSTAR PASAJEROS EN LIMBO (VENDIDOS QUE QUEDARON SIN CORRIDA)
        return redirect()
            ->route('corridas.programadas.show', $nuevaCorrida)
            ->with("status","Corrida transferida con éxito");
    }
}
