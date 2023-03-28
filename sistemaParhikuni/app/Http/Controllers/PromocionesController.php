<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\TipoPasajero;
use App\Models\Promociones;
use App\Models\Oficinas;
use App\Models\TiposServicios;

class PromocionesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $promociones=Promociones::all();
        
        // dd($promociones);
        return view('promociones.index',[
            "promociones" => $promociones,
            
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        // "tiposPasajeros" => TipoPasajero::selectRaw("*, CAST(aClave as CHAR) as casted")->get(),
        return view('promociones.create',[
            "tiposPasajeros" => TipoPasajero::all(),
            "oficinas" => Oficinas::all(),
            "tiposServicios" => TiposServicios::all(),
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
        // dd($request->all());
        try {
            $nvaPromo=Promociones::create([
                "aTipo" => @$request->tipoPasajero ?: null,
                "aDescripcion" => @$request->descripcion,
                "nDescuento" => @$request->descuento,
                "nCorridaProgramada" => @$request->corridaProgramada,
                "nOficina" => @$request->areaDeVenta,
                "nOrigen" => @$request->origen,
                "nDestino" => @$request->destino,
                "viajeRedondo" => $request->aplicarPromoA=="viajeRedondo" ? true : false,
                "fInicio" => @$request->fechaDeInicio,
                "fFin" => @$request->fechaDeFin,
                "nTipoServicio" => @$request->tipoDeServicio,
            ]);
            return redirect(route("corridas.promociones.index"))->with("status", "Guardado");
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
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Promociones $promocion)
    {
        return view("promociones.edit",[
            "promocion" => $promocion
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Promociones $promocion)
    {

        try {
            $request->validate([
                'descripcion' => 'required',
                'descuento' => 'required',
                'fechaDeInicio' => 'required',
                'fechaDeFin' => 'required',
            ]);
            $promocion->update([
                "aDescripcion" => $request->descripcion,
                "nDescuento" => $request->descuento,
                "fInicio" => $request->fechaDeInicio,
                "fFin" => $request->fechaDeFin,
            ]);
            return redirect(route("promociones.edit", $promocion))->with("status", "Guardado");
        } catch (\Throwable $th) {
            // throw $th;
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
