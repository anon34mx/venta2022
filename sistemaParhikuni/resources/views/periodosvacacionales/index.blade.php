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
    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-3 pt-2">
    <h4>Periodos vacacionales</h4>
    <form action="{{route('corridas.vacaciones.store')}}" class="col-12 col-sm-10 col-lg-6 row mx-auto needs-validation" novalidate>
        <div class="col-12 col-md-5 row px-2">
            <div class="col-12">
                <input class="form-control" type="date" name="fechaInicio" min="{{date('Y-m-d')}}" required>
            </div>
        </div>
        <div class="col-12 col-md-5 row px-2">
            <div class="col-12">
                <input class="form-control" type="date" name="fechaFin" min="{{date('Y-m-d')}}" required>
            </div>
        </div>
        <div class="col-12 col-md-2 row px-2">
            <input class="hidden"  id="guardar" type="submit">
            <span class="btn-collap" title="Guardar">
                <label class="btn btn-sm btn-parhi-primary" for="guardar">
                    <i class="fa-solid fa-floppy-disk"></i>
                    <span>Guardar</span>
                </label>
                <input id="guardar" type="submit" class="btn">
            </span>
        </div>
    </form>
    <table class="table table-parhi">
        <thead>
            <tr>
                <th>Inicio</th>
                <th>Fin</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            @foreach($periodos as $periodo)
            <tr id="{{$periodo->id}}">
                <td>{{$periodo->inicio}}</td>
                <td>{{$periodo->fin}}</td>
                <td>
                    <form action="{{route('corridas.vacaciones.destroy', $periodo)}}" method="post">
                        @csrf
                        <span class="btn-collap" title="Eliminar">
                            <label class="btn btn-sm btn-danger" for="borrar-{{$periodo}}">
                                <i class="fa-solid fa-circle-minus"></i>
                                <span>Eliminar</span>
                            </label>
                            <input id="borrar-{{$periodo}}" type="submit" value="borrar" onclick="confirm('¿Eliminar este registro?')">
                            <!-- <input id="del" type="submit" class="btn" onclick="return confirm('¿Eliminar usuario?')"> -->
                        </span>
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
