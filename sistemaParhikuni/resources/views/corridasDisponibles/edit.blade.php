@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
    <h3>Corrida programada {{ @$corridaDisponible->nNumero }}</h3>

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

    <form action="" class="row needs-validation">
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
                <select name="tipoDeServicio" id="tipoDeServicio" class="form-control">
                    <option value="" disabled>Seleccione</option>
                    @foreach($servicios as $servicio)
                        <option value="{{($servicio->nNumero)}}">{{($servicio->aDescripcion)}}</option>
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeSalida" class="float-md-right text-md-right">Fecha de salida*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="fechaDeSalida" type="date" name="fechaDeSalida" class="form-control"
                    value="{{@$corridaDisponible->fSalida}}" min="{{$corridaDisponible->fSalida}}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="HoraDeSalida" class="float-md-right text-md-right">Hora de salida*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="HoraDeSalida" type="date" name="HoraDeSalida" class="form-control"
                    value="{{$corridaDisponible->hSalida}}" >
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="estado" class="float-md-right text-md-right">Estado*</label>
            </div>
            <div class="col-12 col-md-8">
                <select name="estado" id="estado" class="form-control">
                    <option value="">Seleccione</option>
                    @foreach($estados as $estado)
                        @if($corridaDisponible->aEstado == $estado->id)
                        <option value="{{$estado->id}}" selected>{{$estado->aEstado}}</option>
                        @else
                        <option value="{{$estado->id}}">{{$estado->aEstado}}</option>
                        @endif
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="autobus" class="float-md-right text-md-right">Autobus*</label>
            </div>
            <div class="col-12 col-md-8">
                <select name="autobus" id="autobus" class="form-control">
                    <option value="">Seleccione</option>
                    @foreach($autobuses as $autobus)
                        @if($corridaDisponible->nNumeroAutobus == $autobus->nNumeroAutobus)
                        <option value="{{$estado->id}}" selected>{{$autobus->nNumeroEconomico}}</option>
                        @else
                        <option value="{{$estado->id}}">{{$autobus->nNumeroEconomico}}</option>
                        @endif
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="conductor" class="float-md-right text-md-right">Conductor*</label>
            </div>
            <div class="col-12 col-md-8">
                <select name="conductor" id="conductor" class="form-control">
                    <option value="">Seleccione</option>
                    @foreach($conductores as $conductor)
                        @if($conductor->nNumeroConductor == $corridaDisponible->nNumeroConductor)
                        <option value="{{$conductor->nNumeroConductor}}" selected>{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                        @else
                        <option value="{{$conductor->nNumeroConductor}}">{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                        @endif
                    @endforeach
                </select>
            </div>
        </div>
    </form>
</div>
@endsection