@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-11 mx-auto">
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

    @if($corridaDisponible->aEstado == "T")        
        <form class="row needs-validation">
    @else
        <form action="{{route('corridas.disponibles.update', $corridaDisponible)}}" class="row needs-validation" method="post">
    @endif
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
                @if($corridaDisponible->aEstado == "B")
                    <select name="estado" id="estado" class="form-control">
                        <option value="B" selected>Bloqueada</option>
                        <option value="DB" >Desbloquear</option>
                        <option value="C" >Cancelar</option>
                    </select>
                @elseif($corridaDisponible->aEstado=="C" || $corridaDisponible->aEstado=="T")
                    <select class="form-control" disabled>
                        <option>{{$corridaDisponible->estado->aEstado}}</option>
                    </select>
                @else
                    <select name="estado" id="estado" class="form-control">
                        <option value="" disabled>Seleccione</option>
                        @foreach($estados as $estado)
                            @if($corridaDisponible->nNumeroConductor==null && $estado->id=="S")
                                <option disabled>{{$estado->aEstado}}</option>
                            @else
                                @if($corridaDisponible->aEstado == $estado->id)
                                <option value="{{$estado->id}}" {{ ($estado->elegible!=1) ? "disabled":""}} selected>{{$estado->aEstado}}</option>
                                @else
                                <option value="{{$estado->id}}" {{ ($estado->elegible!=1) ? "disabled":""}} >{{$estado->aEstado}}</option>
                                @endif
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
                    @if($corridaDisponible->aEstado=="B" || $corridaDisponible->aEstado=="C" || $corridaDisponible->aEstado=="T")
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
                @if($corridaDisponible->aEstado=="B" || $corridaDisponible->aEstado=="C" || $corridaDisponible->aEstado=="T")
                    <select name="" id="conductor" class="form-control" disabled>
                        <option value="">{{@$corridaDisponible->conductor->persona->aApellidos." - ".@$corridaDisponible->conductor->persona->aNombres}}</option>
                    </select>
                @else
                    <select name="conductor" id="conductor" class="form-control">
                        <option value="" {{($corridaDisponible->nNumeroAutobus==null) ? "selected":""}}>Seleccione</option>
                        @if($corridaDisponible->conductor!=null)
                        <option value="" selected>{{@$corridaDisponible->conductor->persona->aApellidos." ".@$corridaDisponible->conductor->persona->aNombres}}</option>
                        @endif
                        @foreach($conductores as $conductor)
                            <option value="{{$conductor->nNumeroConductor}}">{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                        @endforeach
                    </select>
                @endif
            </div>
        </div>
        
        @if(Auth::user()->hasRole("Admin")==true)
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="conductor" class="float-md-right text-md-right">Oficina</label>
            </div>
            <div class="col-12 col-md-8">
                @php
                // dd($corridaDisponible->getItinerario())
                @endphp
                <select class="form-control" name="oficina" id="oficina" required>
                    <option value="" >Seleccionar oficina</option>
                    @foreach($corridaDisponible->getItinerario() as $oficina)
                        <option value="{{$oficina->nOrigen}}"
                            {{$oficinaOrigen==$oficina->nOrigen ? "selected" : ""}}
                            >{{$oficina->origen}}
                    </option>
                    @endforeach
                </select>
            </div>
        </div>
        @endif

        <div class="col-12 justify-content-center">
            <!--  -->
            @if($corridaDisponible->aEstado!="T" && $corridaDisponible->aEstado!="L" && $corridaDisponible->aEstado!="C")
            <span class="btn-collap float-right mx-1" title="Guardar">
                <label class="btn btn-sm btn-parhi-primary"
                    for="guardar">
                    <i class="fa-solid fa-floppy-disk"></i>
                    <span>Guardar</span>
                </label>
                <input id="guardar" type="submit"
                class="btn">
            </span>
            @endif
            <a href="{{route('corridas.disponibles.index')}}">
                <span class="btn-collap float-left mx-1" title="volver">
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
    </form>
    <div class="col-12">

    </div>
    @if($corridaDisponible->aEstado=="S" && false)
        <form class="float-right" action="{{route('corridas.disponibles.despachar',$corridaDisponible)}}" method="POST">
            @csrf
            @method('')
            <span class="btn-collap float-right" title="Despachar">
                <label class="btn btn-sm btn-success"
                    for="del-{{ $corridaDisponible->nNumero }}">
                    <i class="fa-sharp fa-solid fa-van-shuttle"></i>
                    <span>Despachar</span>
                </label>
                <input id="del-{{ $corridaDisponible->nNumero }}" type="submit"
                class="btn"
                @if(sizeof($corridaDisponible->boletos) < $corridaDisponible->servicio->ocupacioMinima || $corridaDisponible->servicio->ocupacioMinima==0)
                    onclick="return confirm('La corrida tiene {{sizeof($corridaDisponible->boletos)}} pasajeros, el mínimo necesario es {{$corridaDisponible->servicio->ocupacioMinima}}.\n¿Despachar corrida de igual forma?')"

                @endif
                >
            </span>
        </form>
    @endif
</div>
@endsection