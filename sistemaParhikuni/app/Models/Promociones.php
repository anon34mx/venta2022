<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DB;

class Promociones extends Model
{
    use HasFactory;

    public static function aplicables($tiposPasajeros, $origen, $destino){
        $rs=collect(\DB::select("(
                SELECT
                tipa.aClave as tipoPasajero, tipa.aDescripcion, tipa.descuento as descuentoPorTipo,
                prom.nNumero as id, prom.aDescripcion as descripPromo, prom.nDescuento porcentProm, prom.fInicio, prom.fFin
                FROM tipopasajero tipa
                LEFT JOIN `promociones` as prom
                    ON prom.aTipo=tipa.aClave and prom.fInicio<=CURRENT_DATE and prom.fFin>=CURRENT_DATE -- vigentes
                    AND (
                        nCorridaProgramada=6
                        OR prom.nOficina=13
                        OR (nOrigen=:origen and nDestino=:destino)
                        OR viajeRedondo=true
                        OR nTipoServicio=1
                    )
                WHERE tipa.aClave='AD'
                AND prom.nNumero IS NOT NULL
                ORDER BY prom.nNumero, tipa.aClave, prom.nDescuento asc
            )
            UNION
            (
                SELECT
                tipa.aClave as tipoPasajero, tipa.aDescripcion, tipa.descuento as descuentoPorTipo,
                prom.nNumero clavePromo, prom.aDescripcion as descripPromo, prom.nDescuento porcentProm, prom.fInicio, prom.fFin
                FROM tipopasajero tipa
                LEFT JOIN `promociones` as prom
                    ON prom.aTipo=tipa.aClave and prom.fInicio<=CURRENT_DATE and prom.fFin>=CURRENT_DATE -- vigentes
                WHERE
                tipa.aClave!='AD' AND aTipo IS NOT NULL
                GROUP BY prom.aTipo
                ORDER BY tipa.aClave, prom.nDescuento asc
            )",[
                "origen" => $origen,
                "destino" => $destino,
            ]));
        return $rs;
    }
}
