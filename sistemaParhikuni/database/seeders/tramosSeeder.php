<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Tramos;

class tramosSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Tramos::create([    //MORE-URUA
            'nNumero' => 1,
            'nOrigen' => 8,
            'nDestino' => 10,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //URUA-CCAM
            'nNumero' => 2,
            'nOrigen' => 10,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //CCAM-APAT
            'nNumero' => 3,
            'nOrigen' => 5,
            'nDestino' => 1,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //CCAM-ARTE
            'nNumero' => 4,
            'nOrigen' => 5,
            'nDestino' => 2,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //CCAM-LCAR
            'nNumero' => 5,
            'nOrigen' => 5,
            'nDestino' => 7,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //CCAM-IXTA
            'nNumero' => 6,
            'nOrigen' => 5,
            'nDestino' => 6,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //IXTA-ZIHU
            'nNumero' => 7,
            'nOrigen' => 6,
            'nDestino' => 11,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //APAT-BUEN
            'nNumero' => 8,
            'nOrigen' => 1,
            'nDestino' => 3,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //BUEN-TEPA
            'nNumero' => 9,
            'nOrigen' => 3,
            'nDestino' => 9,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //TEPA-COAL
            'nNumero' => 10,
            'nOrigen' => 9,
            'nDestino' => 4,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //COAL-TEPA
            'nNumero' => 11,
            'nOrigen' => 4,
            'nDestino' => 9,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //TEPA-BUEN
            'nNumero' => 12,
            'nOrigen' => 9,
            'nDestino' => 3,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //BUEN-APAT
            'nNumero' => 13,
            'nOrigen' => 3,
            'nDestino' => 1,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //APAT-CCAM
            'nNumero' => 14,
            'nOrigen' => 1,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //ARTE-CCAM
            'nNumero' => 15,
            'nOrigen' => 2,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //LCAR-CCAM
            'nNumero' => 16,
            'nOrigen' => 7,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //IXTA-CCAM
            'nNumero' => 17,
            'nOrigen' => 6,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //ZIHU-IXTA
            'nNumero' => 18,
            'nOrigen' => 11,
            'nDestino' => 6,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        Tramos::create([    //CCAM-URUA
            'nNumero' => 19,
            'nOrigen' => 5,
            'nDestino' => 10,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
        
        Tramos::create([    //URUA-MORE
            'nNumero' => 20,
            'nOrigen' => 10,
            'nDestino' => 8,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //MORE-CCAM
            'nNumero' => 21,
            'nOrigen' => 8,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //MORE-APAT
            'nNumero' => 22,
            'nOrigen' => 8,
            'nDestino' => 1,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //MORE-BUEN
            'nNumero' => 23,
            'nOrigen' => 8,
            'nDestino' => 3,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //URUA-CCAM
            'nNumero' => 24,
            'nOrigen' => 10,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //URUA-APAT
            'nNumero' => 25,
            'nOrigen' => 10,
            'nDestino' => 1,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //URUA-BUEN
            'nNumero' => 26,
            'nOrigen' => 10,
            'nDestino' => 3,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //CCAM-BUEN
            'nNumero' => 27,
            'nOrigen' => 5,
            'nDestino' => 3,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //ARTE-CCAM
            'nNumero' => 28,
            'nOrigen' => 2,
            'nDestino' => 5,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //ARTE-URUA
            'nNumero' => 29,
            'nOrigen' => 2,
            'nDestino' => 10,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //ARTE-MORE
            'nNumero' => 30,
            'nOrigen' => 2,
            'nDestino' => 8,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);

        Tramos::create([    //CCAM-MORE
            'nNumero' => 31,
            'nOrigen' => 5,
            'nDestino' => 8,
            'nKilometros' => 10,
            'nTiempo' => 10,
            'nEstancia' => 1,
        ]);
    }
}
