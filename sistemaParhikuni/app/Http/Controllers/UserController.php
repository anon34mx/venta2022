<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Personas;
use App\Models\Oficinas;

use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Http\Controllers\OficinasController;
use App\Http\Controllers\PersonasController;
use illuminate\Database\Eloquent\SoftDeletes;
use Auth;
use DB;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public $elementsPerPage=15;
    public function index(Request $request)
    {
        if ($request->has('search') && $request->search!="") {
            $users = User::
                where('users.name', 'like', '%'.$request->input('search').'%')
                ->orWhere('email', 'like', '%'.$request->input('search').'%')
                ->orWhere('users.id', 'like', '%'.$request->input('search').'%')
                ->paginate($this->elementsPerPage);
        } else {
            $users=User::orderBy('id')->paginate($this->elementsPerPage);
        }
        return view('users.index', [
            "users" => $users,
            "search" => $request->search,
            'roles' => Role::all(),
            'oficinas'  => OficinasController::all(),
            'tipospersonas' => PersonasController::tipos()
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $requestData = $request->validate([
            'name' => 'required',
            'email' => ['required', 'email', 'unique:users'],
            'password' => ['required', 'min:8'],
        ]);
        // dd($requestData);

        $user=User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password)
        ])->assignRole($request->role);

        if(isset($request->incPers)){
            $oficina=$request->nOficina;
            if($request->nOficina=="null"){
                $oficina=null;
            }
            $persona = PersonasController::store(
                $request->aNombres,
                $request->aApellidos,
                $oficina,
                $request->aTipo
            );
            $user->update([
                'persona_nNumero' => $persona
            ]);
        }

        return redirect('usuarios/'.$user->id)->with('status', 'Usuario creado');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        // dd(Auth::user()->personas);
        $user = User::find("$id");
        if($user==null){
            return redirect(route('users.index'))
                    ->withErrors("Usuario no encontrado");
        }
        if(Auth::user()->id!=$id && !Auth::user()->hasRole('Admin')){
            abort(403);
        }else{
            if(Auth::user()->personas->aTipo=="PG"){
                
                return view('users.edit_PG',[
                    'user' => $user,
                    'roles' => Role::all(),
                    'user_permissions' => $user->getDirectPermissions(),
                    'permissions' => Permission::all(),
                    'oficinas' => OficinasController::all()
                ]);
            }elseif(Auth::user()->personas->aTipo=="EI" && !Auth::user()->hasRole('Admin')){
                return view('users.edit_EI',[
                    'user' => $user,
                    'user_permissions' => $user->getDirectPermissions(),
                    'oficinas' => Oficinas::find($user->personas->nOficina)
                ]);
            }else{
                return view('users.edit',[
                    'user' => $user,
                    'roles' => Role::all(),
                    'user_permissions' => $user->getDirectPermissions(),
                    'permissions' => Permission::all(),
                    'oficinas' => OficinasController::all(),
                    'tipospersonas' => PersonasController::tipos(),
                ]);
            }
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user = User::find($id);
        $oficina=$request->nOficina;
        if($request->nOficina=="null"){
            $oficina=null;
        }
        if(Auth::user()->hasRole('Admin')){
            if(($user->persona_nNumero==null && isset($request->incPers)) || $user->persona_nNumero!=null){
                $requestData = $request->validate([
                    'nombreDeUsuario' => ['required', 'regex:/(^([a-zA-Z0-9\.-_]+)(\d+)?$)/'],
                    'correoElectronico' => ['required', 'email'],
                    'nombre' => ['required', 'min:3'],
                    'apellidos' => ['required', 'min:3'],
                    'nOficina' => ['required'],
                    'tipoPersona' => ['required'],
                ]);
            }else{
                $requestData = $request->validate([
                    'nombreDeUsuario' => ['required', 'regex:/(^([a-zA-Z0-9\.-_]+)(\d+)?$)/', 'unique:users,name'],
                    'correoElectronico' => ['required', 'email'],
                ]);
            }
            if($user->persona_nNumero==null && isset($request->incPers)){
                $persona = PersonasController::store(
                    $request->nombre,
                    $request->apellidos,
                    $oficina,
                    $request->tipoPersona
                );
                $user->update([
                    'persona_nNumero' => $persona
                ]);
            }elseif($user->persona_nNumero!=null){
                $persona = Personas::find($user->persona_nNumero);
                $persona->update([
                    "aNombres"=> $request->nombre,
                    "apellidos"=> $request->apellidos,
                    "nOficina" => $oficina,
                    "aTipo"=> $request->tipoPersona
                ]);
            }
            if($request->contraseña!=null){
                $requestData = $request->validate([
                    'contraseña' => ['required', 'min:8', 'max:255'],
                ]);
                $user->update([
                    "name" => $request->nombreDeUsuario,
                    "email" => $request->correoElectronico,
                    "password" => bcrypt($request->contraseña)
                ]);
            }else{
                $user->update([
                    "name" => $request->nombreDeUsuario,
                    "email" => $request->correoElectronico,
                ]);
            }
            return back()->with('status', 'Actualizado con éxito');
        }else{
            echo "no admin";
        }
    }
    public function updateAsUser(Request $request){
        $persona = Personas::find(Auth::user()->persona_nNumero);
        if(isset($request->contraseña)){
            // 'correoElectronico' => ['required', 'email', 'max:100'],
            $requestData = $request->validate([
                'nombreDeUsuario' => ['required', 'max:30'],
                'nombre' => ['required', 'min:3', 'max:50'],
                'apellidos' => ['required', 'min:3', 'max:50'],
                'contraseña' => ['required', 'min:8', 'max:255'],
            ]);
            $persona->update([
                "aNombres" => $request->nombre,
                "aApellidos" => $request->apellidos,
            ]);
            // "name" => $request->nombreDeUsuario,
            // "email" => $request->correoElectronico,
            Auth::user()->update([
                "password" => bcrypt($request->contraseña),
            ]);
        }else{
            // 'correoElectronico' => ['required', 'email', 'max:100'],
            $requestData = $request->validate([
                'nombreDeUsuario' => ['required', 'max:30'],
                'nombre' => ['required', 'min:3', 'max:50'],
                'apellidos' => ['required', 'min:3', 'max:50'],
                
            ]);
            $persona->update([
                "aNombres" => $request->nombre,
                "aApellidos" => $request->apellidos,
            ]);
            // Auth::user()->update([
            //      "name" => $request->nombreDeUsuario,
            //      "email" => $request->correoElectronico,
            //      "password" => bcrypt($request->contraseña),
            // ]);
        }
        return back()->with('status', 'Actualizado con éxito');
    }

    public function updateAsEI(Request $request){
        if($request->contraseña!=null){
            Auth::user()->update([
                "password" => bcrypt($request->contraseña),
            ]);
            return back()->with('status', 'Actualizado con éxito');
        }else{
            return back();
        }
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user=User::find($id);
        $user->delete();
        return back()->with('status', 'Eliminado con éxito');
    }

    public function addRol(Request $request, User $id){
        try{
            if(Auth::user()->hasRole('Admin') ){
                $id->assignRole($request->newRole);
                return back()->with('status', 'Actualizado con éxito');
            }else{
                abort(403);
            }
        }catch(Exception $e){
            return back()->with('status', 'Error<br>'.$e);
        }
    }
    public function removerol(User $id, Role $rol){
        try{
            if(Auth::user()->hasRole('Admin') ){
                $id->removeRole($rol);
                return back()->with('status', 'Actualizado con éxito');
            }else{
                abort(403);
            }
        }catch(Exception $e){
            return back()->with('status', 'Error<br>'.$e);
        }
    }
    public function addPermissions(User $id, Request $request){
        if($request->permissions){
            foreach($request->permissions as $permission=>$value){
                $id->givePermissionTo($permission);
            }
            return back()->with('status', 'Actualizado con éxito');
        }else{
            return back()->with('status', 'Selecciona los permisos');
        }
    }

    public function revokePermission(User $id, Request $request){
        $id->revokePermissionTo($request->permission);
        return back()->with('status', 'Permiso eliminado');
    }
}
