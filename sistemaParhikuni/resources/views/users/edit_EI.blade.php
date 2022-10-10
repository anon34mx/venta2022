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
                    <label for="nombreDeUsuario" class="float-md-right text-md-right">Nombre de usuario</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="nombreDeUsuario" class="form-control" type="text" name="nombreDeUsuario" placeholder="Nombre de usuario"
                        value="{!! $user->name !!}" pattern="(^([a-zA-Z0-9\.-_]+)(\d+)?$)" readonly>
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                <div class="col-12 col-md-4">
                    <label for="correoElectronico" class="float-md-right text-md-right">Correo</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="correoElectronico" type="email" name="correoElectronico" placeholder="Email" class="form-control"
                    value="{!! $user->email !!}" readonly>
                </div>
            </div>
            <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                <div class="col-12 col-md-4">
                    <label for="contraseña" class="float-md-right text-md-right">Contraseña</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="contraseña" type="password" name="contraseña" placeholder="contraseña" class="form-control" value="">
                    <div class="col-12 text-muted"><small>Llenar sólo cuando se desee cambiar</small></div>
                </div>
            </div>

            <div class="row mx-0 px-0" id="datosPersona" style="">
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="nombre" class="float-md-right text-md-right">Nombre(s)</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <input id="nombre" type="text" name="nombre" placeholder="Nombre" class="form-control"
                            value="{!! @$user->personas->aNombres !!}" readonly
                            pattern="([a-zA-ZÀ-ÖØ-öø-ÿ]{3,})+([ a-zA-ZÀ-ÖØ-öø-ÿ]{3,})?">
                            <!-- pattern="^([a-zA-ZÀ-ÖØ-öø-ÿ]){3,}(\x20)+(([a-zA-ZÀ-ÖØ-öø-ÿ']){3,}|([a-zA-ZÀ-ÖØ-öø-ÿ']{1,2}) [a-zA-ZÀ-ÖØ-öø-ÿ']{2,})" -->
                            <div class="invalid-feedback">
                                Esciba un nombre
                            </div>
                    </div>
                </div>
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="apellidos" class="float-md-right text-md-right">Apellidos</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <input id="apellidos" type="text" name="apellidos" placeholder="Apellidos" class="form-control" value="{!! @$user->personas->aApellidos !!}" readonly>
                    </div>
                </div>
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="nClaveOficina" class="float-md-right text-md-right">Oficina*</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <!-- poner oficina -->
                        {{$user->personas->nOficina}}
                    </div>
                </div>
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="tipoPersona" class="float-md-right text-md-right">Tipo de persona*</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <!-- poner tipo persona -->
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
    </div>
    
@endsection
