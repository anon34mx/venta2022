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
            $retorno[str_pad($asiento->nAsiento, 2, "0", STR_PAD_LEFT)]=true;
        }
        return $retorno;
    }

    public static function apartarAsiento($corrida, $origen, $destino, $asientos){
        // DB::beginTransaction();
        try{
            $rs=collect(
                DB::SELECT("SELECT apartar_asiento(?,?,?,?,?,?) as asientos",[
                    $corrida, $origen, $destino, $asientos, Auth::user()->id, 'A', null
                ])
            )->first()->asientos;
            // DB::commit();
            return $rs;
        }catch(\Exception $e){
            // DB::rollback();
            throw $e;
        }
    }

    public static function desocupar($ids){
        if(substr($ids,strlen($ids)-1)){
            $ids=substr($ids,0,strlen($ids)-1);
        }
        $ids=explode(",", $ids);
        return DB::table('disponibilidadasientos')->whereIn("id", $ids)->delete();
    }

    public static function refrescar($asientos, $tiempo=null){
        $sql_select="SELECT refrescar_asientos(:asientos, :tiempo) as actualizados, now() as tiempo";
        return DB::select($sql_select,[
            "asientos" => $asientos,
            "tiempo" => $tiempo,
        ])[0];
    }
    public static function comprobar($ids){
        $ids=substr($ids, 0, strlen($ids)-1);
        $ids=explode(",", $ids);
        $rs=DB::table("disponibilidadasientos")
            ->whereIn("id", $ids)->get();
        if(sizeof($rs)==sizeof($ids)){
            return true;
        }else{
            return false;
        }
    }
    public function enProcesoCompra($cordis, $origen){
        return $rs=DB::table("disponibilidadasientos as disa")
            ->join("disponibilidad as disp", "disa.nDisponibilidad", "=", "disp.nNumero")
            ->where("disp.nCorridaDisponible", "=", $cordis)
            ->where("disa.aEstadoAsiento", "=", "A")
            ->get();
    }


    public static function registrarBoleto($asientos, $idBoleto, $fhSalida){
        $sql="UPDATE `disponibilidadasientos`
            SET aEstadoAsiento='V',
            nBoleto=:idBoleto,
            last_update=:fhSalida
        WHERE id in ($asientos) "; // AND aEstadoAsiento='A'
        // dd($sql);
        $rs=DB::statement($sql, [
            "idBoleto" => $idBoleto,
            // "asientos" => $asientos,
            "fhSalida" => $fhSalida,
        ]);
        return($rs);
    }
}