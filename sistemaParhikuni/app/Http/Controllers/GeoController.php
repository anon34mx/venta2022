<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class GeoController extends Controller
{
    public function estados(){
        $rs=DB::select('SELECT * FROM cat_ageeml.`estados`');
        return $rs;
    }
    public function estado($estado_id){
        $rs=DB::select('SELECT * FROM cat_ageeml.`estados` WHERE id=:estado_id',[
            "estado_id" => $estado_id
        ]);
        return $rs;
    }
    public function getMunicipiosEstado(Request $request){
        // dd($request->all());
        $rs=DB::select('SELECT mun.clave, mun.nombre
            FROM cat_ageeml.`municipios` mun
            INNER JOIN cat_ageeml.estados edo
            ON edo.clave=mun.estado_id
            WHERE
            edo.id=:estado_id AND mun.nombre like :municipio',[
            'estado_id' => $request->estado,
            'municipio' => $request->municipio.'%',
        ]);
        return ($rs);
    }
    public function getAsentamientos(Request $request){
        // dd($request->all());
        $rs=DB::select('SELECT mun.clave, mun.nombre
            FROM cat_ageeml.`municipios` mun
            INNER JOIN cat_ageeml.estados edo
            ON edo.clave=mun.estado_id
            WHERE
            edo.id=:estado_id AND mun.nombre like :municipio',[
            'estado_id' => $request->estado,
            'municipio' => $request->municipio.'%',
        ]);
        return ($rs);
    }
}