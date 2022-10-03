<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Auth;
use DB;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $elementsPerPage=15;
        if ($request->has('search') && $request->search!="") {
            /*
            with(['roles' => function($q){
                $q->where('name', 'admin');
            }])
            */
            $users = User::
                where('users.name', 'like', '%'.$request->input('search').'%')
                ->orWhere('email', 'like', '%'.$request->input('search').'%')
                ->orWhere('users.id', 'like', '%'.$request->input('search').'%')
                
                // ->toSql();
                // dd($users);
                ->paginate($elementsPerPage);
        } else {
            $users=User::orderBy('id')->paginate($elementsPerPage);
        }
        return view('users.index', [
            "users" => $users,
            "search" => $request->search,
            'roles' => Role::all()
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
        // dd($request->role);
        $request->validate([
            'name' => 'required',
            'email' => ['required', 'email', 'unique:users'],
            'password' => ['required', 'min:8'],
        ]);
        $user=User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password)
        ])->assignRole($request->role);
        // return back();
        return redirect('usuarios/'.$user->id)->with('status', 'Usuario creado');;
        // return redirect()->route('venta.finalizar', [
        //     "transaccion" => $transaccionId,
        //     "mode" => "preview",
        //     "email" => $transaccion[0]->email
        // ]);
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
        $user = User::find($id);
        if(Auth::user()->id!=$id && !Auth::user()->hasRole('Admin')){
            abort(403);
        }else{
            // $user->getDirectPermissions() // permisos asignados directamente
            // $user->getAllPermissions(); // permisos directos y por medio de roles
            return view('users.edit',[
                'user' => $user,
                'roles' => Role::all(),
                'user_permissions' => $user->getDirectPermissions(),
                'permissions' => Permission::all()
            ]);
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
        // Empleados internos sólo pueden cambiar su contraseña
        if(Auth::user()->hasRole([
            'servicios'
        ])){
            User::find($id)->update([
                "password" => bcrypt($request->password)

            ]);
            return back()->with('status', 'Actualizado con éxito');
        }

        if($request->password != ""){
            User::find($id)->update([
                "name" => $request->name,
                "email" => $request->email,
                "password" => bcrypt($request->password)

            ]);
            return back()->with('status', 'Actualizado con éxito');
        }else{
            User::find($id)->update([
                "name" => $request->name,
                "email" => $request->email
            ]);
            return back()->with('status', 'Actualizado con éxito');
            
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
        // dd($request->permissions);
        if($request->permissions){
            foreach($request->permissions as $permission=>$value){
                // var_dump($permission);
                // var_dump($value);

                // echo "<br>";exit;
                $id->givePermissionTo($permission);
            }
            return back()->with('status', 'Actualizado con éxito');
        }else{
            return back()->with('status', 'Selecciona los permisos');
        }
    }

    public function revokePermission(User $id, Request $request){
        // dd($request->permission);
        $id->revokePermissionTo($request->permission);
        return back()->with('status', 'Permiso eliminado');
    }
}
