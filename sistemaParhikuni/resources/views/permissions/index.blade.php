@extends('layouts.parhikuni')

@section('content')
    <div class="col-12">
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Permisos</a>
        </h3>

        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif
        @if (session('status'))
            <div class="alert alert-success">
                {{ session('status') }}
            </div>
        @endif

        <form action="{{route('permission.store')}}" method="post" class="mt-4">
            @csrf
            <div class="col-11 row">
                <div class="col-12 col-md-6">
                    <label class="" for="">Nuevo permiso</label>
                </div>
                <div class="col-12 col-md-3">
                    <input class="form-control" type="text" name="newPermission">
                </div>
                <div class="col-12 col-md-auto">
                    <span class="btn-collap" title="Eliminar">
                        <label class="btn btn-sm btn-parhi-primary"
                            for="newPermissionBtn">
                            <i class="fa-solid fa-floppy-disk"></i>
                            <span>Guardar</span>
                        </label>
                        <input id="newPermissionBtn" type="submit"
                        class="btn">
                    </span>
                </div>
            </div>
        </form>
        
        <table class="table table-stripped table-parhi mt-4">
            <thead>
                <tr>
                    <th>Permisos</th>
                    <th>Roles</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                @foreach($permissions as $permission)
                <tr>
                    <td>{{$permission->name}}</td>
                    <td>
                        <ul class="unstyled-list">
                            @foreach($permission->roles as $role)
                                <li>
                                    <a href="{{route('roles.edit', $role->id)}}" class="btn btn-link">
                                        <label class="btn btn-sm btn-primary col-12">
                                            <i class="fa-regular fa-eye"></i>
                                            <span>{{$role->name}}</span>
                                        </label>
                                    </a>
                                </li>
                            @endforeach
                        </ul>
                    </td>
                    <td>
                        <form action="{{route('permission.destroy', $permission->id)}}" method="post">
                            @method('DELETE')
                            @csrf
                            <span class="btn-collap" title="Eliminar">
                                    <label class="btn btn-sm btn-danger"
                                        for="delPerm-{{$permission->id}}">
                                        <i class="fa-solid fa-circle-minus"></i>
                                        <span>Eliminar</span>
                                    </label>
                                    <input id="delPerm-{{$permission->id}}" type="submit"
                                    class="btn"
                                    onclick="return confirm('¿Eliminar permiso?')">
                                </span>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
@endsection