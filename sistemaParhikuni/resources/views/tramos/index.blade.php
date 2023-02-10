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

<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
    <h3>Tramos</h3>
    <div class="col-12">
        <form action="">
            <div class="col-12">
                <select name="busqueda" id="busqueda" class="">
                    <option value="">Todos</option>
                    @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                    @endforeach
                </select>
                <input type="submit" class="" value="Buscar">
            </div>

        </form>
    </div>

    <div class="col-12">
        <a href="{{route('tramos.create')}}">
            <button>Crear</button>
        </a>
    </div>


    <table class="table table-parhi">
        <thead>
            <tr>
                <th>Inicio</th>
                <th>Fin</th>
                <th>
                    Distancia<sub>(Km)</sub>
                </th>
                <th>
                    Tiempo<sub>(Minutos)</sub>
                </th>
                <th>
                    Estancia<sub>(Minutos)</sub>
                </th>
                <!-- <th>Tarifa</th> -->
                <th>
                    <sub></sub>
                </th>
            </tr>
        </thead>
        <tbody>
            @if(sizeof($tramos)>0)
                @foreach($tramos as $tramo)
                <tr>
                    <td>{{$tramo->origen->aNombre}}</td>
                    <td>{{$tramo->destino->aNombre}}</td>
                    <td>{{$tramo->nKilometros}}</td>
                    <td>{{$tramo->nTiempo}}</td>
                    <td>{{$tramo->nEstancia}}</td>
                    <td>
                        <a href="{{route('tramos.edit', $tramo)}}">
                            <button>editar</button>
                        </a>
                    </td>
                </tr>
                @endforeach
            @endif
        </tbody>
    </table>
</div>
@endsection