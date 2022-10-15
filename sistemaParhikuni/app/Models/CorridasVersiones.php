<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorridasVersiones extends Model
{
    use HasFactory;
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        'updated_at',
    ];
    protected $fillable = [
        'nNumero',
        'nItinerario',
        'nTipoServicio',
        'hSalida',
        'lLunes',
        'lMartes',
        'lMiercoles',
        'lJueves',
        'lViernes',
        'lSabado',
        'lDomingo',
        'fInicio',
        'fFin',
        'user_id',
    ];
}
