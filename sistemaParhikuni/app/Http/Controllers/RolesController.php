<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RolesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('roles.index', [
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
        // vista para crear permiso
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        // dd($request->newRole);
        $role = Role::create(['name' => $request->newRole]);
        return redirect()->route('roles.edit', [
            "idRole" => $role
        ])->with('status', 'Rol guardado');

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
    public function edit($idRole)
    {
        return view('roles.edit', [
            'role' => Role::find($idRole),
            'permissions' => Permission::all()
        ]);
    }

    public function addPermissions(Role $role, Request $request){
        // dd($role);
        if($request->permissions){
            foreach($request->permissions as $permission=>$value){
                $role->givePermissionTo($permission);
            }
            return back()->with('status', 'Actualizado con éxito');
        }else{
            return back()->with('status', 'Selecciona los permisos');
        }
    }

    public function revokePermission(Role $role, Permission $permission){
        $role->revokePermissionTo($permission);
        return back()->with('status', 'Permiso eliminado');
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(Role $role)
    {
        if($role->name === "Admin"){
            return back()->withErrors([
                'No se puede borrar el permiso de administrador.'
            ]);
        }

        if(sizeof($role->users) > 0){
            return back()->withErrors([
                'No se puede borrar el permiso, está asignado a usuarios.'
            ]);
        }
        else{
            $role->delete();
            return back()->with('status', 'Rol eliminado');
        }
    }
}
