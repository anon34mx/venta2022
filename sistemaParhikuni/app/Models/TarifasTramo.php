<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\TiposServicios;
use App\Models\Oficinas;

class TarifasTramo extends Model
{
    use HasFactory;
    protected $table="tarifastramos";
    protected $primaryKey = 'nNumero';
    protected $fillable = [
        'nTipoServicio',
        'nOrigen',
        'nDestino',
        'nMontoBaseRuta',
        'nMontoBasePaqueteria',
        'fAplicacion',
    ];

    public function servicio(){
        return $this->belongsTo(TiposServicios::class, 'nTipoServicio', 'nNumero');
    }
    public function origen(){
        return $this->hasOne(Oficinas::class, 'nNumero', 'nOrigen');
    }
    public function destino(){
        return $this->hasOne(Oficinas::class, 'nNumero', 'nDestino');
    }
}
