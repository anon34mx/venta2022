<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Corridasprogramadas;
use DB;

class TiposServicios extends Model
{
    use HasFactory;
    protected $table = 'tiposervicio';
    protected $primaryKey = 'nNumero';

    public function corridasProgramadas(){
        return $this->belongsTo(Corridasprogramadas::class, 'nNumero', 'nNumero');
    }

    public function serviciosAbordo(){
        // return $this->hasMany("tiposervicioabordo tsa", "tsa.tiposervicio_id", "=", "tiposervicio.nNumero")->toSql();
        return
        // collect(
            DB::select(
                DB::raw("SELECT
                sab.*
                FROM `tiposervicioabordo` tsa
                INNER JOIN serviciosabordo sab
                ON tsa.servicioabordo_id=sab.id
                WHERE tiposervicio_id=:id_servicio"),[
                    "id_servicio" => $this->nNumero
                ]
                );
        // );
    }
}
