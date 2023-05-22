<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Conductores;
use App\Models\Autobus;
use App\Models\Oficinas;
use App\Models\PersonasEstado;
use App\Models\Personas;
use Auth;

class ConductoresController extends Controller
{
    public function index(){
        // dd(PersonasEstado::all());
        return view('personal.conductores.index',[
            'conductores' => Conductores::all(),
            'autobuses' => Autobus::all()
        ]);
    }

    public function edit(Conductores $conductor){
        if(Auth::user()->hasRole('Admin')){
            return view('personal.conductores.edit',[
                'conductor' => $conductor,
                'oficinas' => oficinas::all(),
                'personasEstado' => PersonasEstado::all(),
                'autobuses' => Autobus::all()
            ]);
        }elseif(Auth::user()->hasRole('servicios')){
            return view('personal.conductores.edit',[
                'conductor' => $conductor,
                'oficinas' => oficinas::all(),
                'personasEstado' => PersonasEstado::all(),
                'autobuses' => Autobus::all()
            ]);
        }
    }

    public function update(Conductores $conductor, Request $request){
        // dd($conductor);
        // dd($request->except('_token'));

        if(Auth::user()->can('personas.update')){
            $persona=Personas::find($conductor->nNumeroPersona)
            ->update([
                'aNombres' => $request->nombre,
                'aApellidos' => $request->apellidos,
                'nOficina' => $request->oficina,
            ]);
        }
        if(Auth::user()->can('personal.conductores.update')){
            $conductor->update([
                'aLicencia' => $request->numeroDeLicencia,
                'fVigenciaLicencia' => $request->fechaVigenciaLicencia,
                'aEstado' => $request->estado,
                'nNumeroAutobus' => $request->autobus,
            ]);
        }
        return back()->with('status', 'Actualizado');
    }
}