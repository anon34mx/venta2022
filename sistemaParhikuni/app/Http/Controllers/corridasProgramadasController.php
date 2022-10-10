<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Oficinas;
use App\Models\Corridasprogramadas;
use DB;

class corridasProgramadasController extends Controller
{
    public function index(){
        $corridasProgramadas=DB::select("SELECT * FROM `corridasprogramadas` WHERE lbaja=0");
        
        return view('corridasProgramadas.index',[
            "corridasProgramadas" => $corridasProgramadas
        ]);
    }

    public function edit($corridaProgramada){
        // dd(Corridasprogramadas::all());
        return view('corridasProgramadas.edit',[
            "corridaProgramada" => Corridasprogramadas::find($corridaProgramada),
        ]);
    }
}
