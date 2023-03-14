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
    <form action="{{route('corridas.vacaciones.store')}}" class="col-12 col-sm-10 col-md-8 col-lg-6 row mx-auto">
        <div class="col-12 col-md-4 row">
            <input class="form-control" type="date" name="fechaInicio" min="{{date('Y-m-d')}}" required>
        </div>
        <div class="col-12 col-md-4 row">
            <input class="form-control" type="date" name="fechaFin" min="{{date('Y-m-d')}}" required>
        </div>
        <div class="col-12 col-md-4 row">
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
                        <input type="submit" value="borrar" onclick="confirm('¿Eliminar este registro?')">
                    </form>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
