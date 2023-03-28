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
        <form action="" class="">
            <div class="col-12 col-md-10 col-lg-6 row mx-auto">
                <div class="col-12 col-sm-9">
                    <select name="busqueda" id="busqueda" class="form-control">
                        <option value="">Todos</option>
                        @foreach($oficinas as $oficina)
                            <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-12 col-sm-3 my-2 my-sm-0">
                    <span class="btn-collap col-auto" title="Buscar">
                        <label class="btn btn-sm btn-parhi-primary" for="buscar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Buscar</span>
                        </label>
                        <input id="buscar" type="submit" class="btn">
                    </span>
                </div>
            </div>
        </form>
    </div>

    <div class="col-12">
        <a href="{{route('tramos.create')}}">
            <span class="btn-collap" title="Añadir">
                <label class="btn btn-sm btn-primary float-right" for="addpermission">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>Añadir</span>
                </label>
                <input id="addpermission" type="submit" class="btn">
            </span>
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
                            <span class="btn-collap" title="Editar">
                                <label class="btn btn-sm btn-primary" for="edit-">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                    <span>Editar</span>
                                </label>
                                <input id="edit-" type="submit" class="btn" onclick="">
                            </span>
                        </a>
                    </td>
                </tr>
                @endforeach
            @endif
        </tbody>
    </table>
</div>
@endsection