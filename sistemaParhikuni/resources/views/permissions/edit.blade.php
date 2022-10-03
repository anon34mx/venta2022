@extends('layouts.parhikuni')

@section('content')
    <div class="col-12">
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Roles</a>
        </h3>

        <label for=""></label>
        <input type="text" value="{{$role->name}}" class="form-control">


        
        <table class="table table-stripped table-parhi mt-4">
            <thead>
                <tr>
                    <th>Permisos</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                @foreach($role->permissions as $permission)
                <tr>
                    <td>{{$permission->name}}</td>
                    <td>
                        <form action="{{route('roles.revokePermission', [$role->id, $permission->id])}}" method="POST">
                            @csrf
                            <span class="btn-collap" title="Eliminar">
                                <label class="btn btn-sm btn-danger"
                                    for="del-Perm{{$permission->name}}">
                                    <i class="fa-solid fa-circle-minus"></i>
                                    <span>Eliminar</span>
                                </label>
                                <input id="del-Perm{{$permission->name}}" type="submit"
                                class="btn"
                                onclick="return confirm('¿Quitar permiso {{$permission->name}}?')">
                            </span>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>

        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Añadir permisos</a>
        </h3>

        <form action="{{route('roles.addPermissions', $role->id)}}" method="post">
            @csrf
            <div class="flow-content col-12">
                @foreach($permissions as $permission)
                    @php
                        $found = false;
                    @endphp
                    @foreach($role->permissions as $up)
                        @if($up->id == $permission->id)
                            @php
                                $found = true;
                                break;
                            @endphp
                            @endif
                    @endforeach
                    @if(!$found)
                        <span class="col-12">
                            <input id="addPerm-{{$permission->id}}" type="checkbox" name="permissions[{{$permission->id}}]">
                            <label for="addPerm-{{$permission->id}}">
                                {{$permission->name}}
                            </label>
                        </span>
                    @endif
                @endforeach
                <span class="btn-collap col-12" title="Añadir">
                    <label class="btn btn-sm btn-primary float-right"
                        for="addpermission-{{$role->id}}">
                        <i class="fa-solid fa-circle-plus"></i>
                        <span>Añadir</span>
                    </label>
                    <input id="addpermission-{{$role->id}}" type="submit"
                    class="btn" >
                </span>
            </div>
        </form>

    </div>
@endsection