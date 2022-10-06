<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class personasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    DB::table([
        'aNombres' => 'Jahaziel Aarón',
        'aApellidos' => 'Aguilera Castillo',
        'noficina' => 12,
        'aTipo' => 'EI'
    ]);
    DB::table([
        'aNombres' => 'ANGEL',
        'aApellidos' => 'ZAMORA DE JESUS',
        'noficina' => 12,
        'aTipo' => 'EI'
    ]);
    DB::table([
        'aNombres' => 'FRANCISCO JAVIER',
        'aApellidos' => 'ALVARADO LEMUS',
        'noficina' => 12,
        'aTipo' => 'EI'
    ]);
    DB::table([
        'aNombres' => 'PASCUAL',
        'aApellidos' => 'ESTEBAN GABRIEL',
        'noficina' => 12,
        'aTipo' => 'EI'
    ]);
    DB::table([
        'aNombres' => 'JESUS',
        'aApellidos' => 'CORNEJO MAULE',
        'noficina' => 12,
        'aTipo' => 'EI'
    ]);
    }
}
