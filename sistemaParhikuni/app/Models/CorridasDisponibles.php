<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use Illuminate\Database\Eloquent\SoftDeletes;

// use App\Models\Personas;
use App\Models\conductores;
use App\Models\Autobus;
use App\Models\CorridasEstados;
use App\Models\BoletosVendidos;
use App\Models\CorridasDisponiblesHistorial;
use App\Models\RegistroPasoPuntos;
use App\Models\Itinerario;
use App\Models\TarifasTramo;
use DB, Carbon;
use Auth;

class CorridasDisponibles extends Model
{
    use HasFactory; //, SoftDeletes
    protected $table = 'corridasdisponibles';
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        'nProgramada',
    ];
    protected $fillable = [
        'aEstado',
        'nNumeroAutobus',
        'nNumeroConductor',
    ];

    public function servicio(){
        return $this->hasOne(TiposServicios::class, 'nNumero', 'nTipoServicio');
    }
    public function conductor(){
        return $this->hasOne(conductores::class, 'nNumeroConductor', 'nNumeroConductor');
    }
    public function autobus(){
        return $this->hasOne(Autobus::class, 'nNumeroAutobus', 'nNumeroAutobus');
    }

    public function promociones(){
        return $rs=json_encode(collect(
                \DB::select("SELECT
                COUNT(bolpro.nBoletoVendido) usadas, serv.descuentosMax as maximo
                    ,CAST(serv.descuentosMax as int)-COUNT(bolpro.nBoletoVendido) as disponibles
                FROM `corridasdisponibles` as cordis
                LEFT JOIN boletosvendidos as bove
                    on bove.nCorrida=cordis.nNumero
                INNER JOIN boletosvendidos_promociones as bolpro
                    on bolpro.nBoletoVendido=bove.nNumero
                INNER JOIN tiposervicio serv
                    on serv.nNumero=cordis.nTipoServicio
                WHERE cordis.nNumero =:corrida",[
                    "corrida" => $this->nNumero
            ])
        )->first());
    }

    public function getItinerario(){
        $sql="SELECT
            iti.nItinerario as 'itinerario', iti.nConsecutivo as 'consecutivo',
            tr.nNumero as 'tramo',
            tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
            tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
            FROM corridasdisponibles cordis
            INNER JOIN itinerario as iti on iti.nItinerario=cordis.nItinerario
            INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
            INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
            INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
            where cordis.nNumero=:id -- parametro
            order by iti.nConsecutivo ASC";
        return DB::select($sql, [
                'id' => $this->nNumero
            ]
        );
    }

    public function getRecorrido($origen=null, $destino=null){
        // desde la tabla de disponibilidad
        $sql="SELECT
            iti.nItinerario, iti.nConsecutivo,
            tr.nNumero, tr.nOrigen, tr.nDestino, tr.nKilometros, tr.nTiempo, 
            disp.fSalida, disp.hSalida, disp.fLlegada, disp.hLlegada,
            ori.nNumero as origen, ori.aNombre as origenNombre, des.nNumero as destino, des.aNombre as destinoNombre
            FROM `itinerario` as iti
            INNER JOIN tramos as tr ON tr.nNumero=iti.nTramo
            LEFT JOIN disponibilidad as disp
                ON disp.nCorridaDisponible=:IN_cordis and disp.nOrigen=tr.nOrigen
                and disp.nDestino=tr.nDestino

            INNER JOIN oficinas as ori on ori.nNumero=tr.nOrigen
            INNER JOIN oficinas as des on des.nNumero=tr.nDestino

            WHERE iti.nItinerario=:IN_iti
            AND iti.nConsecutivo>=(
                    SELECT nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub on trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=iti.nItinerario and trSub.nOrigen=:IN_ori
            )
            AND iti.nConsecutivo<=(
                    SELECT nConsecutivo FROM itinerario as itiSub
                INNER JOIN tramos as trSub on trSub.nNumero=itiSub.nTramo
                WHERE itiSub.nItinerario=iti.nItinerario and trSub.nDestino=:IN_des
            )";
        return DB::select($sql,[
            "IN_cordis" => $this->nNumero,
            "IN_iti" => $this->nItinerario,
            "IN_ori" => $origen,
            "IN_des" => $destino,
        ]);
    }

    public function getTramoOficina($oficina){
        return DB::select("SELECT
            iti.nItinerario as itinerario, tr.nNumero as tramo, iti.nConsecutivo as consecutivo,tr.nOrigen as origen, tr.nDestino as destino
            FROM corridasDisponibles cordis
            INNER JOIN itinerario iti ON iti.nItinerario=cordis.nItinerario
            INNER JOIN tramos tr on tr.nNumero=iti.nTramo and tr.nOrigen=:oficina
            WHERE cordis.nNumero=:id
            ORDER BY iti.nConsecutivo ASC
            LIMIT 1",[
                "id" => $this->nNumero,
                "oficina" => $oficina,
            ])[0];
    }

    public function puntosDeControl(){
        return DB::select("SELECT
            iti.nItinerario as 'itinerario', iti.nConsecutivo as 'consecutivo',
            tr.nNumero as 'tramo',
            tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
            tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino',
            paso.*
            FROM corridasdisponibles cordis
            INNER JOIN itinerario as iti on iti.nItinerario=cordis.nItinerario
            INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
            INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
            INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
            LEFT JOIN registropasopuntos paso
                on paso.nConsecutivo=iti.nConsecutivo and paso.nCorrida=cordis.nNumero
            where cordis.nNumero=:id -- parametro
            order by iti.nConsecutivo ASC", [
                'id' => $this->nNumero
            ]);
    }
    public function registrarPasoPunto(){
        /**
         * El conductor registra su llegada y salida de cada oficina
        */

        $registro=DB::select(
            "SELECT iti.nItinerario, iti.nConsecutivo as consecutivo, reg.nCorrida as registro ,reg.despachado, reg.fSalida, reg.fLlegada
            FROM corridasDisponibles cordis
            INNER JOIN itinerario iti ON iti.nItinerario=cordis.nItinerario
            LEFT JOIN registropasopuntos reg ON reg.nCorrida=cordis.nNumero AND reg.nConsecutivo=iti.nConsecutivo
            WHERE cordis.nNumero=:id AND ( reg.fSalida IS NULL || reg.fLlegada IS NULL )
            ORDER BY iti.nConsecutivo ASC LIMIT 1",[
                "id" => $this->nNumero,
            ]
        );
        if($registro==null){
            return false;
        }else{
            if($registro[0]->fSalida==null){
                $registro=RegistroPasoPuntos::upsert(
                    ["nCorrida" => $this->nNumero, "nConsecutivo" => $registro[0]->consecutivo, "fSalida" => date("Y-m-d H:i:s")],
                    ["nCorrida", "nConsecutivo"],
                    ["fSalida"]
                );
            }elseif($registro[0]->fLlegada==null){
                $registro=RegistroPasoPuntos::upsert(
                    ["nCorrida" => $this->nNumero, "nConsecutivo" => $registro[0]->consecutivo, "fLlegada" => date("Y-m-d H:i:s")],
                    ["nCorrida", "nConsecutivo"],
                    ["fLlegada"]
                );
            }
            return true;
        }
    }
    public function cambiarEstado($edo){
        CorridasDisponiblesHistorial::create([
            "corrida_disponible" => $this->nNumero,
            "aEstadoAnterior" => $this->aEstado,
            "aEstadoNuevo" => $edo,
            "user" => Auth::user()->id,
        ]);
        $this->update([
            "aEstado" => $edo
        ]);
    }
    public function desbloquear(){
        $ultimoHist=CorridasDisponiblesHistorial::where("corrida_disponible", "=", $this->nNumero)
            ->orderBy("created_at","DESC")
            ->first();
        CorridasDisponiblesHistorial::create([
            "corrida_disponible" => $this->nNumero,
            "aEstadoAnterior" => $this->aEstado,
            "aEstadoNuevo" => $ultimoHist->aEstadoAnterior,
            "user" => Auth::user()->id,
        ]);

        $this->update([
            "aEstado" => $ultimoHist->aEstadoAnterior
        ]);
        return $this;
    }
    public function despachar($consecutivo){
        $registro=RegistroPasoPuntos::firstOrCreate([
            "nCorrida" => $this->nNumero,
            "nConsecutivo" => $consecutivo,
        ]);
        if($registro->despachado==null){
            $registro->update(["despachado"=>Carbon\Carbon::now()]);
        }
        return $registro;
    }
    // guia de boletos vendidos: muestra todos los boletos vendidos para X corrida
    //  excluyendo paqueteria
    public function boletos(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero')
            ->where("aTipoPasajero", "!=", "PQ");
    }
    public function paquetes(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero')
            ->where("aTipoPasajero", "=", "PQ");
    }
    public function guiaPasajeros(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero')
            ->orderBy("nAsiento", "asc");
    }
    public function boletosEnLimbo(){
        return DB::select('
            SELECT *
                FROM `boletosvendidos`
                where nCorrida=:id AND aEstado="LM"
            ', [
                'id' => $this->nNumero
            ]);
    }
    public function filtrar($corrida=null, $origen=null, $destino=null, $fechaSalida=null, $fechaMax=null, $pasajeros=null, $hInicio=null, $hFin=null, $usarPromocion=null){
        $totalPasajeros=0;
        foreach($pasajeros as $owo){
            $totalPasajeros+=$owo;
        }
        $res=$this::from("corridasdisponibles as cordis")
            ->selectRaw("cordis.nNumero as 'corrida',
                cordis.aEstado, IFNULL(hist.aEstadoNuevo, 'D') as 'estadoCorrida',
                autobus.nNumeroEconomico as autobus, dist.nAsientos as totalAsientos, autobus.nTipoServicio as claveServicio, tser.aDescripcion as claseServicio,
                -- count(bol.nNumero) as ocupados,
(SELECT
COUNT(DISTINCT(nAsiento))
FROM `disponibilidadasientos` disa
WHERE disa.nDisponibilidad=disp.nNumero) as ocupados,



                disp.nNumero as disp, disp.nOrigen, disp.nDestino, ori.aNombre as origen, des.aNombre as destino, disp.fSalida ,disp.hSalida,
                disp.fLlegada, disp.hLlegada,
                iti.nItinerario as itinerario, iti.nConsecutivo,
                reg.despachado, reg.fLlegada as checkin, reg.fSalida as checkout,
                (tatr.nMontoBaseRuta*1.".env("IVA").") as tarifaBase,
                tser.descuentosMax
                ,(
                    SELECT count(prmsds.nBoletoVendido) FROM `boletosvendidos_promociones` prmsds
                    INNER JOIN boletosvendidos bol2 ON bol2.nNumero=prmsds.nBoletoVendido WHERE bol2.nCorrida=cordis.nNumero
                ) as promosUsadas
            ")
            ->join("autobuses as autobus", "autobus.nNumeroAutobus", "=", "cordis.nNumeroAutobus")
            ->join("distribucionasientos as dist", "dist.nNumero", "=", "autobus.nDistribucionAsientos")
            ->join("tiposervicio as tser", "tser.nNumero", "=", "autobus.nTipoServicio")
            ->join("itinerario as iti", "iti.nItinerario", "=", "cordis.nItinerario")
            ->join("tramos as tr", "tr.nNumero", "=", "iti.nTramo")
            ->join("disponibilidad as disp", function($join){
                $join->on("disp.nCorridaDisponible", "=", "cordis.nNumero");
                $join->on("disp.nOrigen", "=", "tr.nOrigen");
            })
            ->join("oficinas as ori", "ori.nNumero", "=", "disp.nOrigen")
            ->join("oficinas as des", "des.nNumero", "=", "disp.nDestino")
            ->leftJoin("registropasopuntos as reg", function($join){
                $join->on("reg.nCorrida", "=", "cordis.nNumero");
                $join->on("iti.nConsecutivo", "=", "reg.nConsecutivo");
            })
            ->leftJoin("disponibilidadasientos as disa", function($join){
                $join->on("disa.nDisponibilidad", "=", "disp.nNumero");
                // $join->on("disa.aEstadoAsiento", "=", DB::raw("'O'")); //?
            });
            $res->leftJoin("boletosvendidos as bol", function($join){
                $join->on("bol.nCorrida", "=", "cordis.nNumero");
                $join->on("bol.aTipoPasajero", "!=", DB::raw("'PQ'"));
                $join->on("bol.aEstado", "=", DB::raw("('VE' OR 'PA')"));


                // $join->on("bol.nAsiento", "=", "disa.nAsiento");
                
                $join->on("bol.nNumero", "=", "disa.nBoleto");
            });

            if($usarPromocion==true){
                $res->havingRaw("promosUsadas+$totalPasajeros <= descuentosMax");
            }

            $res->leftJoin("tarifastramos as tatr", function($join){
                $join->on("tatr.nOrigen", "=", "disp.nOrigen");
                $join->on("tatr.nDestino", "=", "disp.nDestino");
                $join->on("tatr.nTipoServicio", "=", "cordis.nTipoServicio");
                $join->on("tatr.fAplicacion", "<=", DB::raw("current_date"));
            })
            ->leftJoin("corridas_disponibles_historial as hist", "hist.id", "=", DB::raw("
                (SELECT id FROM `corridas_disponibles_historial` where corrida_disponible=cordis.nNumero and nNumeroOficina=disp.nOrigen ORDER BY created_at DESC LIMIT 1)
            "));

            if($corrida!=null){
                $res->whereRaw("cordis.nNumero=".$corrida);
            }
            if($fechaSalida==null){
                $res->whereRaw("cordis.fSalida>=current_date");
            }else{
                $res->whereRaw("cordis.fSalida>='$fechaSalida'");
            }
            if($fechaMax==null){
                $res->whereRaw("cordis.fSalida <= '$fechaSalida' ");
                // $res->whereRaw("cordis.fSalida < date_add('$fechaSalida', interval 1 DAY) ");
            }else{
                $res->whereRaw("cordis.fSalida<= '$fechaMax' ");
            }
            
            if($origen!=null && $origen!="todos"){
                $res->whereRaw("disp.nOrigen=".$origen);
            }
            if($destino!=null){
                $res->whereRaw("disp.nDestino=".$destino);
            }

            if($totalPasajeros>0){
                $res->havingRaw("totalAsientos-count(disa.nDisponibilidad) >= $totalPasajeros");
            }
            if($hInicio!=null){
                // verificar como se compara
                $res->whereRaw("disp.hSalida>='".$hInicio."'");
            }
            if($hFin!=null){
                $res->whereRaw("disp.hSalida<='".$hFin."'");
            }
            $res->groupByRaw("cordis.nNumero, disp.nOrigen , disp.nDestino, dist.nAsientos");
            $res->orderByRaw("disp.fSalida, disp.hSalida, disp.fLlegada, disp.hLlegada");
        // dd($res->toSql());
        // dd($res->get());
        $res=$res->get();
        return $res;
    } 
}
