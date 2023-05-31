<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Corridasprogramadas;
use App\Models\Itinerario;
use App\Models\TiposServicios;

use DB;

class CorridasProgramadasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // php artisan migrate --seed --seeder=CorridasProgramadasSeeder
        $nuevaCorrida = Corridasprogramadas::create([
            'nItinerario' => rand(1, Itinerario::all()->groupBy("nItinerario")->count()),
            'nTipoServicio' => rand(1, TiposServicios::all()->count()),
            'hSalida' => date('H:i:s', rand(1, 86399)),
            'lLunes' => true,
            'lMartes' => true,
            'lMiercoles' => true,
            'lJueves' => true,
            'lViernes' => true,
            'lSabado' => true,
            'lDomingo' => true,
            'fInicio' => date("Y-m-d"),
            'fFin' => "2099-12-31",
        ]);
    }
}
