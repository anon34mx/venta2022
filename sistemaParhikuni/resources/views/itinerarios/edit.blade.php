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
    <h3>Itinerario</h3>
    <div class="col-10 mx-auto row">
        
        <table class="table table-striped table-parhi">
            <thead>
                <tr>
                    <th>Consecutivo</th>
                    <th>Origen - Destino</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                @php
                    $size=sizeof($tramos);
                    if(sizeof($tramos)>0){
                        for($i=0; $i<$size;$i++){
                            @endphp
                            <tr>
                                <td class="tbl-padding py-1">{{$tramos[$i]->consecutivo}}</td>
                                <td class="tbl-padding py-1">{{$tramos[$i]->origen}} -> {{$tramos[$i]->destino}}</td>
                                <td class="tbl-padding py-1">
                                    @php
                                    if($i+1 == $size){
                                        @endphp
                                        <form action="{{route('itinerarios.update', $tramos[0]->id)}}" method="post">
                                            @csrf
                                            <span class="btn-collap" title="Eliminar">
                                            <label class="btn btn-sm btn-danger"
                                                for="quitar">
                                                <i class="fa-solid fa-circle-minus"></i>
                                                <span>Quitar</span>
                                            </label>
                                            <input type="hidden" name="action" value="quitar">
                                            <input type="hidden" name="consecutivo" value="{{$tramos[$i]->consecutivo}}">
                                            <input id="quitar" type="submit"
                                            class="btn"
                                            onclick="return confirm('Quitar tramo?')">
                                        </span>
                                        </form>
                                        @php
                                    }
                                    @endphp
                                </td>
                            </tr>
                            @php
                        }
                    }
                @endphp
                @if(sizeof($posiblesTramos)>0)
                <tr>
                    <td colspan="2">
                        <form action="{{route('itinerarios.update', $tramos[0]->id)}}" method="post">
                            @csrf
                            <div class="col-8 mx-auto">
                                <select name="tramo" id="tramo" class="form-control col-12" required>
                                    <option value="">Añadir tramo</option>
                                    @foreach($posiblesTramos as $pt)
                                    <option value="{{$pt->nNumero}}">{{$pt->origen->aNombre}} => {{$pt->destino->aNombre}}</option>
                                    @endforeach
                                </select>
                            </div>
                            <input type="hidden" name="action" value="añadir">
                            <input id="btn-add" type="submit" value="añadir" hidden>
                        </form>
                    </td>
                    <td>
                        <span class="btn-collap" title="Añadir">
                            <label class="btn btn-sm btn-primary"
                            for="btn-add">
                            <i class="fa-solid fa-circle-plus"></i>
                            <span>Añadir</span>
                        </label>
                    </span>
                </td>
            </tr>
            @else
            <tr>
                <td colspan="3">
                    <div for="" class="p-3 mb-2 bg-info text-white rounded">No hay más tramos disponibles. Revisa desde la sección de tramos.</div>
                </td>
            </tr>
            @endif
            </tbody>
        </table>
        <div class="col-12">
            <a href="{{route('itinerarios.index')}}">
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
</div>
@endsection