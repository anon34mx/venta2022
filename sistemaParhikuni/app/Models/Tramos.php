<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Itinerario;
use App\Models\Oficinas;
use DB;

class Tramos extends Model
{
    use HasFactory;
    protected $table = 'tramos';
    protected $primaryKey = 'nNumero';
    protected $fillable=[
        "nOrigen",
        "nDestino",
        "nKilometros",
        "nTiempo",
        "nEstancia",
    ];

    public function itinerario(){
        return $this->belongsTo(Itinerario::class, 'nNumero', 'nTramo');
    }
    public function origen(){
        return $this->belongsTo(Oficinas::class, 'nOrigen', 'nNumero');
    }
    public function destino(){
        return $this->belongsTo(Oficinas::class, 'nDestino', 'nNumero');
    }

    public static function tramosNuevos(){
        // $rs=DB::table("origenesdestinos as orde")
        //     ->selectRaw("ofiOri.nNumero as nOrigen, ofiOri.aNombre as origen,ofiDes.nNumero as nDestino, ofiDes.aNombre as destino")
        //     ->join("oficinas as ofiOri", "ofiOri.nNumero", "=", "orde.nOrigen")
        //     ->join("oficinas as ofiDes", "ofiDes.nNumero", "=", "orde.nDestino")
        //     ->orderByRaw("ofiOri.aNombre, ofiDes.aNombre");
        // if($origen!=null){
        //     $rs->whereRaw("ofiOri.nNumero=".$origen);
        //     return $rs->get();
        // }
        // return $rs->get();
        return DB::select("SELECT ori.nNumero as nOrigen, ori.aNombre as origen,
            des.nNumero nDestino, des.aNombre as destino
            FROM `oficinas` as ori
            INNER join oficinas as des
                on ori.nNumero!=des.nNumero
            LEFT JOIN tramos as tr
                on tr.nOrigen=ori.nNumero and tr.nDestino=des.nNumero
            WHERE ori.lDestino=true and des.lDestino=true
            AND tr.nNumero IS NULL
            ORDER BY ori.aNombre, des.aNombre
        ");
    }
}
