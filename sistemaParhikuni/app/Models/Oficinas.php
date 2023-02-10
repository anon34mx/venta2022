<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Personas;
use DB;

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

    public static function destinos($origen, $comprimir){
        $origenesDestinos = DB::table('origenesdestinos as od')
            ->selectRaw('od.nOrigen, od.nDestino,
                ori.aNombre as origen,
                des.aNombre as destino')
            ->join("oficinas as ori", "ori.nNumero", "=", "od.nOrigen")
            ->join("oficinas as des", "des.nNumero", "=", "od.nDestino")
            ->whereRaw("ori.lDisponible=1 AND des.lDisponible=1");
        if($origen!=0 && $origen!="todos"){
            $origenesDestinos->whereRaw("od.nOrigen=".$origen);
        }
        $origenesDestinos=$origenesDestinos->get();
        // dd($comprimir);
        if($comprimir=="true"){
            // dd("comprimir");
            $last="";
            $oficinas=array();
            foreach($origenesDestinos as $oficina){
                if($oficina->nOrigen != $last){
                    $oficinas[$oficina->nOrigen]["origen"]=$oficina->origen;
                    $oficinas[$oficina->nOrigen]["nNumero"]=$oficina->nOrigen;
                    $oficinas[$oficina->nOrigen]["destinos"]=array();
                }
                $oficinas[$oficina->nOrigen]["destinos"][$oficina->nDestino]=array(
                    "nNumero" => $oficina->nDestino,
                    "aNombre" => $oficina->destino
                );

                $last=$oficina->nOrigen;
            }
            $origenesDestinos=$oficinas;
        }
        return ($origenesDestinos);
    }
}
