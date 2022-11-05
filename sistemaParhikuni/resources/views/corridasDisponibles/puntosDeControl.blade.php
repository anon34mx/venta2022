@extends('layouts.parhikuni')
@section('content')
<div class="col-12">
    <h3>Puntos de control</h3>
    <p>
        Es el registro del paso del autobús por cada punto del itinerario de su corrida.
    </p>

    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="table table-stripped table-parhi">
            <thead>
                <tr>
                    <th>Tramo</th>
                    <th>Origen</th>
                    <th>Llegada</th>
                    <th>Destino</th>
                    <th>Salida</th>
                </tr>
            </thead>
            <tbody>
                @php
                $siguiente=null;
                foreach($corridaDisponible->puntosDeControl() as $control){
                    if($siguiente==null && $control->fLlegada==null){
                        $siguiente=$control;
                    }
                @endphp
                    <tr>
                        <td>{{$control->consecutivo}}</td>
                        <td>{{$control->origen}}</td>
                        <td>{{$control->fLlegada}}</td>
                        <td>{{$control->destino}}</td>
                        <td>{{$control->fSalida}}</td>
                    </tr>
                @php
                }
                @endphp
            </tbody>
        </table>
        {{var_dump($siguiente)}}
        
        @if($siguiente->fLlegada==null)
            <h3> Registrar llegada a {{$siguiente->origen}}</h3>
        @else
            <h3> Registrar salida de {{$siguiente->origen}}</h3>
        @endif
        
        <form action="">
            
        </form>
    </div>
</div>
@endsection