<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

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
}
