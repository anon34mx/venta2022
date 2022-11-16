<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use SoapClient;
use App\Models\SMS;
use App\Models\CorridasDisponibles;

class SmsController extends Controller
{
    public static function corridaBajaOcupacion($numcorrida){
        $texto="La corrida $numcorrida se despachó con baja ocupación";
        $numero="524432443657";
        
        $client=new SMS();
        
        return $resultado = $client->enviar_mensaje($texto,$numero);
        // echo $resultado['return'];
    }
}
