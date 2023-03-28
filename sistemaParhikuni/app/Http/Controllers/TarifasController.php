<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\TarifasTramo;
use App\Models\Oficinas;
use App\Models\TiposServicios;

class TarifasController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tarifas=TarifasTramo::all()->sortBy("nTipoServicio, nOrigen, nDestino");
        return view('tarifas.index',[
            "tarifas" => $tarifas,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('tarifas.create',[
            "oficinas" => Oficinas::where("lDestino", "=", true)->get(),
            "TiposServicios" => TiposServicios::all(),
            // "tarifas" => $tarifas,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $tarifasNvas=TarifasTramo::create([
                "nTipoServicio" => $request->claseDeServicio,
                "nOrigen" => $request->origen,
                "nDestino" => $request->destino,
                "nMontoBaseRuta" => $request->tarifaBaseRuta,
                "nMontoBasePaqueteria" => $request->tarifaBasePaqueteria,
                "fAplicacion" => $request->fechaAplicacion,
            ]);
            return redirect(route('tarifas.index'))->with("status", "Guardado");
        } catch (\Throwable $th) {
            throw $th;
            return back()->withErrors("Error al guardar");
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
        dd("show");
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(TarifasTramo $idTarifa){
        return view('tarifas.edit',[
            "oficinas" => Oficinas::where("lDestino", "=", true)->get(),
            "TiposServicios" => TiposServicios::all(),
            "tarifa" => $idTarifa,
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request,TarifasTramo $idTarifa)
    {
        try {
            $idTarifa->update([
                "nTipoServicio" => $request->claseDeServicio,
                "nOrigen" => $request->origen,
                "nDestino" => $request->destino,
                "nMontoBaseRuta" => $request->tarifaBaseRuta,
                "nMontoBasePaqueteria" => $request->tarifaBasePaqueteria,
                "fAplicacion" => $request->fechaAplicacion,
            ]);
            return redirect(route('tarifas.index'))->with("status", "Guardado");
        } catch (\Throwable $th) {
            return back()->withErrors("Error al guardar");
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
