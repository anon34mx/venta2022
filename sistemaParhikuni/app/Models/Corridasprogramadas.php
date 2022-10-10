<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Corridasprogramadas extends Model
{
    use HasFactory;
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        'lBaja',
    ];
    protected $fillable = [
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
    ];
}
