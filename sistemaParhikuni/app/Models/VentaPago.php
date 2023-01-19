<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VentaPago extends Model
{
    use HasFactory;

    protected $table = 'ventapago';
    protected $primaryKey = 'nNumero';
    protected $fillable = [
        "nVenta",
        "aFormaPago",
        "aFormaPagoSubtipo",
        "nMonto",
        "aFolioDocumento",
        "aAutorizacionBanco",
    ];
    protected $hidden = [
        "fCreacion"
    ];
}
