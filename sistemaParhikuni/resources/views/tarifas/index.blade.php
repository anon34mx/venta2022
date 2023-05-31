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
    
    <span class="btn-collap" title="Añadir">
        <label class="btn btn-sm btn-primary float-right" for="añadir">
            <i class="fa-solid fa-circle-plus"></i>
            <span>Añadir</span>
        </label>
        <a href="{{route('tarifas.create')}}" >
            <input id="añadir" type="submit" class="btn">
        </a>
    </span>
    
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
                        <span class="btn-collap" title="Editar">
                            <label class="btn btn-sm btn-primary" for="edit-{{$tarifa}}">
                                <i class="fa-solid fa-pen-to-square"></i>
                                <span>Editar</span>
                            </label>
                            <input id="edit-{{$tarifa}}" type="submit" class="btn" onclick="">
                        </span>
                    </a>
                </td>
            </tr>
        @endforeach
        </tbody>
    </table>
</div>
@endsection