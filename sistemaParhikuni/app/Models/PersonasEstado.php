<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Conductores;

class PersonasEstado extends Model
{
    // use HasFactory;

    public function conductores(){
        return $this->belongsTo(Conductores::class, 'aClave', 'aEstado');
    }
}
