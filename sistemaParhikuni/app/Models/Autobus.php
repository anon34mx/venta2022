<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Personas;
use App\Models\CorridasDisponibles;
use App\Models\Corridasprogramadas;

class Autobus extends Model
{
    use HasFactory;
    protected $table='autobuses';
    protected $primaryKey = 'nNumeroAutobus';
    protected $hidden = [
        'nDistribuciónAsientos',
    ];
    protected $fillable = [
        'nNumeroEconomico',
        'nTipoServicio',
    ];

    // public function personas(){
    //     return $this->belongsTo(Personas::class, 'persona_nNumero', 'nNumeroPersona');
    // }
    public function corridasDisponibles(){
        return $this->belongsTo(
            CorridasDisponibles::class,
            'nNumeroAutobus',
            'nNumeroAutobus'
        );
    }
}