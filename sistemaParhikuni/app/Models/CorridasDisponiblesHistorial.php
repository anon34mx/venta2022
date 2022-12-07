<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorridasDisponiblesHistorial extends Model
{
    use HasFactory;

    protected $primaryKey = 'id';
    protected $table = 'corridas_disponibles_historial';
    protected $hidden = [
        
    ];
    protected $fillable = [
        'corrida_disponible',
        'aEstadoAnterior',
        'aEstadoNuevo',
        'nConductor',
        'user',
        'nConsecutivo',
    ];
}
