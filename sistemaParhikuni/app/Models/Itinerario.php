<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Corridasprogramadas;
use App\Models\Tramos;
use DB;

class Itinerario extends Model
{
    use HasFactory;
    protected $table = 'itinerario';
    protected $primaryKey = 'nItinerario';
    protected $fillable = [
        'nItinerario',
        'nConsecutivo',
        'nTramo',
    ];

    public function corridasProgramadas(){
        return $this->belongsToMany(
            Corridasprogramadas::class,
            'nItinerario',
            'nItinerario');
    }

    public function tramos(){
        return $this->hasMany(
            Tramos::class,
            'nNumero',
            'nTramo'
        );
    }

    static public  function unicos(){
        return DB::select("SELECT
            iti.nItinerario as 'id'
            FROM itinerario as iti
            GROUP by iti.nItinerario ASC");
    }
    static public  function unicosDetallado(){
        $itinerarios = DB::select("SELECT
            iti.nItinerario as 'id'
            FROM itinerario as iti
            GROUP by iti.nItinerario ASC");
        $retorno = array();
        foreach($itinerarios as $itinerario){
            $retorno[$itinerario->id]=DB::select("SELECT
                iti.nItinerario as 'id', iti.nConsecutivo as 'consecutivo',
                tr.nNumero as 'tramo', tr.nTiempo, tr.nEstancia,
                tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
                tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
                FROM itinerario as iti
                INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
                INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
                INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
                WHERE iti.nItinerario=:id
                order by iti.nItinerario ASC,iti.nConsecutivo ASC",[
                    'id' => $itinerario->id,
                ]);
        }

        return $retorno;
    }
    public function itinerarios(){
        return DB::select("SELECT
            iti.nItinerario as 'id', iti.nConsecutivo as 'consecutivo',
            tr.nNumero as 'tramo',
            tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
            tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
            FROM itinerario as iti
            INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
            INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
            INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
            order by iti.nItinerario ASC,iti.nConsecutivo ASC");
    }
    public function detalle($id){
        return DB::select("SELECT
            iti.nItinerario as 'id', iti.nConsecutivo as 'consecutivo',
            tr.nNumero as 'tramo',
            tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
            tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
            FROM itinerario as iti
            INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
            INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
            INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
            WHERE iti.nItinerario=:id
            order by iti.nItinerario ASC,iti.nConsecutivo ASC",[
                'id' => (isset($id) ? $id: $this->nItinerario),
            ]);
    }
}
