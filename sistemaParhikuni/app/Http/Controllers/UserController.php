<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Auth;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->has('search') && $request->search!="") {
            $users = User::where('name', 'like', '%'.$request->input('search').'%')
                ->orWhere('email', 'like', '%'.$request->input('search').'%')
                ->orWhere('id', 'like', '%'.$request->input('search').'%')
                ->cursorPaginate(5);
        } else {
            $users=User::orderBy('id')->paginate(5);
        }
        return view('users.index', [
            "users" => $users,
            "search" => $request->search
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
        $request->validate([
            'name' => 'required',
            'email' => ['required', 'email', 'unique:users'],
            'password' => ['required', 'min:8'],
        ]);
        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password)
        ]);
        return back();
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
            return view('users.edit',[
                "user" => $user,
                'roles' => Role::all(),
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
            if(Auth::user()->hasRole('Admin') && Auth::user()->id!=$id->id){
                $id->roles()->detach($rol->id);
                return back()->with('status', 'Actualizado con éxito');
            }else{
                abort(403);
            }
        }catch(Exception $e){
            return back()->with('status', 'Error<br>'.$e);
        }
    }
}
