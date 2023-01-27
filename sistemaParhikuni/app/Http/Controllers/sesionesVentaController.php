<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;
use App\Models\Sesiones;
use App\Models\Venta;
use App\Models\Oficinas;
use Auth, DB;
class sesionesVentaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request){
        $sesiones=Sesiones::query();
        $usuarios=User::query()->join("personas","personas.nNumeroPersona","=", "persona_nNumero");
        $oficinas=Oficinas::all();

        if(!Auth::user()->hasRole("Admin")){
            $usuarios->where("nOficina","=", Auth::user()->personas->nOficina);
        }
        
        if($request->has("fechaDeInicio") && $request->fechaDeInicio!=""){
            $sesiones->whereDate("fContable", ">=", $request->fechaDeInicio);
        }else{
            $sesiones->whereRaw("fContable = current_date");
        }
        if($request->has("fechaDeFin") && $request->fechaDeFin!=""){
            $sesiones->whereDate("fContable", "<=", $request->fechaDeFin);
        }
        if($request->has("usuario") && $request->usuario!=""){
            $sesiones->where("user_id", "=", $request->usuario);
        }
        
        // $sesiones=$sesiones->toSql();
        // dd($sesiones);
        $sesiones=$sesiones->paginate(20);
        //->get();
        $usuarios=$usuarios->get();
        return view('sesionesVEnta.index',[
            "sesiones" => $sesiones,
            "usuarios" => $usuarios,
            "oficinas" => $oficinas,
            "mostrarFiltros" => true
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    // public function create(){
        //
    // }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request){
        if(!session()->has("sesionVenta")){
            try {
                $sesionVenta=Sesiones::create([
                    "user_id"=>Auth::user()->id,
                    "fContable"=>date('Y-m-d'),
                    "nOficina"=>session("oficinaid"),
                ]);
                session(["sesionVenta" => $sesionVenta->nNumero]);
                return back()->with('status', 'Sesión abierta');
            } catch (\Throwable $th) {
                throw $th;
                 return back()->withErrors([
                    "msg" => "Hubo un error"
                ]);
            }
        }
        // return back();
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    // public function show($id){
        //
    // }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit(Sesiones $sesion){
        if($sesion->fCerrada!=null){
            //la sesion ya se habia cerrado
            if(Auth::user()->hasRole("Admin")){
                return redirect(route('sesionesventa.index'));
            }else{
                return redirect(route('sesionesventa.usuario'));
            }
        }
        return view('sesionesVenta.edit',[
            "sesion" => $sesion
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Sesiones $sesion, Request $request){
        if($sesion->fCerrada==null){
                $sesion->update([
                    "fCerrada" => date("Y-m-d H:i:s"),
                    "nMontoRecibido" => $request->recibido
                ]);
                session()->forget('sesionVenta');
                if(Auth::user()->hasRole("Admin")){
                    return redirect(route('sesionesventa.index'))->with('status', 'Sesión cerrada');
                }else{
                    return redirect(route('sesionesventa.usuario'))->with('status', 'Sesión cerrada');
                }
        }else{
            if(Auth::user()->hasRole("Admin")){
                return redirect(route('sesionesventa.index'))->withErrors([
                    "msg" => "Ya se había cerrado la sesión."
                ]);
            }else{
                return redirect(route('sesionesventa.usuario'))->withErrors([
                    "msg" => "Ya se había cerrado la sesión."
                ]);
            }
            // back()->withErrors([
            //     "msg" => "Ya se había cerrado la sesión."
            // ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id){
        //
    }

    public function porUsuario(){
        $sesiones=Sesiones::where("user_id","=", Auth::user()->id)
            ->orderBy("fContable", "desc")
            ->limit(20)
            ->paginate(20);
            // ->get();
        return view('sesionesVenta.index',[
            "sesiones" => $sesiones,
            "usuarios" => [],
            "oficinas" => [],
            "mostrarFiltros" => false
        ]);
    }
}
