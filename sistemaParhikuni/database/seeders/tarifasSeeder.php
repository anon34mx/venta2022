<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use DB;
use App\Models\TarifasTramo;


class tarifasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $tramos = DB::select(
            DB::raw("SELECT tr.nNumero tramo, tr.nOrigen, tr.nDestino,
            ts.nNumero tser
            FROM tramos tr
            JOIN tiposervicio ts")
        );

        foreach ($tramos as $tramo) {
            // var_dump($tramo);
            // echo "<br><br>";
            $tarifa=rand(300,550);
            $nva=TarifasTramo::create([
                'nTipoServicio' => $tramo->tser.'',
                'nOrigen' => $tramo->nOrigen,
                'nDestino' => $tramo->nDestino,
                'nMontoBaseRuta' => $tarifa,
                'nMontoBasePaqueteria' => $tarifa+30,
                'fAplicacion' => date('Y-m-d h:i'),
            ]);
        }
    }
}
