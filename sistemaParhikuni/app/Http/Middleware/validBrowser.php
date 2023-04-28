<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Auth,Session;

class validBrowser
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle(Request $request, Closure $next)
    {   
        // dd(session("validBrowser"));
        // dd(Auth::user()->hasRole('Admin'));
        if(!Auth::user()->hasRole('Admin')){
            if(!session("validBrowser") ){
                // Aquí va la validación del navegador
                //!Auth::user()->hasRole('Admin') && !$request->has("browserValidator")
                Auth::logout();
                $request->session()->invalidate();
                $request->session()->regenerateToken();
                return redirect(route('login'))->withErrors("Ingresa con un software autorizado");
            }
            if(!session("terminal")){
                // Aquí va la validación del navegador
                //!Auth::user()->hasRole('Admin') && !$request->has("browserValidator")
                Auth::logout();
                $request->session()->invalidate();
                $request->session()->regenerateToken();
                return redirect(route('login'))->withErrors("Ingresa desde un dispositivo autorizado");
            }
        }
        return $next($request);
    }
}
