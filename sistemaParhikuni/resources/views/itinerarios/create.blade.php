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
    <h3>Nuevo itinerario</h3>
        <form action="{{route('itinerarios.store')}}" method="post">
            @csrf
            <table id="tbl-NvoItinerario" class="table table-parhi">
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
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
            <input id="btn-guardar" type="submit" hidden>
        </form>
    <div class="col-8 row mx-auto">
            <div class="col-8 mx-auto">
                <select name="tramos" id="tramos" class="form-control">
                    <option value="" inicio="" fin="">Todos</option>
                    @foreach($tramos as $tramo)
                        <option value="{{$tramo->nNumero}}" origen="{{$tramo->nOrigen}}" destino="{{$tramo->nDestino}}"
                            data="{{json_encode($tramo)}}">
                            {{$tramo->origen}} -> {{$tramo->destino}}
                        </option>
                    @endforeach
                </select>
            </div>
            <div class="col-auto mx-auto">
                <button id="btn-añadir" class="btn btn-success" onclick="agregarTramoNevoItinerario()">
                    <i class="fa-solid fa-plus"></i>
                </button>
            </div>
    </div>

    <div class="col-12 col-md-auto my-4">
        <span class="btn-collap float-right" title="Eliminar">
            <label class="btn btn-sm btn-parhi-primary"
                for="btn-guardar">
                <i class="fa-solid fa-floppy-disk"></i>
                <span>Guardar</span>
            </label>¿
        </span>
    </div>
</div>
@endsection