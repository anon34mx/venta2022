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
    public function estado(){
        return $this->hasOne(CorridasEstados::class, 'id', 'aEstado');
    }
    public function getItinerario(){
        // return "Aquí va el itinerario.<br>".$this->nNumero;
        return DB::select("SELECT
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
            order by iti.nConsecutivo ASC", [
                'id' => $this->nNumero
            ]
        );
    }
    // return DB::select("SELECT
    //     iti.nItinerario as 'itinerario', iti.nConsecutivo as 'consecutivo',
    //     tr.nNumero as 'tramo',
    //     tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
    //     tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
    //     FROM corridasdisponibles cordis
    //     INNER JOIN itinerario as iti on iti.nItinerario=cordis.nItinerario
    //     INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
    //     INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
    //     INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
    //     where cordis.nNumero=:id -- parametro
    //     order by iti.nConsecutivo ASC", [
    //         'id' => $this->nNumero
    //     ]
    // );

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

    public function filtrar($origen=null, $destino=null, $fechaSalida=null, $fechaMax=null){
        $res=$this::from("corridasdisponibles as cordis")
            ->selectRaw("cordis.nNumero as 'corrida', cordis.aEstado as 'estado',
                autobus.nNumeroEconomico as autobus, dist.nAsientos as totalAsientos, autobus.nTipoServicio as claveServicio, tser.aDescripcion as claseServicio,
                (select count(nAsiento) from disponibilidadasientos disa where disa.nDisponibilidad=disp.nNumero) as ocupados,
                disp.nNumero as disp, disp.nOrigen, disp.nDestino, ori.aNombre as origen, des.aNombre as destino, disp.fSalida ,disp.hSalida,
                disp.fLlegada, disp.hLlegada,
                iti.nItinerario as itinerario, iti.nConsecutivo,
                reg.despachado, reg.fLlegada as checkin, reg.fSalida as checkout,
                tatr.nMontoBaseRuta as tarifaBase, tatr.nIVA as iva")
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
            ->leftJoin("boletosvendidos as boletos", function($join){
                $join->on("boletos.nCorrida", "=", "cordis.nNumero");
                $join->on("boletos.nOrigen", "=", "disp.nOrigen");
                $join->on("boletos.nDestino", "=", "disp.nDestino");
            })
            ->leftJoin("tarifastramos as tatr", function($join){
                $join->on("tatr.nOrigen", "=", "disp.nOrigen");
                $join->on("tatr.nDestino", "=", "disp.nDestino");
                $join->on("tatr.nTipoServicio", "=", "cordis.nTipoServicio");
            });

            $res->whereRaw("cordis.fSalida>=current_date");
            // $res->whereRaw("cordis.fSalida<= date_add(current_date(), interval 1 DAY) ");

            if($fechaSalida==null){
                $res->whereRaw("cordis.fSalida>=current_date");
            }else{
                $res->whereRaw("cordis.fSalida>=$fechaSalida");
            }
            if($fechaMax==null){
                $res->whereRaw("cordis.fSalida<= date_add(current_date(), interval 1 DAY) ");
            }else{
                $res->whereRaw("cordis.fSalida<= $fechaMax ");
            }
            if($origen!=null){
                $res->whereRaw("disp.nOrigen=".$origen);
            }
            if($destino!=null){
                $res->whereRaw("disp.nDestino=".$destino);
            }

            $res->whereRaw("reg.despachado IS NULL");

            $res->groupByRaw("cordis.nNumero, disp.nOrigen , disp.nDestino")
            ->orderByRaw("cordis.nNumero, iti.nConsecutivo, disp.fSalida, disp.hSalida, tatr.fAplicacion DESC");
        $res=$res->get();
        return $res;
    } 
}
