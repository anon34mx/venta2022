<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\TipoPasajero;
use DB;

class Promociones extends Model
{
    use HasFactory;

    protected $primaryKey = 'nNumero';
    protected $fillable = [
        "aTipo",
        "aDescripcion",
        "nDescuento",
        "nCorridaProgramada",
        "nOficina",
        "nOrigen",
        "nDestino",
        "viajeRedondo",
        "fInicio",
        "fFin",
        "nTipoServicio",
    ];

    public function tipoPasajero(){
        return $this->hasOne(TipoPasajero::class, "aClave", "aTipo");
    }

    public static function aplicables($origen, $destino, $oficina, $corrida, $viajeRedondo, $claseServicio){
        $rs=collect(\DB::select("(
                SELECT
                tipa.aClave as tipoPasajero, tipa.aDescripcion, tipa.descuento as descuentoPorTipo,
                prom.nNumero as id, prom.aDescripcion as descripPromo, prom.nDescuento porcentProm, prom.fInicio, prom.fFin
                FROM tipopasajero tipa
                LEFT JOIN `promociones` as prom
                    ON prom.fInicio<=CURRENT_DATE and prom.fFin>=CURRENT_DATE -- vigentes
                    AND (
                        nCorridaProgramada=:corrida
                        OR prom.nOficina=:oficina
                        OR (nOrigen=:origen and nDestino=:destino)
                        OR viajeRedondo=:viajeRedondo
                        OR nTipoServicio=:claseServicio
                        OR tipa.aClave='AD'
                        )
                    AND prom.aTipo=tipa.aClave -- fijo
                WHERE 
                prom.nNumero IS NOT NULL
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
                "corrida" => $corrida,
                "oficina" => $oficina,
                "viajeRedondo" => $viajeRedondo,
                "claseServicio" => $claseServicio,
            ]));
        return $rs;
    }
}
