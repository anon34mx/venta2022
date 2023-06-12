<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\CorridasDisponibles;
use App\Models\BoletosVendidos;
use App\Models\DisponibilidadAsientos;

class PasajerosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $corrida=CorridasDisponibles::find(307);
        // dd($corrida);
        for ($i=9; $i < 20; $i++) { 
            BoletosVendidos::create([
                "nVenta" => 1,
                "nCorrida" => $corrida->nNumero,
                "lRegreso" => false,
                "fSalida" => $corrida->fSalida,
                "hSalida" => $corrida->hSalida,
                "nOrigen" => 5,
                "nDestino" => 8,
                "aTipoPasajero" => "AD",
                "aPasajero" => "abc",
                "nAsiento" => $i,
                "aTipoVenta" => "CO",
                "nMontoBase" => 0,
                "nMontoDescuento" => 0,
                "nIva" => 0,
                "aEstado" => "VE",
                "nTerminal" => 3
            ]);
            $dispon=collect(
                DisponibilidadAsientos::apartarAsiento(
                    $corrida->nNumero,
                    5,
                    8,
                    $i,
                    "V"
                )
            )->first();
        }
    }
}
