<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Tramos;
use DB;

class ItinerariosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Itinerario::create([
        //     "nItinerario" => 1,
        //     "nConsecutivo" => 1,
        //     "nTramo" => $tramo,
        // ]);
        // $ofiOri=Oficinas::find("MORE");
        // return ($ofiOri);
        // exit;
        // $tramo=Tramos::where("nOrigen", "=", Oficinas::whereRaw('aClave="MORE"')->first()->nNumero);
        // dd($tramo);

        // me dio hueva meter todo el código con laravel/eloquent, es mejor SQL
        DB::unprepared('
            INSERT INTO `itinerario`(`nItinerario`, `nConsecutivo`, `nTramo`) VALUES
            (1,1,1), -- MORE - urua

            (2,1,1), -- MORE - ccam
            (2,2,2),

            (3,1,1), -- MORE - apat
            (3,2,2),
            (3,3,3),

            (4,1,1), -- MORE-BUEN
            (4,2,2),
            (4,3,3),
            (4,4,8),

            (5,1,1), -- MORE-TEPA
            (5,2,2),
            (5,3,3),
            (5,4,8),
            (5,5,9),

            (6,1,1), -- MORE-COAL
            (6,2,2),
            (6,3,3),
            (6,4,8),
            (6,5,9),
            (6,6,10),

            (7,1,1), -- MORE-ARTE
            (7,2,2),
            (7,3,4),
            
            (8,1,1), -- MORE-ZIHU
            (8,2,2),
            (8,3,6),
            (8,4,7),
            -- ----------------------------------------------------
            
            (9,1,18), -- ZIHU-MORE
            (9,2,17),
            (9,3,19),
            (9,4,20),
            
            (10,1,15), -- ARTE-MORE
            (10,2,19),
            (10,3,20),
            
            (11,1,16), -- LCAR-MORE
            (11,2,19),
            (11,3,20),
            
            (12,1,11), -- COAL-MORE
            (12,2,12),
            (12,3,13),
            (12,4,14),
            (12,5,19),
            (12,6,20),

            (13,1,12), -- TEPA-MORE
            (13,2,13),
            (13,3,14),
            (13,4,19),
            (13,5,20),

            (14,1,13), -- BUEN-MORE
            (14,2,14),
            (14,3,19),
            (14,4,20),

            (15,1,14), -- APAT-MORE
            (15,2,19),
            (15,3,20),

            (16,1,19), -- CCAM-MORE
            (16,2,20),

            (17,1,20) -- CCAM-MORE
        ');
    }
}
