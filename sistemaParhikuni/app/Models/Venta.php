<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\VentaPago;

use DB;

class Venta extends Model
{
    use HasFactory;
    protected $table = 'venta';
    protected $primaryKey = 'nNumero';
    protected $fillable = [
        "nSesion",
    ];
    protected $hidden = [
        "fCreacion"
    ];

    public function calcularAdeudo(){
        $sql="SELECT
            ven.nNumero, ven.created_at,
            SUM(bole.nMontoDescuento) as descuentoAplicado, SUM(bole.nMontoBase+bole.nIVA) as total,
            (SELECT SUM(nMonto) FROM `ventapago` WHERE nVenta=:IDventa1) as abonado
            FROM `venta` ven
            LEFT JOIN boletosvendidos bole
                on bole.nVenta=ven.nNumero
            WHERE ven.nNumero=:IDventa
            and bole.aEstado='VE'";
        return collect(
            DB::select($sql,[
                "IDventa" => $this->nNumero,
                "IDventa1" => $this->nNumero,
            ])
        )->first();
    }

    public function pagos(){
        return $this->hasMany(VentaPago::class, 'nVenta', 'nNumero');
    }
    public function boletos(){
        // si el metodo actual se pone lento usamos este
        // $sql_boletos="SELECT ven.nNumero as idVenta,
        // bol.nNumero as idBoleto, bol.fSalida, bol.hSalida, bol.aPasajero as pasajero, bol.nAsiento, bol.nMontoBase, bol.nMontoDescuento, bol.nIVA,
        // bol.aTipoPasajero, tipa.aDescripcion,
        // bol.nCorrida as corrida,
        // cordis.nTipoServicio, serv.aDescripcion as servicio,
        // bol.nOrigen, ofiOri.aNombre as origen, ofiOri.aEntidad, bol.nDestino, ofiDes.aNombre as destino, ofiDes.aEntidad,
        // (SELECT aFormaPago from ventapago vpg WHERE nVenta=ven.nNumero LIMIT 1) as formaPago
        // FROM `venta` ven
        // LEFT JOIN boletosvendidos as bol
        // on bol.nVenta=ven.nNumero
        // INNER JOIN tipopasajero tipa ON tipa.aClave=bol.aTipoPasajero
        // INNER JOIN oficinas as ofiOri
        // on ofiOri.nNumero=bol.nOrigen
        // INNER JOIN oficinas as ofiDes
        // on ofiDes.nNumero=bol.nDestino
        // INNER JOIN corridasdisponibles as cordis ON cordis.nNumero=bol.nCorrida
        // INNER JOIN tiposervicio as serv ON serv.nNumero=cordis.nTipoServicio
        // WHERE ven.nNumero=:venta and bol.aEstado='VE'";
        // $rs=collect(DB::select($sql_boletos,[
        //     "venta" => $this->nNumero
        // ]));
        // return $rs;
    }
}
