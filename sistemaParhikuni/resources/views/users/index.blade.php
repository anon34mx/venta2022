@extends('layouts.parhikuni')

@section('content')
    <div class="col-12">
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Nuevo usuario</a>
        </h3>
        <details>
            <summary>Ayuda</summary>
            <p>En esta página vemos los usuarios que tienen acceso a este sistema</p>
        </details>
        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif
        <form action="{{route('users.store')}}" method="POST" class="needs-validation" novalidate>
            <div class="row form-group">
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="text" name="name" placeholder="Nombre de usuario" class="form-control" value="{{old('name')}}" required>
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="email" name="email" placeholder="Email" class="form-control" value="{{old('email')}}" required>
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="password" name="password" placeholder="password" class="form-control" value="{{old('password')}}" required>
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <select name="role" id="role" class="form-control" required>
                        <option value="" selected disabled >Rol de usuario</option>
                        @foreach($roles as $rol)
                            <option value="{{$rol->id}}">{{$rol->name}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 form-check">
                <input checked
                    id="incPersEditUsr"
                    type="checkbox"
                    class="form-check-input toggler"
                    target="#datosPersona"
                    name="incPers" targetRequired>
                <label for="incPersEditUsr" class="form-check-label">Incluir datos de persona</label>
            </div>
            <div class="row form-group" id="datosPersona">
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input id="aNombres" name="aNombres" class="form-control" type="text" placeholder="Nombre(s)">
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input id="aApellidos" name="aApellidos" class="form-control" type="text" placeholder="Apellidos">
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    
                    <select name="nOficina" id="nClaveOficina" class="form-control">
                        <option value="" disabled selected>Oficina</option>
                        <option value="null">Ninguna</option>
                        @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}">{{ $oficina->aNombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <select name="aTipo" id="aTipo" class="form-control">
                        <option value="">Tipo</option>
                        @foreach($tipospersonas as $tipopersona)
                        <option value="{{$tipopersona->aTipo}}">{{$tipopersona->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <!-- PERSONA -->
            <!-- <div class="row form-group">
                <h3>Datos de persona</h3>
                <div class="col-12 row">
                    <div class="col-12 row">
                        
                    </div>
                </div>
            </div> -->

            <!-- SUBMIT -->
            <div class="row form-group mt-3">
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
    </div>
    <div id="personas" class="mt-4"></div>
    <h3 class="titleWithAnchor">
        <a href="#personas">Usuarios</a>
    </h3>
    <div>
        <form method="get" action="/usuarios">
            @csrf
            <div class="col-12 row">
                <div class="col-9">
                    <input type="search" placeholder="Buscar" name="search"
                    class="form-control" id="search"
                    value="{{$search}}" style="padding-right: 30px;"/>
                    <div onclick="event.preventDefault();$('#search').val('')"
                        class="btn btn-link"
                        style="
                        color: black;
                        position: absolute;
                        right: 12px;
                        top: 0px;
                    ">
                    <i class="fa-solid fa-delete-left"></i>
                </div>
                </div>
                <span class="btn-collap col-auto" title="Buscar">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="del-">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Buscar</span>
                    </label>
                    <input id="del-" type="submit"
                    class="btn">
                </span>
            </div>
        </form>
    </div>
    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="mt-2 table table-striped table-parhi">
            <thead>
                <tr class="table-parhi">
                    <th class="col-1">ID</th>
                    <th class="col-1">Rol(es)</th>
                    <th class="col-3">Nombre</th>
                    <th class="col-3">Email</th>
                    <th class="col-1" colspan="2"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($users as $user)
                    <tr>
                        <td>{{$user->id}}</td>
                        <td>
                            @if(sizeof($user->roles) > 0)
                                <ul class="px-0">
                                    @foreach($user->roles as $rol)
                                        <li>{{$rol->name}}</li>
                                    @endforeach
                                </ul>
                            @else
                                <ul class="px-0">
                                    <li>El usuario no tiene permisos.</li>
                                </ul>
                            @endif
                        </td>
                        <td>{{$user->name}}</td>
                        <td>{{$user->email}}</td>
                        <td>
                            <!-- <button class="btn btn-sm btn-primary">editar</button> -->
                            <a href="{{route('users.edit', $user->id)}}">
                                <span class="btn-collap" title="Editar">
                                    <label class="btn btn-sm btn-primary"
                                        for="edit-{{$user->id}}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                        <span>Editar</span>
                                    </label>
                                    <input id="edit-{{$user->id}}" type="submit"
                                    class="btn" onclick="">
                                </span>
                            </a>
                        </td>
                        <td>
                            <form action="{{route('users.destroy',$user)}}" method="POST">
                                @csrf
                                @method('DELETE')
                                <span class="btn-collap" title="Eliminar">
                                    <label class="btn btn-sm btn-danger"
                                        for="del-{{$user->id}}">
                                        <i class="fa-solid fa-circle-minus"></i>
                                        <span>Eliminar</span>
                                    </label>
                                    <input id="del-{{$user->id}}" type="submit"
                                    class="btn"
                                    onclick="return confirm('¿Eliminar usuario?')">
                                </span>
                            </form>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
    <div class="mt-3 d-flex justify-content-center">
        {!! $users->appends(Request::all())->links("pagination::bootstrap-5") !!}
    </div>
@endsection
