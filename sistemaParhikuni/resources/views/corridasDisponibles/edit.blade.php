@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
    <h3>Corrida disponible {{ @$corridaDisponible->nNumero }}</h3>

    <div>
        @if(session()->has('status'))
            <p class="alert alert-success">{{session('status')}}</p>
        @endif
    </div>
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    <form action="{{route('corridas.disponibles.update', $corridaDisponible)}}" class="row needs-validation" method="post">
        @csrf
        <div class="col-12 row mb-2">
            <div class="col-12 col-md-4 col-lg-3">
                <label for="itinerario" class="float-md-right text-md-right">Itinerario*</label>
            </div>
            <div class="col-12 col-md-8 col-lg-9">
                @php
                    $itinerario = $corridaDisponible->getItinerario();
                    $size = sizeof($itinerario);
                    for($i=0;$i<$size; $i++){
                        // var_dump($itinerario[$i]);
                        if($i==$size-1){
                            echo "➡".$itinerario[$i]->claveOrigen."<br>➡".$itinerario[$i]->claveDestino;
                        }else{
                            echo "➡".$itinerario[$i]->claveOrigen."<br>";
                        }
                    }
                @endphp
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="tipoDeServicio" class="float-md-right text-md-right">Tipo de servicio*</label>
            </div>
            <div class="col-12 col-md-8">
                <select id="tipoDeServicio" class="form-control" disabled>
                        <option selected>{{$corridaDisponible->servicio->aDescripcion}}</option>
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeSalida" class="float-md-right text-md-right">Fecha de salida*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="fechaDeSalida" disabled type="date" class="form-control"
                    value="{{@$corridaDisponible->fSalida}}" >
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="HoraDeSalida" class="float-md-right text-md-right">Hora de salida*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="HoraDeSalida" disabled type="time" class="form-control"
                    value="{{$corridaDisponible->hSalida}}" >
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="estado" class="float-md-right text-md-right">Estado*</label>
            </div>
            <div class="col-12 col-md-8">
                @if($corridaDisponible->aEstado=="B")
                    <select name="estado" id="estado" class="form-control">
                        <option value="B" selected>Bloqueada</option>
                        <option value="DB" >Desbloquear</option>
                        <option value="C" >Cancelar</option>
                    </select>
                @elseif($corridaDisponible->aEstado=="C")
                    <select class="form-control" disabled>
                        <option>Cancelada</option>
                    </select>
                @else
                    <select name="estado" id="estado" class="form-control">
                        <option value="" disabled>Seleccione</option>
                        @foreach($estados as $estado)
                            @if($corridaDisponible->aEstado == $estado->id)
                            <option value="{{$estado->id}}" {{ ($estado->elegible!=1) ? "disabled":""}} selected>{{$estado->aEstado}}</option>
                            @else
                            <option value="{{$estado->id}}" {{ ($estado->elegible!=1) ? "disabled":""}} >{{$estado->aEstado}}</option>
                            @endif
                        @endforeach
                    </select>
                @endif
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="autobus" class="float-md-right text-md-right">Autobus*</label>
            </div>
            <div class="col-12 col-md-8">
                    @if($corridaDisponible->aEstado=="B" || $corridaDisponible->aEstado=="C")
                    <select name="" id="autobus" class="form-control" disabled>
                        <option value="">{{$corridaDisponible->autobus->nNumeroEconomico}}</option>
                    </select>
                    @else
                    <select name="autobus" id="autobus" class="form-control">
                        <option value="" {{($corridaDisponible->nNumeroAutobus!=null) ? "disabled": ""}} >Seleccione</option>
                        @foreach($autobuses as $autobus)
                            @if($corridaDisponible->nNumeroAutobus == $autobus->nNumeroAutobus)
                            <option value="{{$autobus->nNumeroAutobus}}" selected>{{$autobus->nNumeroEconomico}}</option>
                            @else
                            <option value="{{$autobus->nNumeroAutobus}}">{{$autobus->nNumeroEconomico}}</option>
                            @endif
                        @endforeach
                    </select>
                    @endif
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="conductor" class="float-md-right text-md-right">Conductor*</label>
            </div>
            <div class="col-12 col-md-8">
                @if($corridaDisponible->aEstado=="B" || $corridaDisponible->aEstado=="C")
                    <select name="" id="autobus" class="form-control" disabled>
                        <option value="">{{@$corridaDisponible->conductor->persona->aApellidos." - ".@$corridaDisponible->conductor->persona->aNombres}}</option>
                    </select>
                @else
                    <select name="conductor" id="conductor" class="form-control">
                        <option value="" {{($corridaDisponible->nNumeroAutobus==null) ? "selected":""}}>Seleccione</option>
                        @foreach($conductores as $conductor)
                            @if($conductor->nNumeroConductor == $corridaDisponible->nNumeroConductor)
                            <option value="{{$conductor->nNumeroConductor}}" selected>{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                            @else
                            <option value="{{$conductor->nNumeroConductor}}">{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                            @endif
                        @endforeach
                    </select>
                @endif
            </div>
        </div>
        <div class="col-12 justify-content-center">
            @if($corridaDisponible->aEstado=="C")
            <a href="{{route('corridas.disponibles.index')}}">
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
            @else
            <span class="btn-collap float-right" title="Guardar">
                <label class="btn btn-sm btn-parhi-primary"
                    for="guardar">
                    <i class="fa-solid fa-floppy-disk"></i>
                    <span>Guardar</span>
                </label>
                <input id="guardar" type="submit"
                class="btn">
            </span>

            @endif
        </div>
    </form>
</div>
@endsection