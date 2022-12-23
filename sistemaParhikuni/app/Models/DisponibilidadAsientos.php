<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DB;

class DisponibilidadAsientos extends Model
{
    use HasFactory;
    protected $table="disponibilidadasientos";
    protected $primaryKey = 'nDisponibilidad';

    public static function ocupados($id_disp){
        $retorno=array();
        $sql="SELECT DISTINCT(nAsiento), aEstadoAsiento FROM `disponibilidad` as disp
            INNER JOIN disponibilidadasientos as disa
            ON disa.nDisponibilidad=disp.nNumero
            where nNumero=:id
            ORDER BY nAsiento ASC";
        $rs=DB::select($sql, [
                'id' => $id_disp
            ]
        );
        foreach($rs as $asiento){
            // array_push($retorno, $asiento->nAsiento);
            // $retorno[$asiento->nAsiento]=true;
            $retorno[str_pad($asiento->nAsiento, 2, "0", STR_PAD_LEFT)]=true;
        }
        return $retorno;
    }

    public static function apartarAsiento($corrida, $origen, $destino, $asientos, $usuario){
        DB::beginTransaction();
        try{
            $rs=DB::SELECT("SELECT apartar_asiento(?,?,?,?,? ) as asientos",[
                $corrida, $origen, $destino, $asientos, $usuario
            ]);
            DB::commit();
            return $rs;
        }catch(\Exception $e){
            DB::rollback();
            throw $e;
        }
    }
}
