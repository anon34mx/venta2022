<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CorridasDisponibles;
use App\Models\BoletosVendidos;
use App\Models\BoletosCancelados;
use App\Models\DisponibilidadAsientos;
use DB,Auth;

class BoletosVendidosController extends Controller
{
    public $elementsPerPage=15;

    public function showLimbo(CorridasDisponibles $corridaDisponible){
        /*
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
            */
        $boletosEnLimbo=BoletosVendidos::
            where("nCorrida", "=", $corridaDisponible->nNumero)
            ->whereRaw("(aEstado = 'LM' OR aEstado = 'VE')")
            ->get();
            
        if(sizeof($boletosEnLimbo) === 0){
            $corridaDisponible->cambiarEstado("C");
            return view("pasajeros.limbo.porCorrida",[
                "corridaDisponible" => $corridaDisponible,
                "boletos" => $boletosEnLimbo,
                // "corridas" => $posiblesCorridas
            ])->withErrors("No se encontraron boletos.");

        }
        return view("pasajeros.limbo.porCorrida",[
            "corridaDisponible" => $corridaDisponible,
            "boletos" => $boletosEnLimbo,
            // "corridas" => $posiblesCorridas
        ]);
    }

    public function porCorrida(Request $request){
        /* PASOS
         * asignar boletos
         * crear disponibilidadasientos
         * cambiar estado boletos
         * registrar intercambio en tabla boleotscancelados
         * ver si hay diferencia de costo???
         * dar de baja boletos
         */
        $corridaDisponible=CorridasDisponibles::find($request->nvaCorrida);

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

                // Apartar la disponibilidad
                // REVISAR
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
    public function reasignarManual(CorridasDisponibles $corridaOriginal, Request $request){
        // dd($request->all());
        # 1 Cambiar estado de corrida
        $corridaOriginal->cambiarEstado('B');

        for ($i=0; $i < sizeof($request->boletoAnterior); $i++) { 
            # 2 Recuperar boleto anterior
            $boletoAnterior=BoletosVendidos::find($request->boletoAnterior[$i]);
            dd($boletoAnterior);
            # 3 Insertar boleto nuevo
            
            # 4 Apartar asientos
    
            # 5 Registrar intercambio
    
            # 6 Dar de baja boleto anterior
        }
    }

    public function reasignarAutomatico(CorridasDisponibles $corridaOriginal){
        $CorridasDisponibles=new CorridasDisponibles();
        $ventas=$corridaOriginal->boletosEnGrupo();
        
        // #1 Cambiar estado de corrida
        // $corridaOriginal->cambiarEstado('B');
        
        // #2 Analizar cada venta para esa corrida
        foreach ($ventas as $venta) {
            // # 3 Obtener boletos
            $boletos=BoletosVendidos::where('nCorrida','=', $corridaOriginal->nNumero)
            ->where('nVenta','=',$venta->nVenta)
            ->whereRaw('(aEstado = "LM" OR aEstado = "VE")')
            // ->where('aEstado','=', 'VE')
            ->get();
            // dd($boletos);
            if(sizeof($boletos) === 0){
                return redirect(route('boletos.limbo.show', ['corridaDisponible'=>$corridaOriginal]))
                    ->withErrors('No se encontraron pasajeros (?).');
            }

            $fechaHoraMinBuscar=\Carbon\Carbon::createFromFormat('Y-m-d H:i:s', @$corridaOriginal->fSalida.' '.$corridaOriginal->hSalida)->addSeconds(1);//->format('Y-m-d H:i');
            $fechaHoraMaxBuscar=\Carbon\Carbon::createFromFormat('Y-m-d H:i:s', @$corridaOriginal->fSalida.' '.$corridaOriginal->hSalida)->addHour(2);//->format('Y-m-d H:i');
            
            // #4 Encontrar siguiente corrida disponible
            $siguienteCorrida=collect($CorridasDisponibles->proximaTransferencia(
                $corridaOriginal->nNumero, $boletos[0]->nOrigen, $boletos[0]->nDestino,
                $fechaHoraMinBuscar->format('Y-m-d'), $fechaHoraMinBuscar->format('H:i:s'),
                $fechaHoraMaxBuscar->format('Y-m-d'), $fechaHoraMaxBuscar->format('H:i:s'),
                $venta->viajanJuntos
                )
            )->first(); //usarPromo, limite, tipoDeBusqueda
            // dd("siguiente corrida disponible", $siguienteCorrida);
            if($siguienteCorrida === null){
                return redirect(route('boletos.limbo.show', ['corridaDisponible'=>$corridaOriginal]))
                    ->withErrors('No se encontró una corrida próxima. Asigna a los pasajeros manualmente.');
            }
            // #5 Encontrar los asientos que está disponibles
            $asientosOcupados=DB::select(
                DB::raw('SELECT
                disa.nAsiento
                FROM `disponibilidadasientos` disa
                INNER JOIN disponibilidad disp
                    ON disp.nNumero=disa.nDisponibilidad
                WHERE disp.nCorridaDisponible=:nCorrida
                AND disp.nOrigen=:nOrigen and disp.nDestino=:nDestino
                GROUP BY disa.nAsiento
                ORDER BY disa.nAsiento'),[
                    'nCorrida' => $siguienteCorrida->corrida,
                    'nOrigen' => $boletos[0]->nOrigen,
                    'nDestino' => $boletos[0]->nDestino,
                ]
            );

            // #6 Encontrar asientos disponibles
            $asientosDisp=array();
            for ($i=1; $i <= $siguienteCorrida->totalAsientos; $i++) { 
                $found=false;
                // dd($asientosOcupados[0]->nAsiento);
                for($c=0;$c<sizeof($asientosOcupados);$c++){
                    // echo $i." ".$asientosOcupados[$c]->nAsiento."<br>";
                    if($asientosOcupados[$c]->nAsiento === $i){
                        // echo "found ".$i." ".$asientosOcupados[$c]->nAsiento."<br>";
                        $found=true;
                        break;
                    }
                }

                if(!$found){
                    $asientosDisp[$i]=$i;
                }
            }
            
            # array_values($asientosDisp)[0] // SIGUIENTE ASIENTO
            // dd(array_values($asientosDisp)[0]);
            foreach ($boletos as $boleto) {
                //Boletos
                $nvoBoleto=BoletosVendidos::create([
                    'nVenta' => $boleto->nVenta,
                    'nCorrida' => $siguienteCorrida->corrida,
                    'lRegreso' => $boleto->lRegreso,
                    'fSalida' => $siguienteCorrida->fSalida,
                    'hSalida' => $siguienteCorrida->hSalida,
                    'nOrigen' => $boleto->nOrigen,
                    'nDestino' => $boleto->nDestino,
                    'aTipoPasajero' => $boleto->aTipoPasajero,
                    'aPasajero' => $boleto->aPasajero,
                    'nAsiento' => array_values($asientosDisp)[0], //$boleto->nAsiento,
                    'aTipoVenta' => $boleto->aTipoVenta,// INTERCAMBIO
                    'nMontoBase' => 0,
                    'nMontoDescuento' => 0,
                    'nIva' => 0,
                    'aEstado' => 'VE',
                    'nTerminal' => @session('terminal'),
                ]);
                //Apartar
                $rs=null;
                try{
                    $rs=collect(
                        DisponibilidadAsientos::apartarAsiento(
                            $siguienteCorrida->corrida,
                            $boleto->nOrigen,
                            $boleto->nDestino,
                            array_values($asientosDisp)[0],
                            "V"
                        )
                    )->first();
                    // dd($rs);
                }catch(\Exception $e){
                    // DB::rollback();
                    throw $e;
                }
                // dd($rs, $siguienteCorrida->corrida, $boleto->nOrigen, $boleto->nDestino,
                //     array_values($asientosDisp)[0], Auth::user()->id, 'VE', $nvoBoleto->nNumero);
                
                $asientosDisp=array_splice( $asientosDisp,1,sizeof($asientosDisp));
                //registrar intercambio
                BoletosCancelados::create([
                    'nBoletoVendido' => $boleto->nNumero,
                    'nBoletoNuevo' => $nvoBoleto->nNumero,
                ]);
                //dar de baja boleto anterior
                $boleto->update([
                    'aEstado' => 'CA'
                ]);
                DB::raw('DELETE FROM `disponibilidadasientos` WHERE nBoleto=:boleto',[
                    $boleto->nNumero
                ]);
                DB::table('disponibilidadasientos')->where("nBoleto", $boleto->nNumero)->delete();
                // dd("",$boleto->nNumero);
            }

            return "oki";
        }
    }
}
