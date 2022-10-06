<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
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
}
