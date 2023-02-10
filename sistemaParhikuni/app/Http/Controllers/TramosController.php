<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Tramos;
use App\Models\Oficinas;

class TramosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $tramos; //=Tramos::select("*")->orderBy("nOrigen", "ASC")->get();
        if(is_numeric($request->busqueda)){
            // dd($request->busqueda);
            $tramos=Tramos::whereRaw("nOrigen=$request->busqueda or nDestino=$request->busqueda")->orderBy("nOrigen", "ASC")->get();
        }else{
            $tramos=Tramos::select("*")->orderBy("nOrigen", "ASC")->get();
        }
        return view('tramos.index',[
            "oficinas" => Oficinas::where("lDestino","=", true)->get(),
            "tramos" => $tramos,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $tramosNvos=Tramos::tramosNuevos();
        return view('tramos.create',[
            "oficinas" => Oficinas::whereRaw("lDestino=true")->get(),
            "origenesDestinos" => $tramosNvos,
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
        // dd($origenDestino);
        try {
            for($i=0; $i<sizeof($request->kilometros); $i++){
                $origenDestino=explode("_", $request->origenDestino[$i]);
                Tramos::create([
                    "nOrigen" => $origenDestino[0],
                    "nDestino" => $origenDestino[1],
                    "nKilometros" => $request->kilometros[$i],
                    "nTiempo" => $request->tiempo[$i],
                    "nEstancia" => $request->estancia[$i],
                ]);
            }
            return redirect(route("tramos.index"))->with("status", "Guardado");
        } catch (\Throwable $th) {
            throw $th;
            return redirect(route("tramos.index"))->withErrors($th);
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
    public function edit(Tramos $id)
    {
        return view('tramos.edit',[
            "tramo" => $id
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Tramos $id)// 
    {
        $id->update([
            "nKilometros" => $request->kilometros,
            "nTiempo" => $request->tiempo,
            "nEstancia" => $request->estancia,
        ]);
        return back()->with("status", "Guardado");
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
