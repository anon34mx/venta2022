<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Personas;

class conductores extends Model
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
}
