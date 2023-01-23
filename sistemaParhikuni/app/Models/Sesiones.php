<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\User;

class Sesiones extends Model
{
    use HasFactory;
    protected $table="sesiones";
    protected $primaryKey = 'nNumero';
    protected $fillable = [
        'user_id',
        'nOficina',
        'persona_nNumero',
        "fContable",
        "fCerrada",
        "nMontoRecibido",
    ];

    public function oficina(){
        return $this->hasOne(Oficinas::class, "nNumero", "nOficina");
    }
    public function usuario(){
        return $this->hasOne(User::class, "id", "user_id");
    }
}
