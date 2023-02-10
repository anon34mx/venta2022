<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Auth;

use App\Models\DisponibilidadAsientos;

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
        // dd($request->all());
        if(!session()->has("sesionVenta")){
            return redirect(route('sesionesventa.usuario',[
                "user" => Auth::user()->id
            ]))->with('status', "Necesitas abrir sesion de venta para poder vender");
        }
        // dd($request->all());
        if($request->has('cancelada')){
            return redirect(route('venta.interna.corridas'))->with('status', $request->cancelada);
        }
        if($request->has('cancelada')){
            return redirect(route('venta.interna.corridas'))->with('status', $request->cancelada);
        }
        //  VER SI LOS ASIENTOS SIGUEN APARTADOS
        if(session()->has("asientosID")==true){
            $asientosApartados=DisponibilidadAsientos::comprobar(session("asientosID"));
            // dd($asientosApartados);
            if($asientosApartados==false){
                return redirect(route('venta.interna.cancelarCompra',[
                    "cancelada" => "No se encontraron los asientos apartados"
                ]));
            }
                                                                // 15 * 60 - Quince minutos
            // session(["tiempoCompra" => strtotime($asientosApartados->tiempo) + (15 * 60)]);
            session()->save();
        }
        //      REDIRIGIR SEGUN EN QUE PARTE DE LA COMPRA SE ENCUENTRA
        
        if(!session()->has("pasoVenta")){
            session([
                "pasoVenta" => 0,
            ]);
            session()->save();
            return redirect(route('venta.interna.corridas'));
        }
        
        $pasoSig=null;
        $lastUrl=substr(url()->previous(), strpos(url()->previous(), $_SERVER["HTTP_HOST"])+strlen($_SERVER["HTTP_HOST"]), 99);
        $nextUrl=substr(url()->current(), strpos(url()->current(), $_SERVER["HTTP_HOST"])+strlen($_SERVER["HTTP_HOST"]), 99);
        switch ($nextUrl) {
            case '/ventaInterna/corridas':
                $pasoSig=0;
                break;
            case '/ventaInterna/asientos':
                $pasoSig=1;
                break;
            case '/ventaInterna/apartar':
                $pasoSig=2;
                break;
            case '/ventaInterna/confirmacion':
                $pasoSig=3;
                break;
            case '/ventaInterna/confirmacion/guardar':
                $pasoSig=3.1;
                break;
            case '/ventaInterna/pago':
                $pasoSig=4;
                break;
            case '/ventaInterna/abonar':
                $pasoSig=4.1;
                break;
        }

        if($pasoSig!=session("pasoVenta")){
            if(session("pasoVenta")==0){
                return redirect(
                        route($this->pasoARuta(session("pasoVenta")))
                    )
                    ->withErrors('No estás en un proceso de venta. [cod:79]');
            }
            return redirect(route($this->pasoARuta(session("pasoVenta"))));
        }
        return $next($request);
    }

    public function pasoARuta($numeroPaso){
        switch ($numeroPaso) {
            case 0:
                return 'venta.interna.corridas';
                break;
            case 1:
                return 'venta.interna.asientos';
                break;
            case 2:
                return 'venta.interna.apartar';
                break;
            case 3:
                return 'venta.interna.confirmacion';
                break;
            case 3.1:
                return 'venta.interna.confirmacionGuardar';
                break;
            case 4:
                return 'venta.interna.pago';
                break;
            case 4.1:
                return 'venta.interna.abonar';
                break;
            default:
                return 'venta.interna.corridas';
                break;
        }
    }
}
