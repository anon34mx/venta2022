<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Oficinas;
use DB;

class RegistroPasoPuntos extends Model
{
    use HasFactory;
    protected $table = 'registropasopuntos';
    protected $primaryKey = 'nCorrida';
    protected $fillable = [
        "nCorrida",
        "nConsecutivo",
        "fLlegada",
        "fSalida",
    ];
}
