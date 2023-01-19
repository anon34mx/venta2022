<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\TipoPasajero;
use App\Models\Oficinas;
use App\Models\Venta;
use App\Models\CorridasDisponibles;

use DB,PDF,DNS1D,DNS2D;
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
    protected $appends = array(
        'codbar'
    );

    public function tipo(){
        return $this->hasOne(TipoPasajero::class, 'aClave', 'aTipoPasajero');
    }

    public function origen(){
        return $this->hasOne(Oficinas::class, "nNumero", "nOrigen");
    }
    public function destino(){
        return $this->hasOne(Oficinas::class, "nNumero", "nDestino");
    }
    public function corrida(){
        return $this->hasOne(CorridasDisponibles::class, "nNumero", "nCorrida");
    }

    // SET GET
    public function getCodbarAttribute(){
        return $this->codbar;
    }
    public function setCodbarAttribute($newValue){
        return $this->codbar=$newValue;  
    }
}


