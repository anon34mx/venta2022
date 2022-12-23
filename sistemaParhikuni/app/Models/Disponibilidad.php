<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\DisponibilidadAsientos;
use App\Models\Oficinas;

class Disponibilidad extends Model
{
    use HasFactory;
    protected $table="disponibilidad";
    protected $primaryKey = 'nNumero';
    // protected $dates=["fSalida hSalida"];

    public function disponibilidadAsientos(){
        return $this->hasMany(DisponibilidadAsientos::class, 'nDisponibilidad', 'nNumero');
    }

    public function origen(){
        return $this->hasOne(Oficinas::class, "nNumero", "nOrigen");
    }
    public function destino(){
        return $this->hasOne(Oficinas::class, "nNumero", "nDestino");
    }
}
