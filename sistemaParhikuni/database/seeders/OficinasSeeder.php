<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use DB;

class OficinasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    
    public function run()
    {
        DB::table('oficinas')->insert([
            'nNumero' => 1,
            'aClave' => 'APAT',
            'aNombre' =>  'Apatzingán',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 2,
            'aClave' => 'ARTE',
            'aNombre' =>  'Arteaga',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 3,
            'aClave' => 'BUEN',
            'aNombre' =>  'Buenavista',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 4,
            'aClave' => 'COAL',
            'aNombre' =>  'Coalcomán',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 5,
            'aClave' => 'CCAM',
            'aNombre' =>  'Cuatro caminos',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 6,
            'aClave' => 'IXTA',
            'aNombre' =>  'Ixtapa',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 7,
            'aClave' => 'LCAR',
            'aNombre' =>  'Lázaro Cárdenas',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 8,
            'aClave' => 'MORE',
            'aNombre' =>  'Morelia',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 9,
            'aClave' => 'TEPA',
            'aNombre' =>  'Tepalcatepec',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 10,
            'aClave' => 'URUA',
            'aNombre' =>  'Uruapan',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 11,
            'aClave' => 'ZIHUA',
            'aNombre' =>  'Zihuatanejo',
            'aTipo' => 'int',
            'lDestino' => 1
        ]);
        DB::table('oficinas')->insert([
            'nNumero' => 12,
            'aClave' => 'PEMO',
            'aNombre' =>  'Pensión morelia',
            'aTipo' => 'int',
            'lDestino' => 0
        ]);
    }
}
