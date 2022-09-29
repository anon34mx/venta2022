<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

class corridasProgramadas extends Controller
{
    public function index(){
        $corridasProgramadas=DB::select("SELECT * FROM `corridasprogramadas` WHERE lbaja=0");
        
        return view('corridasProgramadas.index',[
            "corridasProgramadas" => $corridasProgramadas
        ]);
    }
}
