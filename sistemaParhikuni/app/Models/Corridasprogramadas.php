<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\TiposServicios;
use App\Models\Itinerario;
use App\Models\Tramos;
use DB;

class Corridasprogramadas extends Model
{
    use HasFactory, SoftDeletes;
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        'lBaja',
    ];
    protected $fillable = [
        'nItinerario',
        'nTipoServicio',
        'hSalida',
        'lLunes',
        'lMartes',
        'lMiercoles',
        'lJueves',
        'lViernes',
        'lSabado',
        'lDomingo',
        'fInicio',
        'fFin',
    ];
    public function servicio(){
        return $this->hasOne(TiposServicios::class, 'nNumero', 'nTipoServicio');
    }
    public function itinerario(){
        return $this->hasMany(Itinerario::class, 'nItinerario', 'nItinerario');
    }
    public function getItinerario(){
        // return "Aquí va el itinerario.<br>".$this->nNumero;
        return DB::select("SELECT
            iti.nItinerario as 'itinerario', iti.nConsecutivo as 'consecutivo',
            tr.nNumero as 'tramo',
            tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
            tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
            FROM corridasprogramadas corpro
            INNER JOIN itinerario as iti on iti.nItinerario=corpro.nItinerario
            INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
            INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
            INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
            where corpro.nNumero=:id -- parametro
            order by iti.nConsecutivo ASC", [
                'id' => $this->nNumero
            ]);
    }
    public function cancelar(){
        $disponibles = DB::statement("UPDATE corridasprogramadas corpro
            INNER JOIN corridasdisponibles cordis
                ON cordis.nProgramada=corpro.nNumero
            LEFT JOIN boletosvendidos bol
                ON bol.nCorrida=cordis.nNumero
            SET corpro.deleted_at=now(),
                cordis.aEstado='C',
                bol.aEstado='LM'
            where corpro.nNumero=:id",
            [
            'id' => $this->nNumero,
        ]);
        // corpro.deleted_at=now()
        // cordis.deleted_at=now(),
        return $disponibles;
    }
}

