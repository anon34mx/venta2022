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
                    <th></th>
                    <th>Despachada</th>
                    <th colspan="2">Salida de </th>
                    <th colspan="2">Llegada a</th>
                </tr>
            </thead>
            <tbody>
                @php
                $siguiente=null;
                foreach($corridaDisponible->puntosDeControl() as $control){
                    if($siguiente==null && $control->fLlegada==null || $control->fLlegada=="0000-00-00 00:00:00"){
                        $siguiente=$control;
                    }
                @endphp
                    <tr>
                        <td>{{@$control->consecutivo}}</td>
                        <td> {{ @$control->despachado!=null ? "✔️" : "❌"}} </td>
                        <td class="text-right">{{@$control->origen}}</td>
                        <td class="text-left">➡{{@$control->fSalida}}</td>
                        <td class="text-right">{{@$control->destino}}</td>
                        <td class="text-left">⬅{{@$control->fLlegada}}</td>
                    </tr>
                @php
                }
                @endphp
            </tbody>
        </table>
        @if($siguiente==null)
            <center><b>= Corrida terminada =</b></center>
        @else
            @if(@$siguiente->fSalida==null)
                <h3> Registrar salida de {{@$siguiente->origen}} a {{@$siguiente->destino}}</h3>
            @else
                <h3> Registrar llegada a {{@$siguiente->origen}}</h3>
            @endif
            
            <form action="{{route('corridas.disponibles.registrarPuntoDeControl',$corridaDisponible)}}" method="POST" class="col-12 row needs-validation" novalidate>
                @csrf
                <div class="col-12 col-lg-6 col-xl-4 row mb-2">
                    <div class="col-12 col-md-4">
                        <label for="contraseñaDeCondutor" class="float-md-right text-md-right">*Contraseña de conductor</label>
                    </div>
                    <div class="col-12 col-md-8">
                        <input id="contraseñaDeCondutor" class="form-control" type="password" name="contraseñaDeCondutor" placeholder="Contraseña de conductor"
                            value="" pattern="(^([a-zA-Z0-9\.-_]+)(\d+)?$)" autocomplete="off" required>
                    </div>
                </div>
                <div class="col-12 row">
                    <div class="col-12 justify-content-center">
                        <span class="btn-collap float-right" title="Guardar">
                            <label class="btn btn-sm btn-parhi-primary"
                                for="guardar">
                                <i class="fa-solid fa-floppy-disk"></i>
                                <span>Guardar</span>
                            </label>
                            <input id="guardar" type="submit"
                            class="btn">
                        </span>
                    </div>
                </div>
            </form>
        @endif
    </div>
</div>
@endsection