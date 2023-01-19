<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

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
        if(!session()->has("sesionVenta")){
            // echo "Abrir sesion de venta";
        }
        if(session("asientosID")!=null){
            $act=DisponibilidadAsientos::refrescar(session("asientosID"));
            if($act<=0){
                dd("cancelar venta 1");
            }
        }

        if(true){
            return $next($request);
        }else{
            return redirect(route('corridas.disponibles.corridasFiltradas'));
        }
    }
}
