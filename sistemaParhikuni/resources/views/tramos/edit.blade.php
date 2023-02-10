@extends('layouts.parhikuni')
@section('content')
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
        <div class="alert alert-success alert-float-br">
            {{ session('status') }}
        </div>
    @endif

<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0 row">
    <h4>Editar tramo</h4>
    <form action="{{route('tramos.update', $tramo)}}">
        <div class="col-10 mx-auto row">
            <h5>{{$tramo->origen->aNombre." a ".$tramo->destino->aNombre}}</h5>
            <div class="col-4 my-2 row">
                <label for="" class="col-7 text-right">Distancia (km)</label>
                <div class="col-5">
                    <input id="kilometros" name="kilometros" type="number" class="nospinner col-12 form-control" value="{{$tramo->nKilometros}}" min="0">
                </div>
            </div>
            <div class="col-4 my-2 row">
                <label for="" class="col-7 text-right">Tiempo (minutos)</label>
                <div class="col-5">
                    <input id="tiempo" name="tiempo" type="number" class="nospinner col-12 form-control" value="{{$tramo->nTiempo}}" min="0">
                </div>
            </div>
            <div class="col-4 my-2 row">
                <label for="" class="col-7 text-right">Estancia (minutos)</label>
                <div class="col-5">
                    <input id="estancia" name="estancia" type="number" class="nospinner col-12 form-control" value="{{$tramo->nEstancia}}" min="0">
                </div>
            </div>
            <div class="col-12 my-2">
                <span class="btn-collap float-right mx-4" title="Guardar">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="guardar">
                        <i class="fa-solid fa-floppy-disk"></i>
                        <span>Guardar</span>
                    </label>
                    <input id="guardar" type="submit"
                    class="btn">
                </span>
                <a href="{{route('tramos.index')}}" class=" mx-4">
                    <span class="btn-collap float-right" title="volver">
                        <label class="btn btn-sm btn-parhi-primary"
                            >
                            <i class="fa-solid fa-arrow-left"></i>
                            <span>Volver</span>
                        </label>
                        <input id="volver"
                        class="btn">
                    </span>
                </a>
            </div>
        </div>
    </form>

</div>
@endsection