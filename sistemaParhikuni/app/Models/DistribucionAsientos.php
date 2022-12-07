<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DistribucionAsientos extends Model
{
    use HasFactory;
    protected $table='distribucionasientos';
    protected $primaryKey = 'nNumero';
    protected $fillable = [
        'nNumero',
        'nAsientos',
        'aDistribucion',
    ];
    

    public function corridasDisponibles(){
        return $this->belongsTo(
            Autobus::class,
            'nNumero',
            'nDistribucionAsientos'
        );
    }
}
