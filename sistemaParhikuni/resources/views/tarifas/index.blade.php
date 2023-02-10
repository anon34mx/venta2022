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

<div class="col-12 col-sm-11 col-md-11 col-lg-11 mx-auto px-0 row">
    <h4>Tarifas</h4>
    <a href="{{route('tarifas.create')}}">
        <button>Nuevo</button>
    </a>
    <table class="table table-parhi">
        <thead>
            <tr>
                <th>Servicio</th>
                <th>Origen</th>
                <th>Destino</th>
                <th>Tarifa base ruta</th>
                <th>Tarifa base paqueteria</th>
                <th>Fecha aplicación</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
        @foreach($tarifas as $tarifa)
            <tr>
                <td>
                    {{$tarifa->servicio->aDescripcion}}
                </td>
                <td>
                    {{$tarifa->origen->aNombre}}
                </td>
                <td>
                    {{$tarifa->destino->aNombre}}
                </td>
                <td>
                    ${{$tarifa->nMontoBaseRuta}}
                </td>
                <td>
                    ${{$tarifa->nMontoBasePaqueteria}}
                </td>
                <td>
                    {{$tarifa->fAplicacion}}
                </td>
                <td>
                    <a href="{{route('tarifas.edit', $tarifa)}}">
                        <button>editar o algo</button>
                    </a>
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
</div>
@endsection