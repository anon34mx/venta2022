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
        if(!session("validBrowser")){
            // Aquí va la validación del navegador
            //!Auth::user()->hasRole('Admin') && !$request->has("browserValidator")
            Auth::logout();
            $request->session()->invalidate();
            $request->session()->regenerateToken();
            return redirect(route('login'))->withErrors("Ingresa con un software autorizado");
        }
        return $next($request);
    }
}
