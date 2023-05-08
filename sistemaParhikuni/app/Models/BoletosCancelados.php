<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoletosCancelados extends Model
{
    use HasFactory;
    protected $table="BoletosCancelados";
    protected $fillable = [
        'nBoletoVendido',
        'nBoletoNuevo',
    ];
}
