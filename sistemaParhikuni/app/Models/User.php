<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use App\Models\Personas;

class User extends Authenticatable
{
    use HasFactory, Notifiable, HasRoles, SoftDeletes; // HasApiTokens, 

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'persona_nNumero',
    ];
    private $oficinaNombre="";

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
        'updated_at',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function personas(){
        return $this->belongsTo(Personas::class, 'persona_nNumero', 'nNumeroPersona');
    }

    public function setOficinaNombre($nvaOfi){
        return $this->oficinaNombre=$nvaOfi;
    }
    public function getOficinaNombre(){
        return $this->oficinaNombre;
    }
}
