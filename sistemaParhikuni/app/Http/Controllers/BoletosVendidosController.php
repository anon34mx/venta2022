<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\CorridasDisponibles;
use App\Models\BoletosVendidos;
use App\Models\BoletosCancelados;
use App\Models\DisponibilidadAsientos;
use App\Models\BoletosTransferidos;

use DB,Auth;

class BoletosVendidosController extends Controller
{
    public $elementsPerPage=15;

    public function showLimbo(CorridasDisponibles $corridaDisponible){
        $boletosEnLimbo=BoletosVendidos::
            where("nCorrida", "=", $corridaDisponible->nNumero)
            ->whereRaw("(aEstado = 'LM' OR aEstado = 'VE')")
            ->orderByRaw("boletosvendidos.nAsiento ASC")
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
        $boleto=null;
        $asientosDisp=null;
        $corridaNva=null;
        // dd($request->all());

        # 1 Encontrar nueva corrida
        $corridaNva=CorridasDisponibles::find($request->nvaCorrida);
        for ($i=0; $i < sizeof($request->boleto); $i++) { 
            # 2 Actualizar boleto anterior
            $boleto=BoletosVendidos::find($request->boleto[$i]);
            $boleto->update([
                "nCorrida" => $corridaNva->nNumero,
                "nAsiento" => $request->asiento[$i],
            ]);
            # 3 Guardar transferencia
            BoletosTransferidos::create([
                "corrida_anterior" => $corridaOriginal->nNumero,
                "boleto" => $boleto->nNumero,
            ]);

            if($request->asiento[$i]!='0'){
                # 4 Apartar asientos si no es paquete
                $dispon=null;
                try{
                    $dispon=collect(
                        DisponibilidadAsientos::apartarAsiento(
                            $corridaNva->nNumero,
                            $boleto->nOrigen,
                            $boleto->nDestino,
                            $request->asiento[$i],
                            "V"
                        )
                    )->first();
                }catch(\Exception $e){
                    throw $e;
                }
                # 5 liberar asientos reservados de la corrida orignal
                #CORREGIR
                
                DB::raw('DELETE from disponibilidadasientos 
                    where id IN (
                        SELECT
                        disa.id
                        FROM `disponibilidadasientos` disa
                        INNER JOIN disponibilidad disp
                        on disa.nDisponibilidad=disp.nNumero
                        WHERE disp.nCorridaDisponible=:nCorrida
                        and disa.nAsiento=:nAsiento
                    )',[
                        "nAsiento" => $boleto->nNumero,
                        "nCorrida" => $corridaOriginal->nNumero,
                    ]
                );
            }
        }
        return back()->with("status", "Guardado");
    }

    public function reasignarAutomatico(CorridasDisponibles $corridaOriginal){
        $CorridasDisponibles=new CorridasDisponibles();
        $ventas=$corridaOriginal->boletosEnGrupo();
        
        #1 Analizar cada venta para esa corrida
        foreach ($ventas as $venta) {
            #2 Obtener boletos
            $boletos=BoletosVendidos::where('nCorrida','=', $corridaOriginal->nNumero)
            ->where('nVenta','=',$venta->nVenta)
            ->whereRaw('(aEstado = "LM" OR aEstado = "VE")')
            ->get();
            if(sizeof($boletos) === 0){
                return redirect(route('boletos.limbo.show', ['corridaDisponible'=>$corridaOriginal]))
                    ->withErrors('No se encontraron pasajeros (?).');
            }

            $fechaHoraMinBuscar=\Carbon\Carbon::createFromFormat('Y-m-d H:i:s', @$corridaOriginal->fSalida.' '.$corridaOriginal->hSalida)->addSeconds(1);//->format('Y-m-d H:i');
            $fechaHoraMaxBuscar=\Carbon\Carbon::createFromFormat('Y-m-d H:i:s', @$corridaOriginal->fSalida.' '.$corridaOriginal->hSalida)->addHour(2);//->format('Y-m-d H:i');
            
            #3 Encontrar siguiente corrida disponible
            $siguienteCorrida=collect($CorridasDisponibles->proximaTransferencia(
                $corridaOriginal->nNumero, $boletos[0]->nOrigen, $boletos[0]->nDestino,
                $fechaHoraMinBuscar->format('Y-m-d'), $fechaHoraMinBuscar->format('H:i:s'),
                $fechaHoraMaxBuscar->format('Y-m-d'), $fechaHoraMaxBuscar->format('H:i:s'),
                $venta->viajanJuntos
                )
            )->first(); //usarPromo, limite, tipoDeBusqueda
            
            if($siguienteCorrida === null){
                return redirect(route('boletos.limbo.show', ['corridaDisponible'=>$corridaOriginal]))
                    ->withErrors('No se encontró una corrida próxima. Asigna a los pasajeros manualmente.');
            }
            #4 Encontrar los asientos que está disponibles
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

            #5 Encontrar asientos disponibles
            $asientosDisp=array();
            for ($i=1; $i <= $siguienteCorrida->totalAsientos; $i++) { 
                $found=false;
                for($c=0;$c<sizeof($asientosOcupados);$c++){
                    if($asientosOcupados[$c]->nAsiento === $i){
                        $found=true;
                        break;
                    }
                }

                if(!$found){
                    $asientosDisp[$i]=$i;
                }
            }
            
            # array_values($asientosDisp)[0] // SIGUIENTE ASIENTO
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
                }catch(\Exception $e){
                    throw $e;
                }
                
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
            }

            return "oki";
        }
    }
}
