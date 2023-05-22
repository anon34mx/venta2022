<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\PeriodosVacacionales;

class PerodiodosVacacionalesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // dd(PeriodosVacacionales::all());
        return view('periodosvacacionales.index',[
            'periodos' => PeriodosVacacionales::orderBy('inicio', 'DESC')->get(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(){

    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request){
        try{
            // $request->validate([
            //     'fechaInicio' => 'required',
            //     // 'fechaInicio' => 'required|date_format:d/m/Y|regex:/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/',
            //     'fechaFin' => 'required|date|after:fechaInicio',
            // ]);
            PeriodosVacacionales::create([
                'inicio' => $request->fechaInicio,
                'fin' => $request->fechaFin,
            ]);
            return back()->with('status', 'Guardado');
        }catch(Exception $e){
            return back()->withErrors('Error al guardar');
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(PeriodosVacacionales $id)
    {
        try {
            $id->delete();
            return back()->with('status', 'Eliminado');
        } catch (\Throwable $th) {
            // throw $th;
            return back()->withErrors('Error al eliminar');
        }
    }
}
