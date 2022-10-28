@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 mx-auto">
    <h3>Conductor {{ @$conductor->nNumeroConductor }}</h3>

    <div>
        @if(session()->has('status'))
            <p class="alert alert-success">{{session('status')}}</p>
        @endif
    </div>
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    <form action="{{route('personal.conductores.update', $conductor)}}" class="row needs-validation" method="post" novalidate>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="nombre">Nombre(s)</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <input id="nombre" class="form-control" type="text" name="nombre" placeholder="Nombre"
                    value="{{$conductor->persona->aNombres}}" pattern="([a-zA-ZÀ-ÖØ-öø-ÿ]{3,})+([ a-zA-ZÀ-ÖØ-öø-ÿ]{3,})?"
                    required>
            </div>
        </div>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="apellidos">Apellidos</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <input id="apellidos" class="form-control" type="text" name="apellidos" placeholder="Apellidos"
                    value="{{$conductor->persona->aApellidos}}" pattern="([a-zA-ZÀ-ÖØ-öø-ÿ]{3,})+([ a-zA-ZÀ-ÖØ-öø-ÿ]{3,})?"
                    required>
            </div>
        </div>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="oficina">Oficina</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <select class="form-control" id="oficina" name="oficina">
                    <option value="" disabled>Selecciona una oficina</option>
                    @foreach($oficinas as $oficina)
                    @if($oficina->nNumero==$conductor->persona->nOficina)
                        <option value="{{$oficina->nNumero}}" selected>{{$oficina->aNombre}}</option>
                    @else
                        <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                    @endif
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="numeroDeLicencia">Licencia</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <input id="numeroDeLicencia" class="form-control" type="text" name="numeroDeLicencia"
                    placeholder="Num. de licencia"
                    value="{{$conductor->aLicencia}}" pattern="(^([a-zA-Z0-9\.-_]+)(\d+)?$)">
            </div>
        </div>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="fechaVigenciaLicencia">Fecha vigencia licencia</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <input id="fechaVigenciaLicencia" class="form-control" type="date" name="fechaVigenciaLicencia"
                    value="{{$conductor->fVigenciaLicencia}}" min="{{ date('Y-m-d') }}">
            </div>
        </div>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="estado">Estado</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <select class="form-control" name="estado" required>
                    <option value="" disabled>Selecciona un estado</option>
                    @foreach($personasEstado as $estado)
                        <option value="{{$estado->aClave}}">{{$estado->descripcion}}</option>
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-md-6 row mb-2">
            <div class="col-12 col-md-4 col-lg-4 text-md-right">
                <label for="autobus">Autobus</label>
            </div>
            <div class="col-12 col-md-8 col-lg-8">
                <select class="form-control" name="autobus" required>
                    <option value="" disabled>Selecciona un autobus</option>
                    <option value="NA">No asignado</option>
                    @foreach($autobuses as $autobus)
                        @if($autobus->nNumeroAutobus==$conductor->nNumeroAutobus)
                        <option value="{{$autobus->nNumeroAutobus}}" selected>{{$autobus->nNumeroEconomico}}</option>
                        @else
                        <option value="{{$autobus->nNumeroAutobus}}">{{$autobus->nNumeroEconomico}}</option>
                        @endif
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 row">
                @csrf
                <div class="col-12 justify-content-center">
                    <span class="btn-collap float-right" title="Guardar text-md-right">
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