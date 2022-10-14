<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Itinerario;

class Tramos extends Model
{
    use HasFactory;
        protected $table = 'tramos';
    protected $primaryKey = 'nNumero';

    public function itinerario(){
        return $this->belongsTo(Itinerario::class, 'nNumero', 'nTramo');
    }
}
