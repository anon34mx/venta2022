<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;

use Auth,Session;
use App\Models\Oficinas;
use App\Models\Sesiones;

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

    public function authenticated(){
        $tipoPersona = Auth::user()->personas->aTipo;
        if($tipoPersona=="EI" || $tipoPersona=="PA"){
            $oficina=Auth::user()->personas->nOficina;
            $oficina=Oficinas::find($oficina);

            $sesion=Sesiones::where("user_id","=", Auth::user()->id)
                ->orderBy("fContable", "desc")
                ->first();
            Session::put('oficinaNombre', $oficina->aNombre);
            Session::put('oficinaid', $oficina->nNumero);
            if($sesion["fCerrada"]==null){
                Session::put('sesionVenta', $sesion->nNumero);
            }
            // session("oficinaNombre") // recuperar dato
            // session("oficinaid") // recuperar dato
        }

        // dd($sesion);
    }
}
