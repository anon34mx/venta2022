<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use DB;

class Paqueteria extends Model
{
    use HasFactory;

    protected $hidden=[
        'vigencia_desde',
        'vigencia_hasta'
    ];

    public static function getListContenidoPaquete($valorBuscar){
        $sql_bus='SELECT id, texto,similares, MATCH(texto, similares) AGAINST(?) as certeza FROM ccp_20_productos_servicios
        WHERE
        MATCH(texto, similares) AGAINST(?) > 10
        OR
        texto like ?
        OR similares like ?
        ORDER BY certeza DESC
        LIMIT 15';

        return json_encode(
            \DB::select($sql_bus,[
                $valorBuscar,
                $valorBuscar,
                "%".$valorBuscar."%",
                "%".$valorBuscar."%",
            ])
        );
    }

    public static function getFactoresPaq(){
        return \DB::select(
            DB::raw('SELECT * FROM `factorpaqueteria`
                WHERE deleted_at IS NULL
                ORDER BY aTipo DESC, nValorMaximo ASC;'
            )
        );
    }
}
