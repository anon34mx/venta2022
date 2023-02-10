@vite([
    'resources/js/controlador_admin.js'
    ])
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

<div class="col-12 col-sm-11 col-md-11 col-lg-11 px-0 mx-auto">
    <h3>Nuevo tramo</h3>
    <div class="col-12">
        <form action="{{route('tramos.store')}}" method="post">
            @csrf
            <table id="tbl-NvoItinerario" class="table table-parhi col-12">
                <thead>
                    <tr>
                        <th>Origen</th>
                        <th>Destino</th>
                        <th>Distancia (kilometros)</th>
                        <th>Tiempo (minutos)</th>
                        <th>Estancia (minutos)</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>
            <input type="submit" id="guardar" hidden>
        </form>
    </div>
    <div class="col-11 row mx-auto">
        <div id="opcionesNvoTramo" class="col-8">
            <select name="tramos" id="tramos" class="form-control">
                <option id="" value="" inicio="" fin="">Todos</option>
                @foreach($origenesDestinos as $opc)
                    <option value="{{$opc->nOrigen}}_{{$opc->nDestino}}"
                        nOrigen="{{$opc->nOrigen}}" nDestino="{{$opc->nDestino}}"
                        origen="{{$opc->origen}}" destino="{{$opc->destino}}"   
                        id="opt-{{$opc->nOrigen}}_{{$opc->nDestino}}">
                        {{$opc->origen}} -> {{$opc->destino}}
                    </option>
                @endforeach
            </select>
        </div>
        <div class="col-4 my-2">
            <span class="btn-collap col-12" title="Añadir">
                <button id="añadir" onclick="agregarTramoNevo()" hidden>añadir</button>
                <label class="btn btn-sm btn-primary "
                    for="añadir">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>Añadir</span>
                </label>
            </span>
        </div>
    </div>

    <div class="col-12">
        <span class="mx-3 btn-collap hidden float-right" title="Guardar" id="btnGuardar">
            <label class="btn btn-sm btn-parhi-primary"
                for="guardar">
                <i class="fa-solid fa-floppy-disk"></i>
                <span>Guardar</span>
            </label>
            <input id="guardar" type="submit"
            class="btn">
        </span>

        <a href="{{route('tramos.index')}}">
            <span class="mx-3 btn-collap float-left" title="Volver" id="btnVolver">
                <label class="btn btn-sm btn-danger"
                    for="volver">
                    <i class="fa-solid fa-arrow-left"></i>
                    <span>volver</span>
                </label>
                <input id="volver" type="submit"
                class="btn">
            </span>
        </a>
    </div>
</div>
@endsection