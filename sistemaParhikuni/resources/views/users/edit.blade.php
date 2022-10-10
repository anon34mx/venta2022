@extends('layouts.parhikuni')

@section('content')
    <div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
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

        <form action="{{route('users.update', $user)}}" method="POST" class="row needs-validation" novalidate>
            <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                <div class="col-12 col-md-4">
                    <label for="nombreDeUsuario" class="float-md-right text-md-right">Nombre de usuario*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="nombreDeUsuario" class="form-control" type="text" name="nombreDeUsuario" placeholder="Nombre de usuario"
                        value="{!! $user->name !!}" pattern="(^([a-zA-Z0-9\.-_]+)(\d+)?$)">
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                <div class="col-12 col-md-4">
                    <label for="correoElectronico" class="float-md-right text-md-right">Correo*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="correoElectronico" type="email" name="correoElectronico" placeholder="Email" class="form-control"
                    value="{!! $user->email !!}" @if(!Auth::user()->hasRole('Admin')) {{"readonly"}} @endif>
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                <div class="col-12 col-md-4">
                    <label for="contraseña" class="float-md-right text-md-right">Contraseña*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="contraseña" type="password" name="contraseña" placeholder="contraseña" class="form-control" value="">
                    <div class="col-12 text-muted"><small>Llenar sólo cuando se desee cambiar</small></div>
                </div>
            </div>
            @if(Auth::user()->hasRole('Admin'))
            <div class="col-12 form-check" {{ ($user->persona_nNumero!= null) ? "hidden" : "";}}>
                <input {{ ($user->persona_nNumero!= null) ? "checked hidden" : "";}}
                    id="incPersEditUsr"
                    type="checkbox"
                    class="form-check-input toggler"
                    target="#datosPersona"
                    name="incPers" targetRequired>
                <label for="incPersEditUsr" class="form-check-label">Incluir datos de persona</label>
            </div>
            @endif
            <div class="row mx-0 px-0" id="datosPersona" style="display:none">
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="nombre" class="float-md-right text-md-right">Nombre(s)*</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <input id="nombre" type="text" name="nombre" placeholder="Nombre" class="form-control"
                            value="{!! @$user->personas->aNombres !!}" @if(!Auth::user()->hasRole('Admin')) {{"readonly"}} @endif
                            pattern="([a-zA-ZÀ-ÖØ-öø-ÿ]{3,})+([ a-zA-ZÀ-ÖØ-öø-ÿ]{3,})?">
                            <!-- pattern="^([a-zA-ZÀ-ÖØ-öø-ÿ]){3,}(\x20)+(([a-zA-ZÀ-ÖØ-öø-ÿ']){3,}|([a-zA-ZÀ-ÖØ-öø-ÿ']{1,2}) [a-zA-ZÀ-ÖØ-öø-ÿ']{2,})" -->
                            <div class="invalid-feedback">
                                Esciba un nombre
                            </div>
                    </div>
                </div>
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="apellidos" class="float-md-right text-md-right">Apellidos*</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <input id="apellidos" type="text" name="apellidos" placeholder="Apellidos" class="form-control" value="{!! @$user->personas->aApellidos !!}" @if(!Auth::user()->hasRole('Admin')) {{"readonly"}} @endif>
                    </div>
                </div>
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="nClaveOficina" class="float-md-right text-md-right">Oficina*</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <select name="nOficina" id="nClaveOficina" class="form-control">
                            <option value="" disabled>Oficina</option>
                            <option value="null" {{ @$user->personas->nOficina==null ? "selected": ""; }}>Ninguna</option>
                            @foreach($oficinas as $oficina)
                            <option value="{{$oficina->nNumero}}" {{ $oficina->nNumero==@$user->personas->nOficina ? "selected" : ""}} >{{ $oficina->aNombre }}</option>
                            @endforeach
                        </select>
                    </div>
                </div>
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="tipoPersona" class="float-md-right text-md-right">Tipo de persona*</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <select name="tipoPersona" id="tipoPersona" class="form-control">
                            <option value="">Seleccione</option>
                            @foreach($tipospersonas as $tipopersona)
                            <option value="{{$tipopersona->aTipo}}"
                                {{$tipopersona->aTipo==@$user->personas->aTipo ? "selected":""}}
                                >
                                {{$tipopersona->aNombre}}
                            </option>
                            @endforeach
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-12 row">
                @csrf
                <div class="col-12 justify-content-center">
                    <span class="btn-collap float-right" title="Guardar">
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
            @if(sizeof($user->roles)>0)
                <table class="table table-striped table-parhi">
                    @foreach($user->roles as $rol)
                        <tr>
                            <td>{{$rol->name}}</td>
                            <td>
                                <form action="{{route('users.removerol', [$user->id, $rol->id])}}" method="post">
                                    <span class="btn-collap" title="Eliminar">
                                        <label class="btn btn-sm btn-danger float-right"
                                            for="del-{{$rol->id}}">
                                            <i class="fa-solid fa-circle-minus"></i>
                                            <span>Eliminar</span>
                                        </label>
                                        @csrf
                                        <input id="del-{{$rol->id}}" type="submit"
                                        class="btn" onclick="return confirm('¿Eliminar rol {{$rol->name}}?')"
                                        >
                                    </span>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </table>
            @else
            <p>El usuario no tiene un rol asignado. <b>Necesita un rol</b> para tener acceso a las funciones del sistema.</p>
            @endif
            <h3 class="mt-4">Añadir rol</h3>
            <form action="{{route('users.addrol', $user->id)}}" class="" method="post">
                @csrf
                <div class="row">
                    <div class="col-12 col-md-10">
                        <select class="form-control col-12" name="newRole" id="newRole" required>
                            <option value="" selected disabled>Seleccione un rol</option>
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
                <div class=" col-12 row">
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
                        <span class="col-12 col-md-6 col-lg-4" style="">
                            <input id="addPerm-{{$permission->id}}" type="checkbox" name="permissions[{{$permission->id}}]">  
                            <label for="addPerm-{{$permission->id}}">{{$permission->name}}</label>
                        </span>
                        @endif
                    @endforeach
                </div>
                <span class="btn-collap" title="Añadir">
                    <label class="btn btn-sm btn-primary float-right"
                        for="addpermission-{{$user->id}}">
                        <i class="fa-solid fa-circle-plus"></i>
                        <span>Añadir</span>
                    </label>
                    <input id="addpermission-{{$user->id}}" type="submit"
                    class="btn" >
                </span>
            </form>
        @endif
    </div>
    
@endsection
