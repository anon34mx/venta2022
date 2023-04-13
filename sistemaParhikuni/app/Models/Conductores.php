<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Personas;
use App\Models\PersonasEstado;
use App\Models\Autobus;

class Conductores extends Model
{
    use HasFactory;
    protected $table = 'conductores';
    protected $primaryKey = 'nNumeroConductor';

    protected $fillable = [
        'aLicencia',
        'fVigenciaLicencia',
        'nNumeroAutobus',
    ];

    public function persona(){
        return $this->hasOne(Personas::class, 'nNumeroPersona', 'nNumeroPersona');
    }
    public function autobus(){
        return $this->hasOne(Autobus::class, 'nNumeroAutobus', 'nNumeroAutobus');
    }
    public function estado(){
        return $this->hasOne(PersonasEstado::class, 'aClave', 'aEstado');
    }
}
