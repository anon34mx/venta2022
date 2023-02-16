<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipoPasajero extends Model
{
    use HasFactory;

    protected $table = 'tipopasajero';
    protected $primaryKey = 'aClave';
    protected $fillable = [
        'aClave',
        'aDescripcion',
    ];
}
