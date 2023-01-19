<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\TipoPasajero;
use App\Models\Oficinas;
use App\Models\Venta;

use DB,PDF;
class BoletosVendidos extends Model
{
    use HasFactory;
    protected $table = 'boletosvendidos';
    protected $primaryKey = 'nNumero';
    protected $hidden = [
        //
    ];
    protected $fillable = [
        'nVenta',
        'nCorrida',
        'fSalida',
        'hSalida',
        'nOrigen',
        'nDestino',
        'aTipoPasajero',
        'aPasajero',
        'nAsiento',
        'aTipoVenta',
        'nMontoBase',
        'nMontoDescuento',
        'nIva',
        'aEstado',
        'fCreacion',
        'nTerminal',
    ];
    public function tipo(){
        return $this->hasOne(TipoPasajero::class, 'aClave', 'aTipoPasajero');
    }

    public function origen(){
        return $this->hasOne(Oficinas::class, "nNumero", "nOrigen");
    }
    public function destino(){
        return $this->hasOne(Oficinas::class, "nNumero", "nDestino");
    }

    public static function porVenta(Venta $venta){
        $sql="SELECT *
            FROM boletosvendidos
            WHERE nVenta=:venta";
        $rs=DB::select($sql,[
            "venta" => $venta->nNumero
        ]);

        // return var_dump($rs);
        // return view('PDF.boleto.2020_porNadia');
        return $pdf = PDF::loadView('PDF.boleto.2020_porNadia',[
            
        ])
        ->setPaper('letter', 'portrait')
        ->stream('filename.pdf');;
        //->download('pdfview.pdf');
    }
}


