<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Personas;

class Oficinas extends Model
{
    use HasFactory;
    protected $primaryKey = 'nNumero';
        protected $hidden = [
        '_token',
    ];

    public function personas(){
        return $this->hasMany(Personas::class, "nOficina", "nNumero");
    }
}
