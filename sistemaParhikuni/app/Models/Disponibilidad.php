<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\DisponibilidadAsientos;
use App\Models\Oficinas;
use DB;

class Disponibilidad extends Model
{
    use HasFactory;
    protected $table="disponibilidad";
    protected $primaryKey = 'nNumero';
    // protected $dates=["fSalida hSalida"];

    public function disponibilidadAsientos(){
        return $this->hasMany(DisponibilidadAsientos::class, 'nDisponibilidad', 'nNumero');
    }

    public function origen(){
        return $this->hasOne(Oficinas::class, "nNumero", "nOrigen");
    }
    public function destino(){
        return $this->hasOne(Oficinas::class, "nNumero", "nDestino");
    }
    
    public function tarifas(){
        // [?] se necesita redondear??
        $rs = collect(\DB::select("SELECT
            trta.nOrigen, trta.nDestino,
            FORMAT(nMontoBaseRuta,2) as tarifaRuta,
            FORMAT(nMontoBaseRuta*1.".env("IVA").", 2) as tarifaRutaConIVA,
            FORMAT(nMontoBaseRuta*0.".env("IVA").", 2) as tarifaRutaIVA,
            
            FORMAT(nMontoBasePaqueteria,2) tarifaPaque,
            FORMAT(nMontoBasePaqueteria*1.".env("IVA").",2) as tarifaPaqueConIVA,
            FORMAT(nMontoBasePaqueteria*0.".env("IVA").",2) as IVApaqueteria

            from corridasdisponibles as cordis
            INNER JOIN disponibilidad as disp
                on disp.nCorridaDisponible=cordis.nNumero
            INNER JOIN tarifastramos as trta
                ON trta.nOrigen=disp.nOrigen and trta.nDestino=disp.nDestino
                    AND trta.nTipoServicio=cordis.nTipoServicio
                    AND trta.fAplicacion<=CURRENT_DATE
            WHERE
            disp.nNumero=:disponibilidad
            ORDER BY trta.fAplicacion DESC
            LIMIT 1
            ",[
                "disponibilidad" => $this->nNumero
            ]))->first();
        return $rs;
    }
}
