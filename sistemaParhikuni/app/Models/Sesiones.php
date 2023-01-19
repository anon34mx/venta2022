<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sesiones extends Model
{
    use HasFactory;
    protected $table="sesiones";
    protected $primaryKey = 'nNumero';
    protected $fillable = [
        'nNumeroPersona',
        'nOficina',
        'persona_nNumero',
    ];
}
