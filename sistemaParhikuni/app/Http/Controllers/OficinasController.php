<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Oficinas;
use DB;

class OficinasController extends Controller
{
    //
    public static function all(){
        return json_decode(
            DB::table('oficinas')
            ->select('*')
            ->get()
        );
    }

    public function destinos($origen, $comp){
        /*
            $sql="
            SELECT od.nOrigen, od.nDestino,
            ori.aNombre as origen, ori.lDisponible as origenDis,
            des.aNombre as destino, des.lDisponible destinoDis
            FROM origenesdestinos od
            INNER JOIN oficinas as ori ON ori.nNumero=od.nOrigen
            INNER JOIN oficinas as des ON des.nNumero=od.nDestino
            WHERE -- od.nOrigen=8 AND
            ori.lDisponible=1 AND des.lDisponible=1
            ORDER BY ori.aNombre, des.aNombre
            ";
        */
        return (Oficinas::destinos($origen, $comp));
    }
}
