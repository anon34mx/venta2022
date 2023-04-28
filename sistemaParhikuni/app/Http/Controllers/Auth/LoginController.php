<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

use Auth,Session;
use App\Models\Oficinas;
use App\Models\Sesiones;
use App\Models\Terminales;
use Illuminate\Http\Request;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    public function authenticated(Request $request){
        $tipoPersona = Auth::user()->personas->aTipo;

        // dd($request->hwidValidator);
        $term=Terminales::where("hwid", "=", $request->hwidValidator)->first();
        if((isset($term->hwid) && !Auth::user()->hasRole('Admin')) || (isset($term->hwid) && Auth::user()->hasRole('Admin'))){
            Session::put('terminal', $term->nNumero);
        }elseif(!isset($term->hwid) && Auth::user()->hasRole('Admin')){
            $terminal="admin";
            Session::put('terminal', 1);
        }
        else{
            Auth::logout();
            $request->session()->invalidate();
            $request->session()->regenerateToken();
            return back()->withErrors("Ingresa desde un equipo autorizado");
        }

        if(!Auth::user()->hasRole('Admin') && !$request->has("browserValidator")){
            Auth::logout();
            $request->session()->invalidate();
            $request->session()->regenerateToken();
            return back()->withErrors("Ingresa con un software autorizado");
        }
        if($request->has("browserValidator")){
            Session::put('validBrowser', true);
        }else{
            Session::put('validBrowser', false);
        }
        
        if($tipoPersona=="EI" || $tipoPersona=="PA"){
            $oficina=Auth::user()->personas->nOficina;
            $oficina=Oficinas::find($oficina);

            $sesion=Sesiones::where("user_id","=", Auth::user()->id)
                ->orderBy("created_at", "desc")
                ->first();
            Session::put('oficinaNombre', $oficina->aNombre);
            Session::put('oficinaid', $oficina->nNumero);
            
            if($sesion){
                if($sesion["fCerrada"]==null){
                    Session::put('sesionVenta', $sesion->nNumero);
                }
            }
            // session("oficinaNombre") // recuperar dato
            // session("oficinaid") // recuperar dato
        }
    }
}
