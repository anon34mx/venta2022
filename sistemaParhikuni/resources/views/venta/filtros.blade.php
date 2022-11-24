@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-10 col-lg-10 mx-auto">
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    <h3 class="titleWithAnchor" id="nuevoUsuario">
        <a href="#nuevoUsuario">Filtros</a>
    </h3>


    <form action="{{route('corridas.disponibles.corridasFiltradas')}}" method="get" class="row needs-validation" novalidate>
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-4 col-md-4">
                <label for="tipoDeViaje" class="float-md-right text-md-right">Tipo de viaje*</label>
            </div>
            <div class="col-4 col-md-4">
                <label for="viajeSencillo">Sencillo</label>
                <input id="viajeSencillo" type="radio" name="tipoViaje" value="sencillo">
            </div>
            <div class="col-4 col-md-4">
                <label for="viajeRedondo">Redondo</label>
                <input id="viajeRedondo" type="radio" name="tipoViaje" value="redondo" checked>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-6 col-md-6">
                Origen
            </div>
            <div class="col-6 col-md-6">
                <select name="origen" id="origen" onChange="cargarDestinos(this.value,false)">
                    <option value="" >Seleccione Origen</option>
                    @foreach($oficinas as $key)
                        <option value="{{@$key["nNumero"]}}">{{@$key["origen"]}}</option>
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-6 col-md-6">
                Destino
            </div>
            <div class="col-6 col-md-6">
                <select name="destino" id="destino">
                    <option value="">Seleccione Destino</option>
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-6 col-md-6">
                Fecha de salida
            </div>
            <div class="col-6 col-md-6">
                <input type="date" min="{{date('Y-m-d')}}" name="fechaDeSalida">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-6 col-md-6">
                Fecha de regreso
            </div>
            <div class="col-6 col-md-6">
                <input type="date" min="{{date('Y-m-d')}}" name="fechaMax">
            </div>
        </div>
        
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-4">
                <div class="col-12">
                    Adultos
                </div>
                <div class="col-12">
                    <input id="adultos" name="adultos" class="col-12" type="number" step="1" value="1">
                </div>
            </div>
            <div class="col-4">
                <div class="col-12">
                    Niños
                </div>
                <div class="col-12">
                    <input id="niños" name="niños" class="col-12" type="number" step="1" value="0">
                </div>
            </div>
            <div class="col-4">
                <div class="col-12">
                    INSEN
                </div>
                <div class="col-12">
                    <input id="insen" name="insen" class="col-12" type="number" step="1" value="0">
                </div>
            </div>
        </div>

        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <input type="submit" value="ver corridas">
        </div>
    </form>
</div>
@endsection
