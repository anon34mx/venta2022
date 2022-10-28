<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoletosVendidos extends Model
{
    use HasFactory;
    protected $table = 'boletosvendidos';
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        //
    ];
    protected $fillable = [
        'nVenta',
        'nCorrida',
        'fSalida',
        'hSalida',
        'nOrigen',
        'nDestino',
        'aTipoPasajero',
        'aPasajero',
        'nAsiento',
        'aTipoVenta',
        'nMontoBase',
        'nMontoDescuento',
        'nIva',
        'aEstado',
        'fCreacion',
        'nTerminal',
    ];
}


