@extends('layouts.parhikuni')

@section('content')
    <div class="col-12 col-sm-10 col-md-8 mx-auto">
        <div>
            @if(session()->has('status'))
                <p class="alert alert-success">{{session('status')}}</p>
            @endif
        </div>


        <h3>Editar usuario</h3>
        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif

        <form action="{{route('users.update', $user)}}" method="POST">
            <div class="row">
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="text" name="name" placeholder="Nombre" class="form-control" value="{!! $user->name !!}" @if(!Auth::user()->hasRole('Admin')) {{"readonly"}} @endif>
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="email" name="email" placeholder="Email" class="form-control" value="{!! $user->email !!}" @if(!Auth::user()->hasRole('Admin')) {{"readonly"}} @endif>
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="password" name="password" placeholder="password" class="form-control" value="" required>
                </div>
                @csrf
                <div class="col-auto justify-content-center">
                    <!-- <input type="submit" name="submit" placeholder="" class="btn btn-small btn-parhi-primary mx-auto" value="Guardar"> -->
                    <span class="btn-collap" title="Guardar">
                        <label class="btn btn-sm btn-parhi-primary"
                            for="guardar">
                            <i class="fa-solid fa-floppy-disk"></i>
                            <span>Guardar</span>
                        </label>
                        <input id="guardar" type="submit"
                        class="btn">
                    </span>
                </div>
            </div>
        </form>

        @if(Auth::user()->hasRole('Admin'))
        <h3 class="mt-4">Roles</h3>
        <p>Los roles definen qué tipo función tiene el usuario dentro de la plataforma y los permisos dentro de la misma</p>
        <table class="table table-striped table-parhi">
            @foreach($user->roles as $rol)
                <tr>
                    <td>{{$rol->name}}</td>
                    <td>
                        <form action="{{route('users.removerol', [$user->id, $rol->id])}}" method="post">
                            <span class="btn-collap" title="Eliminar">
                                <label class="btn btn-sm btn-danger float-right"
                                    for="del-{{$user->id}}">
                                    <i class="fa-solid fa-circle-minus"></i>
                                    <span>Eliminar</span>
                                </label>
                                @csrf
                                <input id="del-{{$user->id}}" type="submit"
                                class="btn" onclick="confirm('¿Eliminar rol?')"
                                >
                            </span>
                        </form>
                    </td>
                </tr>
            @endforeach
        </table>
        <h3 class="mt-4">Añadir rol</h3>
        <form action="{{route('users.addrol', $user->id)}}" class="" method="post">
            @csrf
            <div class="row">
                <div class="col-12 col-md-10">
                    <select class="form-control col-12" name="newRole" id="newRole">
                        @foreach($roles as $rol)
                            @php
                                $found=false;
                            @endphp
                            @foreach($user->roles as $userRol)
                                @php
                                    if($userRol->id == $rol->id){
                                        $found=true;
                                    }
                                @endphp
                            @endforeach
                            @php
                                if(!$found){
                                    @endphp
                                    <option value="{{$rol->id}}">{{$rol->name}}</option>
                                    @php
                                }
                            @endphp
                        @endforeach
                    </select>
                </div>
                <div class="col-12 col-md-2">
                    <span class="btn-collap" title="Eliminar">
                        <label class="btn btn-sm btn-primary float-right"
                            for="addRole-{{$user->id}}">
                            <i class="fa-solid fa-circle-plus"></i>
                            <span>Añadir</span>
                        </label>
                        <input id="addRole-{{$user->id}}" type="submit"
                        class="btn" >
                    </span>
                </div>
            </div>
        </form>

        <h3 class="mt-4">Permisos directos</h3>
        <p>Son permisos adicionales asignados directamente al usuario.</p>
        <table class="table table-parhi">
            @foreach ($user_permissions as $up)
            <tr>
                <td>{{ $up->name }}</td>
                <td>
                    <form action="{{route('users.revokePermission', $user->id)}}" method="post">
                        <span class="btn-collap" title="Eliminar">
                            <label class="btn btn-sm btn-danger float-right"
                                for="delPerm-{{$up->id}}">
                                <i class="fa-solid fa-circle-minus"></i>
                                <span>Eliminar</span>
                            </label>
                            @csrf
                            <input id="delPerm-{{$up->id}}" type="submit" name="permission"
                            class="btn" onclick="confirm('¿Eliminar permiso?')" value="{{$up->id}}">
                        </span>
                    </form>
                </td>
            </tr>
            @endforeach
        </table>

        <h3 class="mt-4">Agregar permisos directos</h3>
        <form action="{{ route('users.addPermission', $user->id) }}" method="post">
            <div class="flow-content">
            @csrf
                @foreach($permissions as $permission)
                    @php
                        $found=false;
                        foreach($user_permissions as $up){
                            if($up->id == $permission->id){
                                $found=true;
                                break;
                            }
                        }
                    @endphp

                    @if(!$found)
                    <span class="" style="">
                        <input id="addPerm-{{$permission->id}}" type="checkbox" name="permissions[{{$permission->id}}]">  
                        <label for="addPerm-{{$permission->id}}">{{$permission->name}}</label>
                    </span>
                    @endif
                @endforeach
            </div>
            <span class="btn-collap" title="Eliminar">
                <label class="btn btn-sm btn-primary float-right"
                    for="addRole-{{$user->id}}">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>Añadir</span>
                </label>
                <input id="addRole-{{$user->id}}" type="submit"
                class="btn" >
            </span>
            </form>
        @endif
    </div>
    
@endsection
