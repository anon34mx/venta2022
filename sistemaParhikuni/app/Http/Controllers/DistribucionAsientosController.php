<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DisponibilidadAsientos;
use App\Models\Disponibilidad;
use DB,Vite;

class DistribucionAsientosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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
    public function showPorCorrida($corridaDisponible)
    {
        $sql_diagrama='SELECT
            dist.*
            FROM `corridasdisponibles` cordis
            INNER JOIN tiposervicio tser
            on tser.nNumero=cordis.nTipoServicio
            INNER JOIN distribucionasientos dist
            ON dist.nNumero=tser.nDistribucionAsientos

            WHERE cordis.nNumero=:cordis';
        return collect(
            DB::select($sql_diagrama,[
                'cordis' => $corridaDisponible
            ])
        )->first();
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
    public function destroy($id)
    {
        //
    }

    public function getDiagramaOcupacion(Request $request){
        $ocupados='SELECT DISTINCT(nAsiento), aEstadoAsiento
            FROM disponibilidad as disp
            INNER JOIN disponibilidadasientos as disa
            ON disa.nDisponibilidad=disp.nNumero
            where disp.nOrigen=:origen
            AND disp.nDestino=:destino
            AND disp.nCorridaDIsponible=:corrida
            AND (disa.aEstadoAsiento="LM" OR disa.aEstadoAsiento="VE")
            ORDER BY nAsiento ASC';
        $rs_ocupados=DB::select($ocupados, [
                'origen' => $request->origen,
                'destino' => $request->destino,
                'corrida' => $request->corrida,
            ]
        );

        $asientosOcupados=[];
        foreach ($rs_ocupados as $asiento) {
            $asientosOcupados[$asiento->nAsiento]=true;
        }

        $dist=$this->showPorCorrida($request->corrida);
        $diag="";
        //Vite::asset(\'resources/images/diagramaAutobus/Conductor.png\')
        // dd(Vite::asset('resources/images/diagramaAutobus/Conductor.png'));
        $diag.='<table border="1" id="asientos-ida" class="tbl-diagrama-bus mx-auto mt-2" style="
                max-width: 300px;
                margin: auto;">
                <tr>
                    <td>
                        <img alt="" style="" width="34"
                            class="logo-color mx-auto my-0" src="'.Vite::asset('resources/images/diagramaAutobus/Conductor.png').'">
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>';
        foreach(explode('|',$dist->aDistribucion) as $fila){
            $diag.='<tr>';
            foreach (explode(',',$fila) as $espacio) {
                $diag.='<td>';
                if($espacio=='00'){
                    $diag.='<div class="pasillo">__</div>';
                }
                elseif($espacio=='PU'){
                    $diag.='<div class="asiento_nmr">[PU]</div>';
                }
                elseif($espacio=='BH'){
                    $diag.='<div class="asiento_nmr">'.$espacio.'</div>';
                }
                elseif($espacio=='BM'){
                    $diag.='<div class="asiento_nmr">'.$espacio.'</div>';
                }
                elseif($espacio=='CA'){
                    $diag.='<div class="asiento_nmr">'.$espacio.'</div>';
                }
                else{
                    $numAsiento=substr($espacio,0,2);
                    $tv=strpos($espacio,'T')>0 ? "tv": "";
                    $ocupado=isset($asientosOcupados[intval($numAsiento)]) ? "ocupado" : "";

                    $diag.='<div id="asiento-'.$numAsiento.'" class="asiento '.$tv.' '.$ocupado.'" numero="'.$numAsiento.'">
                                <span>'.$numAsiento.'</span>
                                <br>
                                <sub>tv</sub>
                            </div>';
                }
                $diag.='</td>';
            }
            $diag.='</tr>';
        }
        $diag.='</table >';

        echo $retorno=json_encode([
            "diagrama"=> $diag,
            "ocupados" => $asientosOcupados,
            "asientos" => $dist->nAsientos,
        ]);
    }
}
