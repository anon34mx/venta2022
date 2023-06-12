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
    public function estado(){
        return $this->hasOne(CorridasEstados::class, 'id', 'aEstado');
    }
    public function estadoActual($origen=null){
        if($origen==null || $this->aEstado=="T" || $this->aEstado=="C" || $this->aEstado=="B" || $this->aEstado=="L"){
            $sql="SELECT
                cordis.nNumero, '".addslashes($origen)."' as oficina,
                cordis.aEstado estadoID,
                IFNULL(est.aEstado, 'Disponible') as estado
                FROM 
                corridasdisponibles cordis
                LEFT JOIN corridas_estados as est
                    on est.id=cordis.aEstado
                WHERE cordis.nNumero=:cordis
            LIMIT 1";
            return $rs=collect(DB::select($sql,[
                "cordis" => $this->nNumero,
            ]))->first();
        }
        elseif($origen!=null){
            $sql="SELECT
                cordis.nNumero, '".addslashes($origen)."' as oficina,
                IFNULL(hist.aEstadoNuevo, 'D') estadoID,
                IFNULL(est.aEstado, 'Disponible') as estado
                FROM 
                corridasdisponibles cordis
                LEFT JOIN `corridas_disponibles_historial` hist
                    on hist.corrida_disponible=cordis.nNumero
                    AND hist.nNumeroOficina=:origen
                LEFT JOIN corridas_estados as est
                    on est.id=hist.aEstadoNuevo
                WHERE cordis.nNumero=:cordis
                ORDER BY hist.created_at DESC
            LIMIT 1";
            return $rs=collect(DB::select($sql,[
                "origen" => $origen,
                "cordis" => $this->nNumero,
            ]))->first();
        }
    }
    
    //Promociones usadas y disponibles
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

    // El recorrido
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

    // desde la tabla de disponibilidad
    // Como el itinerario pero ya con fecha/hora
    public function getRecorrido($origen=null, $destino=null){
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

    //Obtener en qué tramo consecutivo tiene X oficina
    public function getTramoOficina($oficina){
        $rs = collect(
         \DB::select("SELECT
            iti.nItinerario as itinerario, tr.nNumero as tramo, iti.nConsecutivo as consecutivo,tr.nOrigen as origen, tr.nDestino as destino
            FROM corridasDisponibles cordis
            INNER JOIN itinerario iti ON iti.nItinerario=cordis.nItinerario
            INNER JOIN tramos tr on tr.nNumero=iti.nTramo and tr.nOrigen=:oficina
            WHERE cordis.nNumero=:id
            ORDER BY iti.nConsecutivo ASC
            LIMIT 1",[
                "id" => $this->nNumero,
                "oficina" => $oficina,
            ]))->first();
        return $rs;
        // dd(gettype($rs));
        return array(
            "itinerario" => $rs->itinerario,
            "tramo" => $rs->tramo,
            "consecutivo" => $rs->consecutivo,
            "origen" => $rs->origen,
            "destino" => $rs->destino,
        );
    }

    // Ver checkpoints
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

    // Registrar checkpoint
    public function registrarPasoPunto(){
        /**
         * El conductor registra su llegada y salida de cada oficina
        */

        $registro=DB::select(
            "SELECT iti.nItinerario, iti.nConsecutivo as consecutivo, reg.nCorrida as registro ,reg.despachado, reg.fSalida, reg.fLlegada,
                max(iti.nConsecutivo) maxConsecutivo, tr.nDestino as destino
            FROM corridasDisponibles cordis
            INNER JOIN itinerario iti ON iti.nItinerario=cordis.nItinerario
            LEFT JOIN registropasopuntos reg ON reg.nCorrida=cordis.nNumero AND reg.nConsecutivo=iti.nConsecutivo
            LEFT JOIN tramos tr on tr.nNumero=iti.nTramo
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
                if($registro[0]->consecutivo == $registro[0]->maxConsecutivo && $registro[0]->fLlegada==null){
                    $this->update([
                        "aEstado" => "T"
                    ]);
                    CorridasDisponiblesHistorial::create([
                        "corrida_disponible" => $this->nNumero,
                        "aEstadoAnterior" => "R",
                        "aEstadoNuevo" => "T",
                        "user" => Auth::user()->id,
                        "nNumeroOficina" => $registro[0]->destino,
                    ]);
                }
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
        #registrar si es cambio por el usuario o el sistema (?)
        CorridasDisponiblesHistorial::create([
            "corrida_disponible" => $this->nNumero,
            "nNumeroOficina" => Auth::user()->personas->nOficina,
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

    // guia de boletos vendidos: muestra todos los boletos vendidos para X corrida, excluyendo paqueteria
    public function boletos(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero')
            ->where("aEstado", "!=", "CA")
            ->where("aTipoPasajero", "!=", "PQ");
            // ->where("aEstado", "!=", "VE");
    }

    // Boletos de paquetería
    public function paquetes(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero')
            ->where("aTipoPasajero", "=", "PQ");
            
    }

    // Boletos y paquetería en la corrida
    public function guiaPasajeros(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero')
            ->leftJoin("BoletosTransferidos as bt", "bt.boleto", "=", "boletosvendidos.nNumero")
            ->groupByRaw("boletosvendidos.nNumero, bt.boleto")
            ->orderBy("nAsiento", "asc")
            ->whereRaw("boletosvendidos.aEstado='VE' OR boletosvendidos.aEstado='AP'");
    }

    public function boletosEnGrupo(){
        // $sql="SELECT bv.nCorrida, bv.fSalida, bv.hSalida, bv.nOrigen, bv.nDestino, bv.aTipoVenta,
        // COUNT(nNumero) Viajan
        // FROM `boletosvendidos` bv
        // where nCorrida=7
        // GROUP by nVenta;";// SE CANCELA

        // Primero ver todas las ventas que se hicieron para esa corrida
        $sql="SELECT
        ven.nNumero as nVenta, bv.nCorrida, bv.fSalida, bv.hSalida, bv.nOrigen, bv.nDestino
        ,bv.aPasajero,bv.nAsiento
        ,COUNT(bv.nVenta) as viajanJuntos
        FROM `venta` ven
        INNER JOIN boletosvendidos bv
            on bv.nVenta=ven.nNumero and bv.nCorrida=:nCorrida
        GROUP BY ven.nNumero, bv.nCorrida -- HAVING viajanJuntos<2
        ";
        return collect(DB::select($sql,[
            ":nCorrida" => $this->nNumero
        ]));
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

    //Para buscar corridas
    public function filtrar($corrida=null, $origen=null, $destino=null, $fechaSalida=null, $fechaMax=null, $pasajeros=null,
    $hInicio="00:00:00", $hFin=null, $usarPromocion=null, $limit=999, $tipoBusqueda="exacta"){
        $totalPasajeros=0;
        foreach($pasajeros as $owo){
            $totalPasajeros+=$owo;
        }
        /*
        (SELECT
                COUNT(DISTINCT(nAsiento))
                FROM `disponibilidadasientos` disa
                WHERE disa.nDisponibilidad=disp.nNumero) as ocupados,
        */
        $res=$this::from("corridasdisponibles as cordis")
            ->selectRaw("cordis.nNumero as 'corrida',
                cordis.aEstado, IFNULL(hist.aEstadoNuevo, 'D') as 'estadoCorrida',
                (SELECT aEstado FROM corridas_estados where id=IFNULL(hist.aEstadoNuevo, 'D')) as edoUwu,
                autobus.nNumeroEconomico as autobus, dist.nAsientos as totalAsientos, autobus.nTipoServicio as claveServicio,
                tser.aDescripcion as claseServicio, tser.aClave as claveServicio,
                COUNT(bol.nNumero) as ocupados,

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
            });
            $res->leftJoin("boletosvendidos as bol", function($join){
                $join->on("bol.nCorrida", "=", "cordis.nNumero");
                $join->on("bol.aTipoPasajero", "!=", DB::raw("'PQ'"));
                $join->on("bol.nNumero", "=", "disa.nBoleto")
                    ->whereRaw( DB::raw('bol.aEstado="VE" OR bol.aEstado="AP"') );
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
            if($tipoBusqueda=="exacta"){
                //fecha inicio (fecha fin es el mismo dia)
                if($fechaSalida==null){
                    $res->whereRaw("cordis.fSalida=current_date");
                    if($hInicio!=""){
                        $res->whereRaw("disp.hSalida>='".$hInicio."'");
                    }
                }else{
                    $res->whereRaw("cordis.fSalida=IF( '$fechaSalida' < CURRENT_DATE, CURRENT_DATE, '$fechaSalida' )");
                    if($hInicio!=""){
                        $res->whereRaw("disp.hSalida>='".$hInicio."'");
                    }
                }
                // hora inicio
                // hora fin
            }
            elseif($tipoBusqueda=="absoluta"){
                # PARA admin/dev muestra lo más posible
            }

            if($origen!=null && $origen!="todos"){
                $res->whereRaw("disp.nOrigen=".$origen);
            }
            if($destino!=null){
                $res->whereRaw("disp.nDestino=".$destino);
            }
            if($totalPasajeros>0){
                $res->havingRaw("totalAsientos-ocupados >= $totalPasajeros");
            }
            if($hFin!=null){
                $res->whereRaw("disp.hSalida<='".$hFin."'");
            }
            $res->groupByRaw("cordis.nNumero, disp.nOrigen , disp.nDestino, dist.nAsientos");
            $res->orderByRaw("disp.fSalida, disp.hSalida, disp.fLlegada, disp.hLlegada");
            if($limit!=null){
                $res->take($limit);
            }
        // dd($res->toSql());
        $res=$res->get();
        return $res;
    }

    // para transferencia [a ver si despues la junto con la anterior]
    public static function getProxCorridas($fSalida, $hSalida, $nTipoServicio, $nOrigen, $nDestino){
        $fechaHoraMinBuscar=\Carbon\Carbon::createFromFormat("Y-m-d H:i:s", $fSalida." ".$hSalida)->addSeconds(1);//->format("Y-m-d H:i");
        $posiblesCorridas = collect (DB::select('SELECT cordis.*
            ,disa.nAsientos as asientos
            ,COUNT(bol.nNumero) as ocupados
            ,disa.nAsientos - COUNT(bol.nNumero) as libres,
            serv.aClave as claveServicio,
            serv.aDescripcion as servicio,
            disp.nOrigen, disp.nDestino
            FROM corridasdisponibles cordis
            INNER JOIN disponibilidad disp
                ON disp.nCorridaDisponible=cordis.nNumero

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
            AND cordis.aEstado!="C" AND cordis.aEstado!="B"
            AND cordis.nTipoServicio=:TipoServicio
            AND disp.nOrigen=:nOrigen AND disp.nDestino=:nDestino
            GROUP BY cordis.nNumero, cordis.nProgramada
            HAVING disa.nAsientos - COUNT(bol.nNumero)>0
            ORDER BY cordis.fSalida ASC, cordis.hSalida ASC',[
                "fSalidaInicio" => $fSalida,
                "fSalidaFin" => $fSalida,
                "TipoServicio" => $nTipoServicio,
                "nOrigen" => $nOrigen,
                "nDestino" => $nDestino,
            ]));
            echo json_encode($posiblesCorridas);
    }

    public function proximaTransferencia($corrida, $origen, $destino, $fechaIni, $horaIni, $fechaFin, $horaFin, $pasajeros){
        return collect(
            \DB::select(
                DB::raw(
                    'SELECT cordis.nNumero as "corrida",
                    cordis.aEstado, IFNULL(hist.aEstadoNuevo, "D") as "estadoCorrida",
                    autobus.nNumeroEconomico as autobus, dist.nAsientos as totalAsientos, autobus.nTipoServicio as claveServicio,
                    tser.aDescripcion as claseServicio, tser.aClave as claveServicio,
                    (SELECT COUNT(DISTINCT(nAsiento)) FROM `disponibilidadasientos` disa
                        WHERE disa.nDisponibilidad=disp.nNumero) as ocupados,
        
                    disp.nNumero as disp, disp.nOrigen, disp.nDestino, ori.aNombre as origen, des.aNombre as destino, disp.fSalida ,disp.hSalida,
                    disp.fLlegada, disp.hLlegada,
                    iti.nItinerario as itinerario, iti.nConsecutivo,
                    reg.despachado, reg.fLlegada as checkin, reg.fSalida as checkout,
                    (tatr.nMontoBaseRuta*1.16) as tarifaBase,
                    tser.descuentosMax
                    ,(SELECT count(prmsds.nBoletoVendido) FROM boletosvendidos_promociones prmsds
                        INNER JOIN boletosvendidos bol2 ON bol2.nNumero=prmsds.nBoletoVendido WHERE bol2.nCorrida=cordis.nNumero
                        ) as promosUsadas
                    from corridasdisponibles as cordis
                    inner join autobuses as autobus on autobus.nNumeroAutobus = cordis.nNumeroAutobus
                    inner join distribucionasientos as dist on dist.nNumero = autobus.nDistribucionAsientos
                    inner join tiposervicio as tser on tser.nNumero = autobus.nTipoServicio
                    inner join itinerario as iti on iti.nItinerario = cordis.nItinerario
                    inner join tramos as tr on tr.nNumero = iti.nTramo
                    inner join disponibilidad as disp on disp.nCorridaDisponible = cordis.nNumero and disp.nOrigen = tr.nOrigen
                    inner join oficinas as ori on ori.nNumero = disp.nOrigen
                    inner join oficinas as des on des.nNumero = disp.nDestino
                    left join registropasopuntos as reg on reg.nCorrida = cordis.nNumero and iti.nConsecutivo = reg.nConsecutivo
                    left join disponibilidadasientos as disa on disa.nDisponibilidad = disp.nNumero
                    left join boletosvendidos as bol on bol.nCorrida = cordis.nNumero and bol.aTipoPasajero != "PQ"
                        and (bol.aEstado = "VE" OR bol.aEstado="PA")
                        and bol.nNumero = disa.nBoleto
                    left join tarifastramos as tatr on tatr.nOrigen = disp.nOrigen
                        and tatr.nDestino = disp.nDestino and tatr.nTipoServicio = cordis.nTipoServicio and tatr.fAplicacion <= current_date
                    left join corridas_disponibles_historial as hist on hist.id = 
                    (SELECT id FROM corridas_disponibles_historial where corrida_disponible=cordis.nNumero and nNumeroOficina=disp.nOrigen ORDER BY created_at DESC LIMIT 1)
        
                    where
                    cordis.fSalida>=IF( :fechaIni < CURRENT_DATE, CURRENT_DATE, :fechaIni2 )
                    and disp.hSalida>IF( :horaIni = CURRENT_DATE, :horaIni2,  "00:00:00")
        
                    and cordis.fSalida<=:fechaFin and disp.hSalida<=:horaFin
        
                    and cordis.aEstado != "B" and cordis.aEstado != "C"
                    and disp.nOrigen=:origen and disp.nDestino=:destino
                    AND cordis.nNumero!=:corrida
        
                    group by cordis.nNumero, disp.nOrigen , disp.nDestino, dist.nAsientos
                    having totalAsientos-ocupados >= :pasajeros
                    order by disp.fSalida, disp.hSalida, disp.fLlegada, disp.hLlegada'
                )
                ,[
                    "corrida" => $corrida,
                    "origen" => $origen,
                    "destino" => $destino,
                    "fechaIni" => $fechaIni,
                    "fechaIni2" => $fechaIni,
                    "horaIni" => $horaIni,
                    "horaIni2" => $horaIni,
                    "fechaFin" => $fechaFin,
                    "horaFin" => $horaFin,
                    "pasajeros" => $pasajeros,
                ]
            )
        );
    }

    // Cuenta cuántos boletos se encuentran en proceso de venta para la oficina dada
    public function enVenta($oficina){
        $sql="SELECT COUNT(asi.id) as enProceso FROM `disponibilidadasientos` asi
            INNER JOIN disponibilidad as disp
                ON disp.nNumero=asi.nDisponibilidad
            WHERE asi.aEstadoAsiento='A'
            AND disp.nCorridaDisponible=:corrida
            AND disp.nOrigen=:oficina";
        return collect(
            \DB::select($sql,[
                "oficina" => $oficina,
                "corrida" => $this->nNumero,
            ])
        )->first()->enProceso;
    }

    // public function disponibilidadAsientosPro($origen, $destino, $modo){
    //     $asientos=array();
    //     $rs=DB::select(
    //         DB::raw('SELECT dist.nAsientos as asientos from corridasdisponibles cordis
    //             INNER JOIN autobuses aut ON aut.nNumeroAutobus=cordis.nNumeroAutobus
    //             INNER JOIN distribucionasientos dist ON dist.nNumero=aut.nDistribucionAsientos
    //             WHERE cordis.nNumero=:nCorrida

    //             UNION

    //             (SELECT
    //             disa.nAsiento as Ocupados
    //             FROM `disponibilidadasientos` disa
    //             INNER JOIN disponibilidad disp
    //                 ON disp.nNumero=disa.nDisponibilidad
    //             WHERE disp.nCorridaDisponible=:nCorrida2
    //             AND disp.nOrigen=:nOrigen and disp.nDestino=:nDestino
    //             GROUP BY disa.nAsiento
    //             ORDER BY disa.nAsiento)
    //         '),[
    //             'nCorrida' => $this->nNumero,
    //             'nCorrida2' => $this->nNumero,
    //             'nOrigen' => $origen,
    //             'nDestino' => $destino,
    //         ]
    //     );
    //     // dd($rs[0]->asientos -1 );
    //     if($modo=="libres"){
    //         for($i=0; $i<$rs[0]->asientos; $i++){
    //             echo $i."__".@$rs[$i]->asientos."<br>";
    //         }
    //     }
    // }
}
