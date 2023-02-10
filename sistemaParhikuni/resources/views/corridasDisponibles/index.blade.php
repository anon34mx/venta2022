@extends('layouts.parhikuni')

@section('content')
    <div class="row">
        <h3>Corridas disponibles</h3>

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

        <form action="" id="form-filtrar-corridas"
            class="col-12 row" method="get" novalidate>
            <fieldset>
                Filtrar corridas
            </fieldset>

            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="nombreDeUsuario" class="">Origen</label>
                </div>
                <div class="">
                    <select name="origen" id="origen" class="form-control">
                        <option value="">Todos</option>
                        @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}"  {{@$request["origen"]==$oficina->nNumero ? "selected" : ""}}>{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="nombreDeUsuario" class="">Destino</label>
                </div>
                <div class="">
                    <select name="destino" id="destino" class="form-control">
                        <option value="">Todos</option>
                        @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}"  {{@$request["destino"]==$oficina->nNumero ? "selected" : ""}}>{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="nombreDeUsuario" class="">Tipo de servicio</label>
                </div>
                <div class="">
                    <select name="tipoDeServicio" id="tipoDeServicio" class="form-control">
                        <option value="">Todos</option>
                        @foreach($tiposServicio as $ts)
                        <option value="{{$ts->nNumero}}" {{ $ts->nNumero==@$request["tipoDeServicio"] ? "selected": ""}} >{{$ts->aDescripcion}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="fecha" class="">Fecha</label>
                </div>
                <div class="">
                    <input id="fecha"class="form-control" type="date" value="{{@$request['fecha']}}" min="{{$yesterday}}" name="fecha">
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="nombreDeUsuario" class="">Estado</label>
                </div>
                <div class="">
                    <select name="estado" id="estado" class="form-control">
                        <option value="" selected>Todos</option>
                        @foreach($estadosCorridas as $estados)
                            @if($estados->id==@$request['estado'])
                            <option value="{{$estados->id}}" selected>{{$estados->aEstado}}</option>
                            @else
                            <option value="{{$estados->id}}">{{$estados->aEstado}}</option>
                            @endif
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="autobus" class="">Autobus</label>
                </div>
                <div class="">
                    <select name="autobus" id="autobus" class="form-control">
                        <option value="">Todos</option>
                        @foreach($autobuses as $autobus)
                            @if(@$request['autobus']==$autobus->nNumeroAutobus)
                                <option value="{{$autobus->nNumeroAutobus}}" selected>{{$autobus->nNumeroEconomico}}</option>
                            @else
                                <option value="{{$autobus->nNumeroAutobus}}">{{$autobus->nNumeroEconomico}}</option>
                            @endif
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-6 col-sm-4 col-md-3 mb-2">
                <div class="col-12">
                    <label for="conductor" class="">Conductor</label>
                </div>
                <div class="">
                    <select name="conductor" id="conductor" class="form-control">
                        <option value="">Todos</option>
                        @foreach($conductores as $conductor)
                            @if(@$request['conductor']==$conductor->nNumeroConductor)
                                <option value="{{$autobus->nNumeroAutobus}}" selected>{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                            @else
                                <option value="{{$autobus->nNumeroAutobus}}">{{$conductor->persona->aApellidos." ".$conductor->persona->aNombres}}</option>
                            @endif
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12">
                <span class="btn-collap col-auto float-right" title="Buscar">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="buscar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Buscar</span>
                    </label>
                    <input id="buscar" type="submit" class="btn" name="send" value="buscar">
                </span>
                <span class="btn-collap col-auto float-right" title="reset" onclick="event.preventDefault();$('input,select').val('');$('#form-filtrar-corridas').submit()">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="reset">
                        <i class="fa-solid fa-delete-left"></i>
                        <span>Reset</span>
                    </label>
                    <input id="reset" type="submit" class="btn" name="send" value="reset">
                </span>
            </div>
        </form>

        <div style="overflow-x:auto;overflow-y: hidden;">
            <table class="mt-2 table table-parhi table-striped">
                <thead>
                    <tr>
                        <th>Clave</th>
                        <th>Itinerario</th>
                        <th>Tipo Servicio</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Estado</th>
                        <th>Autobus</th>
                        <th>Conductor</th>
                        <th>Boletos vendidos</th>
                        <th colspan="7"></th>
                    </tr>
                </thead>
                <tbody>
                    @if(sizeof($corridasDisponibles)>0)
                        @foreach($corridasDisponibles as $cd)
                            <tr class='
                                    {{ $cd->aEstado=="C" ? "text-danger" : ""}}
                                    {{ $cd->aEstado=="B" ? "text-secondary" : ""}}
                                '>
                                <td>{{$cd->nNumero}}</td>
                                <td>
                                    @php
                                    $itinerario = $cd->getItinerario();
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
                                </td>
                                <td>{{ $cd->servicio->aDescripcion }}</td>
                                <td class="nobreak">{{ date_format(date_create($cd->fSalida), "d/m/Y") }}</td>
                                <td class="nobreak">{{ substr($cd->hSalida, 0, 5) }}h</td>
                                <td>{{ $cd->aEstado }}</td>
                                <td>{{ $cd->autobus->nNumeroEconomico }}</td>
                                <td>{{ ($cd->nNumeroConductor==null) ? "NA": $cd->conductor->persona->aApellidos." - ".$cd->conductor->persona->aNombres}}</td>
                                <td>{{ $cd->aEstado=="C" ? sizeof($cd->boletosEnLimbo()) : sizeof($cd->boletos) }}</td>
                                <td>
                                    @if($cd->aEstado=="C" && sizeof($cd->boletosEnLimbo())>0)
                                        <a href="{{ route('boletos.limbo.show', $cd->nNumero) }}">
                                            <span class="btn-collap" title="Reubicar pasajeros">
                                                <label class="btn btn-sm btn-primary"
                                                    for="edit-{{$cd->nNumero}}">
                                                    <i class="fa-solid fa-arrow-rotate-right"></i>
                                                    <span>Reubicar pasajeros</span>
                                                </label>
                                                <input id="edit-{{$cd->nNumero}}" type="submit"
                                                class="btn" onclick="">
                                            </span>
                                        </a>
                                    @elseif($cd->aEstado=="C" && sizeof($cd->boletosEnLimbo())==0)
                                        <a href="{{ route('corridas.disponibles.edit', $cd->nNumero) }}">
                                            <span class="btn-collap" title="Ver detalles">
                                                <label class="btn btn-sm btn-primary"
                                                    for="edit-{{$cd->nNumero}}">
                                                    <i class="fa-solid fa-eye"></i>
                                                    <span>Ver detalles</span>
                                                </label>
                                                <input id="edit-{{$cd->nNumero}}" type="submit"
                                                class="btn" onclick="">
                                            </span>
                                        </a>
                                    @else
                                        <ul class="list-desp btn btn-primary">
                                            <div class="title">Editar</div>
                                            <span>🔽</span>
                                            <div class="list-cont">
                                                @foreach($cd->getItinerario() as $itinerario)
                                                    @if(Auth::user()->hasRole('Admin') || $itinerario->nOrigen == Auth::user()->personas->nOficina)
                                                        <li class="col-12">
                                                            <label for="edit-{{$cd->nNumero}}" class="btn btn-primary col-12 m-0 ">
                                                                {{ $itinerario->consecutivo}}.-&emsp;{{$itinerario->origen."-".$itinerario->destino}}
                                                            </label>
                                                        </li>
                                                        <form style="display:none;" action="{{ route('corridas.disponibles.edit', $cd->nNumero) }}" method="get">
                                                            <input type="text" name="oficinaOrigen"  value="{{$itinerario->nOrigen}}">
                                                            <input id="edit-{{$cd->nNumero}}" type="submit">
                                                        </form>
                                                    @endif
                                                @endforeach
                                            </div>
                                        </ul>

                                        <!-- <a href="{{ route('corridas.disponibles.edit', $cd->nNumero) }}">
                                            <span class="btn-collap" title="Editar">
                                                <label class="btn btn-sm btn-primary"
                                                    for="edit-{{$cd->nNumero}}">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                    <span>Editar</span>
                                                </label>
                                                <input id="edit-{{$cd->nNumero}}" type="submit"
                                                class="btn" onclick="">
                                            </span>
                                        </a> -->
                                    @endif
                                </td>
                                <td>
                                    @if(true)
                                    <!-- Auth::user()->hasRole('Admin') -->
                                    <ul class="list-desp btn btn-primary">
                                        <div class="title">Despachar</div>
                                        <span>🔽</span>
                                        <div class="list-cont">
                                            @foreach($cd->getItinerario() as $itinerario)
                                                @if(Auth::user()->hasRole('Admin') || $itinerario->nOrigen == Auth::user()->personas->nOficina)
                                                    <li class="col-12">
                                                        <label for="desp-{{$cd->nNumero}}" class="btn btn-primary col-12 m-0 ">
                                                            {{ $itinerario->consecutivo}}.-&emsp;{{$itinerario->origen."-".$itinerario->destino}}
                                                        </label>
                                                    </li>
                                                    <form style="display:none;" action="{{route('corridas.disponibles.despachar',$cd)}}" method="POST">
                                                        @csrf
                                                        <input type="hidden" name="consecutivo"  value="{{$itinerario->consecutivo}}">
                                                        <input type="text" name="oficina"  value="{{$itinerario->nOrigen}}">
                                                        <input id="desp-{{$cd->nNumero}}" type="submit">
                                                    </form>
                                                @endif
                                            @endforeach
                                        </div>
                                    </ul>
                                    @else
                                        <form action="{{route('corridas.disponibles.despachar',$cd)}}" method="POST">
                                            @csrf
                                            @method('')
                                            <span class="btn-collap" title="Despachar">
                                                <label class="btn btn-sm btn-success"
                                                    for="del-{{ $cd->nNumero }}">
                                                    <i class="fa-sharp fa-solid fa-van-shuttle"></i>
                                                    <span>Despachar (servicios)</span>
                                                </label>
                                                <input id="del-{{ $cd->nNumero }}" type="submit"
                                                class="btn"
                                                
                                                @if(sizeof($cd->boletos) < $cd->servicio->ocupacioMinima || $cd->servicio->ocupacioMinima==0)
                                                    onclick="return confirm('La corrida tiene {{sizeof($cd->boletos)}} pasajeros, el mínimo necesario es {{$cd->servicio->ocupacioMinima}}.\n¿Despachar corrida de igual forma?')"
                                                @endif
                                                >
                                            </span>
                                        </form>
                                    @endif
                                </td>
                                <td>
                                    <a href="{{ route('corridas.disponibles.guiaPasajeros', $cd->nNumero) }}">
                                        <span class="btn-collap" title="Guia pasajeros">
                                            <label class="btn btn-sm btn-primary"
                                                for="guia-{{$cd->nNumero}}">
                                                <i class="fa-solid fa-pen-to-square"></i>
                                                <span>Guia pasajeros</span>
                                            </label>
                                            <input id="guia-{{$cd->nNumero}}" type="submit"
                                            class="btn" onclick="">
                                        </span>
                                    </a>
                                </td>
                                <td>
                                    @if($cd->aEstado=="C")
                                        <span class="btn-collap" title="Paso puntos">
                                            <label class="btn btn-sm btn-secondary">
                                                <i class="fa-solid fa-check-to-slot"></i>
                                                <span>Paso puntos</span>
                                            </label>
                                            <input class="btn">
                                        </span>
                                    @else
                                    <a href="{{ route('corridas.disponibles.puntosDeControl', $cd->nNumero) }}">
                                        <span class="btn-collap" title="puntosDeControl">
                                            <label class="btn btn-sm btn-primary"
                                                for="hist-{{$cd->nNumero}}">
                                                <i class="fa-solid fa-check-to-slot"></i>
                                                <span>puntosDeControl</span>
                                            </label>
                                            <input id="hist-{{$cd->nNumero}}" type="submit"
                                            class="btn" onclick="">
                                        </span>
                                    </a>
                                    @endif
                                </td>
                                </td>
                                <td>
                                    <form action="{{route('corridas.programadas.destroy',$cd)}}" method="POST">
                                        @csrf
                                        @method('DELETE')
                                        <span class="btn-collap" title="Eliminar">
                                            <label class="btn btn-sm btn-danger"
                                                for="del-{{ $cd->nNumero }}">
                                                <i class="fa-solid fa-circle-minus"></i>
                                                <span>Eliminar</span>
                                            </label>
                                            <input id="del-{{ $cd->nNumero }}" type="submit"
                                            class="btn"
                                            onclick="return confirm('¿Eliminar corrida programada?')">
                                        </span>
                                    </form>
                                </td>
                            </tr>
                        @endforeach
                    @else
                        <tr>
                            <td colspan="999"><b>No se encontraron corridas</b></td>
                        </tr>
                    @endif
                </tbody>
            </table>
        </div>
        <div class="mt-3 d-flex justify-content-center">
            {!! $corridasDisponibles->appends(Request::all())->links("pagination::bootstrap-5") !!}
        </div>
    </div>
@endsection