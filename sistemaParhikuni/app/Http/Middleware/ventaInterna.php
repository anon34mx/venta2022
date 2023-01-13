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
        if(session("asientosID")!=null){
            $act=DisponibilidadAsientos::refrescar(session("asientosID"));
            if($act<0){
                echo ("cancelar venta 1");
            }
        }else{
            echo ("No hay venta activa");
            // return redirect(route("corridas.disponibles.corridasFiltradas"));
            // dd(session()->all());
        }
        if(!$request->session()->has('pasoCompra')){
            session(["pasoCompra"=>1]);
        }else{
            echo (session("pasoCompra"));
        }
        
        if(true){
            return $next($request);
        }else{
            return back();
        }
        // return $next($request);
    }
}
