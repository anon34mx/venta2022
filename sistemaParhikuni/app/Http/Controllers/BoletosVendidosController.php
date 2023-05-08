<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CorridasDisponibles;
use App\Models\BoletosVendidos;
use App\Models\BoletosCancelados;
use DB;

class BoletosVendidosController extends Controller
{
    public $elementsPerPage=15;

    public function showLimbo(CorridasDisponibles $corridaDisponible){
        $posiblesCorridas = collect (DB::select('SELECT cordis.*
            ,disa.nAsientos as asientos
            , COUNT(bol.nNumero) as ocupados
            , disa.nAsientos - COUNT(bol.nNumero) as libres,
            serv.aClave as claveServicio,
            serv.aDescripcion as servicio
            FROM corridasdisponibles cordis
            INNER JOIN tiposervicio serv
                on serv.nNumero=cordis.nTipoServicio
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
            AND cordis.nTipoServicio=:TipoServicio
            GROUP BY cordis.nNumero, cordis.nProgramada
            HAVING disa.nAsientos - COUNT(bol.nNumero)>0
            ORDER BY cordis.fSalida ASC, cordis.hSalida ASC',[
                "fSalidaInicio" => $corridaDisponible->fSalida,
                "fSalidaFin" => $corridaDisponible->fSalida,
                "nIti" => $corridaDisponible->nItinerario,
                "TipoServicio" => $corridaDisponible->nTipoServicio,
            ]));
        // evitar por cuestiones de rendimiento
        // $posiblesCorridas=CorridasDisponibles::
        //     whereDate("corridasDisponibles.fSalida", ">=", $corridaDisponible->fSalida)
        //     ->whereRaw("corridasDisponibles.fSalida <= DATE_ADD('".$corridaDisponible->fSalida."', INTERVAL 2 DAY)")
        //     ->where("corridasDisponibles.aEstado","!=","C")
        //     ->where("corridasDisponibles.aEstado","!=","B")
        //     ->where("corridasDisponibles.aEstado","!=","L")
        //     ->where("corridasDisponibles.aEstado","!=","T")
        //     ->where("corridasDisponibles.nItinerario", "=", $corridaDisponible->nItinerario)
        //     ->leftjoin("boletosvendidos as bol", function($join){
        //         $join->on("bol.nCorrida","=","corridasDisponibles.nNumero");
        //         $join->raw(DB::raw('bol.aEstado="AP" OR bol.aEstado="VE"'));
        //     })
        //     ->leftjoin("autobuses as aut", "aut.nNumeroAutobus","=","cordis.nNumeroAutobus")
        //     ->leftjoin("distribucionasientos disa", "disa.nNumero", "=", "aut.nDistribucionAsientos")

        //     ->groupByRaw("corridasDisponibles.nNumero, corridasDisponibles.nProgramada")
        //     // ->having()
        //     ->get();
        // dd($posiblesCorridas);
        $boletosEnLimbo=BoletosVendidos::
            where("nCorrida", "=", $corridaDisponible->nNumero)
            ->where("aEstado", "=", "LM")
            ->get();


        // dd($corridaDisponible);
        return view("pasajeros.limbo.porCorrida",[
            "corridaDisponible" => $corridaDisponible,
            "boletos" => $boletosEnLimbo,
            "corridas" => $posiblesCorridas
        ]);
    }

    public function reasignarLimbo(Request $request){
        // asignar boletos
        // crear disponibilidadasientos
        // cambiar estado boletos
        // registrar intercambio en tabla boleotscancelados
        // ver si hay diferencia de costo???
        // dar de baja boletos
        $corridaDisponible=CorridasDisponibles::find($request->nvaCorrida);

        // dd($request->all());
        // dd($corridaDisponible);
        dd(BoletosCancelados::all());
        foreach ($request->boleto as $boleto) {
            try {
                $boleto=BoletosVendidos::find($boleto);
                
                // Crear boleto nuevo
                $nvoBoleto=BoletosVendidos::BoletosVendidos::create([
                    'nVenta' => $boleto->nVenta,
                    'nCorrida' => $corridaDisponible->nNumero,
                    'lRegreso' => $boleto->lRegreso,
                    'fSalida' => $corridaDisponible->fSalida,
                    'hSalida' => $corridaDisponible->hSalida,
                    'nOrigen' => $boleto->nOrigen,
                    'nDestino' => $boleto->nDestino,
                    'aTipoPasajero' => $boleto->aTipoPasajero,
                    'aPasajero' => $boleto->aPasajero,
                    'nAsiento' => $boleto->nAsiento,
                    'aTipoVenta' => $boleto->aTipoVenta,
                    'nMontoBase' => $boleto->nMontoBase,
                    'nMontoDescuento' => $boleto->nMontoDescuento,
                    'nIva' => $boleto->nIva,
                    'aEstado' => "VE",
                    'nTerminal' => @session("terminal"),
                ]);

                dd($boleto);
                exit;
                // Apartar la disponibilidad
                $rs=collect(
                    DB::SELECT("SELECT apartar_asiento(?,?,?,?,?,?) as asientos",[
                        $corridaDisponible->nNumero, $corridaDisponible->nOrigen, $corridaDisponible->nDestino, 0, Auth::user()->id, 'V', $nvoBoleto->nNumero
                    ])
                )->first()->asientos;

                //actualizar estado del boleto anterior
                $boleto->update([
                    "aEstado" => "C"
                ]);
                // Registrar el intercambio
                $inter=BoletosCancelados::create([
                    'nBoletoVendido' => $boleto->nNumero,
                    'nBoletoNuevo' => $nvoBoleto->nNumero,
                ]);
            } catch (\Throwable $th) {
                throw $th;
            }
        }
    }
}
