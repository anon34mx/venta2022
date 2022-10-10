@extends('layouts.parhikuni')
@section('content')
    <div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
        <h3>Perfil de usuario</h3>
        @if(session()->has('status'))
            <div class="card-body mt-2 mb-2 ">
                <p class="alert alert-success">{{session('status')}}</p>
            </div>
        @endif
        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif
        <p>* Campos obligatorios</p>
        <form action="{{route('users.updateAsUser')}}" method="POST" class="row needs-validation" novalidate>
            <!-- uwu -->
            <div class="col-12 col-lg-6 col-xl-4 row mt-1 mb-1">
                    <div class="col-12 col-md-4">
                        <label for="nombreDeUsuario" class="float-md-right text-md-right">Nombre de usuario*</label>
                    </div>
                    <div class="col-12 col-md-8 pt-md-1 pb-md-1">
                        <input id="nombreDeUsuario" class="form-control" type="text" name="nombreDeUsuario"
                        placeholder="Nombre de usuario" value="{!! filter_var($user->name, FILTER_SANITIZE_STRING) !!}"
                        pattern="(^([a-zA-Z0-9\.-_]+)(\d+)?$)" readonly>
                    </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mt-1 mb-1">
                    <div class="col-12 col-md-4">
                        <label for="correoElectronico" class="float-md-right text-md-right">Correo electrónico*</label>
                    </div>
                    <div class="col-12 col-md-8 pt-md-1 pb-md-1">
                        <input id="correoElectronico" type="email" name="correoElectronico" placeholder="correo electronico"
                            class="form-control" value="{!! filter_var($user->email, FILTER_SANITIZE_STRING) !!}" 
                            readonly>
                    </div>
            </div>
            <div class="col-0 col-lg-12 col-xl-4">
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mt-1 mb-1">
                    <div class="col-12 col-md-4">
                        <label for="nombre" class="float-md-right text-md-right">Nombre(s)*</label>
                    </div>
                    <div class="col-12 col-md-8 pt-md-1 pb-md-1">
                        <input id="nombre" type="text" name="nombre" required
                        placeholder="Nombre" class="form-control"
                        value="{!! @filter_var($user->personas->aNombres, FILTER_SANITIZE_STRING) !!}"
                        pattern="[a-zA-ZÀ-ÖØ-öø-ÿ ]{3,}">
                        <div class="invalid-feedback">
                            Esciba un nombre
                        </div>
                    </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mt-1 mb-1">
                    <div class="col-12 col-md-4">
                        <label for="apellidos" class="float-md-right text-md-right">Apellidos*</label>
                    </div>
                    <div class="col-12 col-md-8 pt-md-1 pb-md-1">
                        <input id="apellidos" type="text" name="apellidos" placeholder="Apellidos" class="form-control" value="{!! filter_var(@$user->personas->aApellidos, FILTER_SANITIZE_STRING) !!}" >
                    </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mt-1 mb-1">
                    <div class="col-12 col-md-4">
                        <label for="contraseña" class="float-md-right text-md-right">Contraseña</label>
                    </div>
                    <div class="col-12 col-md-8 pt-md-1 pb-md-1">
                        <input id="contraseña" type="password" name="contraseña" placeholder="Opcional" class="form-control" value="">
                        <div class="col-12 text-muted"><small>Llenar sólo cuando se desee cambiar</small></div>
                    </div>
            </div>
            
            <div class="col-12">
                @csrf
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
        </form>
    </div>
@endsection
