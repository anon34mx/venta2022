<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Auth;

use App\Models\DisponibilidadAsientos;
use Carbon\Carbon;

class ventaInterna
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next){
        // dd(@session("ida")["asientosID"]);
        if(session()->has("cmpra_tiempoCompra")){
            $fhSesion=Carbon::createFromTimestamp(session("cmpra_tiempoCompra"))->toDateTimeString(); 
            $fhActual=Carbon::now();
            if( $fhActual->gte($fhSesion) ){
                // dd("timeout");
                return redirect(route('venta.interna.cancelarCompra', [
                    "cancelada" => "Se agotó el tiempo para comprar"
                ]));
            }
        }


        if(!session()->has("sesionVenta")){
            return redirect(route('sesionesventa.usuario',[
                "user" => Auth::user()->id
            ]))->with('status', "Necesitas abrir sesion de venta para poder vender");
        }
        if($request->has('cancelada')){
            return redirect(route('venta.interna.corridas'))->with('status', $request->cancelada);
        }
        //  VER SI LOS ASIENTOS SIGUEN APARTADOS
        if(session()->has("ida_asientosID") == true){
            $asientosApartados=DisponibilidadAsientos::comprobar(session("ida_asientosID"));
            if($asientosApartados==false){
                return redirect(route('venta.interna.cancelarCompra',[
                    "cancelada" => "No se encontraron los asientos apartados"
                ]));
            }
            // session(["tiempoCompra" => strtotime($asientosApartados->tiempo) + (15 * 60)]);
            session()->save();
        }
        //      REDIRIGIR SEGUN EN QUE PARTE DE LA COMPRA SE ENCUENTRA
        
        if(!session()->has("cmpra_pasoVenta")){
            session([
                "cmpra_pasoVenta"=>0,
            ]);
            session()->save();
            return redirect(route('venta.interna.corridas'));
        }
        $pasoSig=null;
        $lastUrl=substr(url()->previous(),strpos(url()->previous(), $_SERVER["HTTP_HOST"])+strlen($_SERVER["HTTP_HOST"]));
        $lastUrl=substr($lastUrl, 0, strpos($lastUrl, "?")?:strlen($lastUrl));

        // $nextUrl=substr(url()->current(), strpos(url()->current(), $_SERVER["HTTP_HOST"])+strlen($_SERVER["HTTP_HOST"]));
        $nextUrl=substr(url()->current(),strpos(url()->current(), $_SERVER["HTTP_HOST"])+strlen($_SERVER["HTTP_HOST"]));
        $nextUrl=substr($nextUrl, 0, strpos($nextUrl, "?")?:strlen($nextUrl));
        switch ($nextUrl) {
            case '/ventaInterna/corridas':
                $pasoSig=0;
                break;
            case '/ventaInterna/corridas/guardarFiltros':
                $pasoSig=0.1;
                break;
            case '/ventaInterna/asientos/ida':
                $pasoSig=1;
                break;
            case '/ventaInterna/apartar':
                $pasoSig=1.1;
                break;
            
            case '/ventaInterna/corridas/regreso':
                $pasoSig=2;
                break;
            case '/ventaInterna/corridas/regreso/guardar':
                $pasoSig=2.1;
                break;
            case '/ventaInterna/asientos/regreso':
                $pasoSig=3;
                break;
            case '/ventaInterna/asientos/regreso/guardar':
                $pasoSig=3.1;
                break;

            case '/ventaInterna/confirmacion':
                $pasoSig=4;
                break;
            case '/ventaInterna/confirmacion/guardar':
                $pasoSig=4.1;
                break;
            case '/ventaInterna/pago':
                $pasoSig=5;
                break;
            case '/ventaInterna/abonar':
                $pasoSig=5.1;
                break;
            default:
                $pasoSig="?";
                break;
        }
        // dd($lastUrl, $nextUrl, $pasoSig, session("cmpra_pasoVenta"));
        if($pasoSig!=session("cmpra_pasoVenta")){
            if(session("cmpra_pasoVenta")==0){
                return redirect(
                        route($this->pasoARuta(session("cmpra_pasoVenta")))
                    )
                    ->withErrors('No estás en un proceso de venta. [cod:79]');
            }
            return redirect(route($this->pasoARuta(session("cmpra_pasoVenta"))));
        }
        return $next($request);
    }

    public function pasoARuta($numeroPaso){
        switch ($numeroPaso) {
            case 0:
                return 'venta.interna.corridas';
                break;
            case 0.1:
                return 'venta.interna.guardarFiltros';
                break;
            case 1:
                return 'venta.interna.asientos';
                break;
            case 1.1:
                return 'venta.interna.apartar';
                break;
            case 2:
                return 'venta.interna.corridasRegreso';
                break;
            case 2.1:
                return 'venta.interna.corridasRegresoGuardar';
                break;
            case 3:
                return 'venta.interna.asientosRegreso';
                break;
            case 3.1:
                return 'venta.interna.asientosRegreso.guardar';
                break;
            case 4:
                return 'venta.interna.confirmacion';
                break;
            case 4.1:
                return 'venta.interna.confirmacionGuardar';
                break;
            case 5:
                return 'venta.interna.pago';
                break;
            case 5.1:
                return 'venta.interna.abonar';
                break;
            default:
                return 'venta.interna.corridas';
                break;
        }
    }
}
