<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\TipoPasajero;
use App\Models\Oficinas;

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
    public function tipo(){
        return $this->hasOne(TipoPasajero::class, 'aClave', 'aTipoPasajero');
    }

    public function origen(){
        return $this->hasOne(Oficinas::class, "nNumero", "nOrigen");
    }
    public function destino(){
        return $this->hasOne(Oficinas::class, "nNumero", "nDestino");
    }
}


