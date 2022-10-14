<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Corridasprogramadas;

class TiposServicios extends Model
{
    use HasFactory;
    protected $table = 'tiposervicio';
    protected $primaryKey = 'nNumero';

    public function corridasProgramadas(){
        return $this->belongsTo(Corridasprogramadas::class, 'nNumero', 'nNumero');
    }
}
