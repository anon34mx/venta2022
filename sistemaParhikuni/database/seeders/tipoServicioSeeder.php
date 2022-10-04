<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use db;

class tipoServicioSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('tiposervicio')->insert([
            'nNumero' => 1,
            'aClave' => "PL",
            'aDescripcion' => "Platinum",
            'nDistribucionAsientos' =>  2
        ]);
        DB::table('tiposervicio')->insert([
            'nNumero' => 2,
            'aClave' => "UL",
            'aDescripcion' => 'Ultra',
            'nDistribucionAsientos' =>  3
        ]);
        DB::table('tiposervicio')->insert([
            'nNumero' => 3,
            'aClave' => "EX",
            'aDescripcion' => 'Express',
            'nDistribucionAsientos' =>  4
        ]);
        DB::table('tiposervicio')->insert([
            'nNumero' => 4,
            'aClave' => "PC",
            'aDescripcion' => 'Premium Class',
            'nDistribucionAsientos' =>  5
        ]);
        DB::table('tiposervicio')->insert([
            'nNumero' => 5,
            'aClave' => "CP",
            'aDescripcion' => 'Business Class',
            'nDistribucionAsientos' =>  5
        ]);
    }
}
