<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CorridasConductores extends Model
{
    use HasFactory;
    protected $fillable = [
        'nNumeroCorrida',
        'nNumeroConductor',
        'nNumeroUsuario',
    ];
}
