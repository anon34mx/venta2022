<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Itinerario;
use App\Models\Tramos;
use DB;

class ItinerariosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('itinerarios.index',[
            "itinerarioClass" => Itinerario::class
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $tramos=DB::table("tramos as tr")
            ->selectRaw("tr.nNumero as nNumero, tr.nOrigen, ofiOri.anombre as origen, tr.nDestino, ofiDes.aNombre as destino, tr.nkilometros, tr.nTiempo, tr.nEstancia")
            ->join("oficinas as ofiOri", "ofiOri.nNumero", "=", "tr.nOrigen")
            ->join("oficinas as ofiDes", "ofiDes.nNumero", "=", "tr.nDestino")
            ->orderBy("nOrigen", "ASC")
            ->orderBy("nDestino", "ASC")
            ->get();
        return view('itinerarios.create',[
            "tramos" => $tramos,
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
            $ultimoItinerario=Itinerario::selectRaw("IFNULL(max(nItinerario)+1, 1) as ultimo")->first();
            foreach($request->tramo as $consecutivo=>$tramo){
                Itinerario::create([
                    "nItinerario" => $ultimoItinerario->ultimo,
                    "nConsecutivo" => $consecutivo+1,
                    "nTramo" => $tramo,
                ]);
            }
            $vista=DB::select("CALL view_iti_tra_update()");
            return redirect(route('itinerarios.index'))->with("status", "Guardado");
        } catch (\Throwable $th) {
            //throw $th;
            return back()->withErrors("Hubo algún error");
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
    public function edit(Itinerario $id)
    {
        // dd(new Itinerario()::detalle($id));
        $tramos=$id->detalle($id->nItinerario);
        $size=sizeof($tramos);

        $posiblesTramos=Tramos::where("nOrigen", "=", $tramos[$size-1]->nDestino)
            ->get();
        // dd($posiblesTramos[0]);
        return view('itinerarios.edit',[
            "tramos" => $tramos,
            "posiblesTramos" => $posiblesTramos,
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Itinerario $id)
    {
        if($request->action=="añadir"){
            $new=Itinerario::añadirTramo($id->nItinerario, $request->tramo);
            if($new){
                return back()->with("status", "Guardado");
            }else{
                return back()->withErrors("Error al guardar");
            }
        }elseif($request->action=="quitar"){
            Itinerario::where("nItinerario","=", $id->nItinerario)
                ->where("nConsecutivo","=", $request->consecutivo)
                ->delete();
            return back()->with("status", "Eliminado");
        }else{
            return back();
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
