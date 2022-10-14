<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Corridasprogramadas;

class CorridasEstados extends Model
{
    use HasFactory;
        protected $fillable = [
        'id',
        'aEstado',
    ];
    public $incrementing = false;

    public function corridasDisponibles(){
        return $this->belongsTo(Corridasprogramadas::class, "aEstado", "id");
    }
}
