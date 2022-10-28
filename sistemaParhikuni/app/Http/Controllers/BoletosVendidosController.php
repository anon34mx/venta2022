<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CorridasDisponibles;
use App\Models\BoletosVendidos;
use DB;

class BoletosVendidosController extends Controller
{
    public $elementsPerPage=15;

    public function showLimbo(CorridasDisponibles $corridaDisponible){
        $posiblesCorridas = DB::select('SELECT cordis.*
            ,disa.nAsientos
            , COUNT(bol.nNumero) as ocupados
            , disa.nAsientos - COUNT(bol.nNumero) as libres
            FROM corridasdisponibles cordis
            LEFT JOIN boletosvendidos bol
                ON bol.nCorrida=cordis.nNumero
                AND (bol.aEstado="AP" OR bol.aEstado="VE")
            LEFT JOIN autobuses as aut
                ON aut.nNumeroAutobus=cordis.nNumeroAutobus
            LEFT JOIN distribucionasientos disa
                ON disa.nNumero=aut.nDistribucionAsientos
            WHERE
            cordis.fSalida>=:fSalidaInicio
            AND cordis.fSalida<=DATE_ADD(:fSalidaFin, INTERVAL 2 DAY)
            AND cordis.aEstado!="C"
            AND cordis.nItinerario=:nIti
            GROUP BY cordis.nNumero, cordis.nProgramada
            HAVING disa.nAsientos - COUNT(bol.nNumero)>0
            ORDER BY cordis.fSalida ASC, cordis.hSalida ASC',[
                "fSalidaInicio" => $corridaDisponible->fSalida,
                "fSalidaFin" => $corridaDisponible->fSalida,
                "nIti" => $corridaDisponible->nItinerario,
            ]);

        // dd($posiblesCorridas);
        $boletosEnLimbo=BoletosVendidos::
            where("nCorrida", "=", $corridaDisponible->nNumero)
            ->where("aEstado", "=", "LM")
            ->get();


        return view("pasajeros.limbo.porCorrida",[
            "boletos" => $boletosEnLimbo,
            "corridas" => $posiblesCorridas
        ]);
    }
}
