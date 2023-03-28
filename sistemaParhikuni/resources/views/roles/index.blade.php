@extends('layouts.parhikuni')

@section('content')
    <div class="col-12">
        <details>
            <summary class="text-right">
                <div class="btn btn-sm btn-info">Ayuda</div>
                <!-- <i class="fa-solid fa-question"></i> -->
            </summary>
            <div class="pl-5">
                <p>
                    El rol es el papel que puede cumplir un usuario dentro del sistema.
                    <br>
                    Cada rol se asocia con permisos, para realizar acciones dentro del sistema.
                </p>
            </div>
        </details>
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Roles</a>
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

        <form action="{{route('roles.store')}}" class="needs-validation" novalidate method="post">
            @csrf
            <div class="col-12 row">
                <div class="col-12 col-sm-4">
                    <label for="">Nuevo rol</label>
                </div>
                <div class="col-12 col-sm-6">
                    <input type="text" name="newRole" class="form-control col-12" required>
                </div>
                <div class="col-auto">
                    <span class="btn-collap" title="Eliminar">
                        <label class="btn btn-sm btn-parhi-primary float-right"
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
        
        <table class="table table-stripped table-parhi mt-3">
            <thead>
                <tr>
                    <th>Rol</th>
                    <th>Permisos</th>
                    <th colspan="2"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($roles as $role)
                <tr>
                    <td>
                        {{$role->name}}
                        <br>
                        &nbsp;{{sizeof($role->users)}} - usuarios
                    </td>
                    <td>
                        <ul>
                            @foreach($role->permissions as $permission)
                            <li>{{$permission->name}}</li>
                            @endforeach
                        </ul>
                    </td>
                    <td>
                        <a href="{{route('roles.edit',$role->id)}}">
                            <span class="btn-collap" title="Editar">
                                <label class="btn btn-sm btn-primary"
                                    for="editRole-{{$role->id}}">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                    <span>Editar permisos</span>
                                </label>
                                <input id="editRole-{{$role->id}}" type="submit"
                                class="btn" onclick="">
                            </span>
                        </a>
                    </td>
                    <td>
                        <form action="{{route('roles.destroy', $role->id)}}" method="post">
                            @method('DELETE')
                            @csrf
                            <span class="btn-collap" title="Eliminar">
                                    <label class="btn btn-sm btn-danger"
                                        for="delPerm-{{$role->id}}">
                                        <i class="fa-solid fa-circle-minus"></i>
                                        <span>Eliminar</span>
                                    </label>
                                    <input id="delPerm-{{$role->id}}" type="submit"
                                    class="btn"
                                    onclick="return confirm('¿Eliminar rol?')">
                                </span>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
    </div>
@endsection