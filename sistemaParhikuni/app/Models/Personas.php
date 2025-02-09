<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Oficinas;

class Personas extends Model
{
    use HasFactory;
    protected $primaryKey = 'nNumeroPersona';
    protected $hidden = [
        '_token',
        'updated_at',
    ];
    protected $fillable = [
        'aNombres',
        'aApellidos',
        'nOficina',
        'aTipo',
    ];

    public function user(){
        return $this->hasOne(User::class);
    }
    public function oficina(){
        return $this->belongsTo(Oficinas::class, 'nOficina', );
    }
}
