<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use Illuminate\Database\Eloquent\SoftDeletes;

// use App\Models\Personas;
use App\Models\conductores;
use App\Models\Autobus;
use App\Models\CorridasEstados;
use App\Models\BoletosVendidos;
use App\Models\CorridasDisponiblesHistorial;
use DB;
use Auth;

class CorridasDisponibles extends Model
{
    use HasFactory; //, SoftDeletes
    protected $table = 'corridasdisponibles';
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        'nProgramada',
    ];
    protected $fillable = [
        'aEstado',
        'nNumeroAutobus',
        'nNumeroConductor',
    ];

    public function servicio(){
        return $this->hasOne(TiposServicios::class, 'nNumero', 'nTipoServicio');
    }
    public function conductor(){
        return $this->hasOne(conductores::class, 'nNumeroConductor', 'nNumeroConductor');
    }
    public function autobus(){
        return $this->hasOne(Autobus::class, 'nNumeroAutobus', 'nNumeroAutobus');
    }
    public function estado(){
        return $this->hasOne(CorridasEstados::class, 'id', 'aEstado');
    }
    public function getItinerario(){
        // return "Aquí va el itinerario.<br>".$this->nNumero;
        return DB::select("SELECT
            iti.nItinerario as 'itinerario', iti.nConsecutivo as 'consecutivo',
            tr.nNumero as 'tramo',
            tr.nOrigen, ofiOri.aClave as 'claveOrigen', ofiOri.aNombre as 'origen',
            tr.nDestino, ofiDes.aClave as 'claveDestino', ofiDes.aNombre as 'destino'
            FROM corridasdisponibles cordis
            INNER JOIN itinerario as iti on iti.nItinerario=cordis.nItinerario
            INNER JOIN tramos as tr on tr.nNumero=iti.nTramo
            INNER JOIN oficinas ofiOri on ofiOri.nNumero=tr.nOrigen
            INNER JOIN oficinas ofiDes on ofiDes.nNumero=tr.nDestino
            where cordis.nNumero=:id -- parametro
            order by iti.nConsecutivo ASC", [
                'id' => $this->nNumero
            ]);
    }
    public function cambiarEstado($edo){
        CorridasDisponiblesHistorial::create([
            "corrida_disponible" => $this->nNumero,
            "aEstadoAnterior" => $this->aEstado,
            "aEstadoNuevo" => $edo,
            "user" => Auth::user()->id,
        ]);
        $this->update([
            "aEstado" => $edo
        ]);
    }
    public function desbloquear(){
        $ultimoHist=CorridasDisponiblesHistorial::where("corrida_disponible", "=", $this->nNumero)
            ->orderBy("created_at","DESC")
            ->first();
        // dd($ultimoHist->aEstadoAnterior);
        CorridasDisponiblesHistorial::create([
            "corrida_disponible" => $this->nNumero,
            "aEstadoAnterior" => $this->aEstado,
            "aEstadoNuevo" => $ultimoHist->aEstadoAnterior,
            "user" => Auth::user()->id,
        ]);

        $this->update([
            "aEstado" => $ultimoHist->aEstadoAnterior
        ]);
        return $this;
    }

    public function boletosVendidos(){
        return $this->hasMany(BoletosVendidos::class, 'nCorrida', 'nNumero');
    }

    public function boletosEnLimbo(){
        return DB::select('
            SELECT *
                FROM `boletosvendidos`
                where nCorrida=:id AND aEstado="LM"
            ', [
                'id' => $this->nNumero
            ]);
    }

    public static function filtrar(){
        return "owo";
    }
}
