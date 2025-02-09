<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use DB;

class distribucionAsientosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
         DB::table('distribucionasientos')->insert([
            'nNumero' => 1,
            'nAsientos' => 32,
            'aDistribucion' => "01T,02T,00,03T,04T|05T,06T,00,07T,08T|09T,10T,00,11T,12T|13T,14T,00,15T,16T|17T,18T,00,19T,20T|21T,22T,00,23T,24T|25T,26T,00,27T,28T|29T,30T,00,31T,32T|BM,00,CA,00,BH" 
         ]);

         DB::table('distribucionasientos')->insert([
            'nNumero' => 2,
            'nAsientos' => 24,
            'aDistribucion' => "01T,02T,00,03T|04T,05T,00,06T|07T,08T,00,09T|10T,11T,00,12T|13T,14T,00,15T|16T,17T,00,18T|19T,20T,00,21T|22T,23T,00,24T|BM,00,CA,00,BH" 
         ]);
         DB::table('distribucionasientos')->insert([
            'nNumero' => 3,
            'nAsientos' => 40,
            'aDistribucion' => "01T,02,03,04T|05,06,07,08|09,10,11,12|13T,14,15,16T|17,18,19,20|21,22,23,24|25T,26,27,28T|29,30,31,32|33,34,35,36|37,38,39,40|BM,00,CA,00,BH" 
         ]);
         DB::table('distribucionasientos')->insert([
            'nNumero' => 4,
            'nAsientos' => 40,
            'aDistribucion' => "01,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16T|17,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,00,00|39,40,00,00,00|CA,00,00,00,BU" 
         ]);
         DB::table('distribucionasientos')->insert([
            'nNumero' => 5,
            'nAsientos' => 40,
            'aDistribucion' => "01T,02,00,03,04|05,06,00,07,08|09,10,00,11,12|13,14,00,15,16|17T,18,00,19,20|21,22,00,23,24|25,26,00,27,28|29T,30,00,31,32|33,34,00,35,36|37,38,00,39,40|CA,00,00,00,BU" 
         ]);
         DB::table('distribucionasientos')->insert([
            'nNumero' => 6,
            'nAsientos' => 42,
            'aDistribucion' => "05,06,00,07,08|09,10,00,11,12T|13,14,00,15,16|17,18,00,19,20|21T,22,00,00,PU|23,24,00,25,26|27,28,00,29,30T|31,32,00,33,34|35,36,00,37,38|39,40,00,00,00|41,42,00,00,00|00,00,00,0C,BU" 
         ]);
    }
}
