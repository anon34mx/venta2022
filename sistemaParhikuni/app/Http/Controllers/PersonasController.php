<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Personas;
use DB;

class PersonasController extends Controller
{
    static public function store($aNombres,$aApellidos,$nOficina,$aTipo){
        return DB::table('personas')->insertGetId([
                'aNombres' => $aNombres,
                'aApellidos' => $aApellidos,
                'nOficina' => $nOficina,
                'aTipo' => $aTipo
        ]);
    }
    static public function update($aNombres,$aApellidos,$nOficina,$aTipo){
        return DB::table('personas')->update([
                'aNombres' => $aNombres,
                'aApellidos' => $aApellidos,
                'nOficina' => $nOficina,
                'aTipo' => $aTipo
        ]);
    }
    static public function tipos(){
        return
            json_decode(
                DB::table('tipospersona')
                ->select('*')
                ->get()
            );
    }
}
