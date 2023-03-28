<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoPasajero extends Model
{
    use HasFactory;

    public $incrementing = false; // poner este si la clave primaria no es de tipo numérico ._.
    protected $table = 'tipopasajero';
    protected $primaryKey = 'aClave';
    protected $fillable = [
        'aClave',
        'aDescripcion',
    ];
}
