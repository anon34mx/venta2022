<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use DB;

class PeriodosVacacionales extends Model
{
    use HasFactory;

    protected $fillable = [
        'inicio',
        'fin',
    ];

    public static function aplicable($ida=null, $regreso=null){
        $rs=DB::select("SELECT * FROM `periodos_vacacionales`
            WHERE
            ? BETWEEN inicio and fin
            OR ? BETWEEN inicio and fin",[
                $ida,
                $regreso,
            ]);
        // $rs=DB::table('periodos_vacacionales')->whereBetween(DB::raw("'$ida'"), ["periodos_vacacionales.inicio", "fin"])->toSql();
        if($rs!=null){
            return true;
        }else{
            return false;
        }
    }
}
