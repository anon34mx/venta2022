@extends('layouts.parhikuni')

@section('content')
<div class="col-12">
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
    <p>
        poner busqueda
        <br>
        destino
        <br>
        fecha
        <br>
        servicio
        <br>
        estado
        <br>
        conductor
        <br>
        autobus
        <br>
        por corrida programada
        <br>
    </p>

    <form action=""
        class="row needs-validation" method="post">

    </form>

    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="table table-stripped table-parhi">
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
                    <td>{{ $cd->estado->aEstado }}</td>
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
                            <a href="{{ route('corridas.disponibles.edit', $cd->nNumero) }}">
                                <span class="btn-collap" title="Editar">
                                    <label class="btn btn-sm btn-primary"
                                        for="edit-{{$cd->nNumero}}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                        <span>Editar</span>
                                    </label>
                                    <input id="edit-{{$cd->nNumero}}" type="submit"
                                    class="btn" onclick="">
                                </span>
                            </a>
                        @endif
                    </td>
                    <td>
                        @if($cd->aEstado=="C" || $cd->aEstado=="R")
                            <span class="btn-collap" title="Despachar">
                                <label class="btn btn-sm btn-secondary">
                                    <i class="fa-sharp fa-solid fa-van-shuttle"></i>
                                    <span>Despachar</span>
                                </label>
                                <input class="btn">
                            </span>
                        @else
                        <form action="{{route('corridas.disponibles.despachar',$cd)}}" method="POST">
                            @csrf
                            @method('')
                            <span class="btn-collap" title="Despachar">
                                <label class="btn btn-sm btn-success"
                                    for="del-{{ $cd->nNumero }}">
                                    <i class="fa-sharp fa-solid fa-van-shuttle"></i>
                                    <span>Despachar</span>
                                </label>
                                <input id="del-{{ $cd->nNumero }}" type="submit"
                                class="btn"
                                @if(sizeof($cd->boletos) < $cd->servicio->ocupacioMinima)
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
                    <!-- <td>
                        <a href="{{ route('corridas.disponibles.puntosDeControl', $cd->nNumero) }}">
                            <span class="btn-collap" title="Firma llegada/salida">
                                <label class="btn btn-sm btn-primary"
                                    for="edit-{{$cd->nNumero}}">
                                    <i class="fa-solid fa-check-to-slot"></i>
                                    <span>Firma llegada/salida</span>
                                </label>
                                <input id="edit-{{$cd->nNumero}}" type="submit"
                                class="btn" onclick="">
                            </span>
                        </a>
                    </td>  -->
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
            </tbody>
        </table>
        <div class="mt-3 d-flex justify-content-center">
            {!! $corridasDisponibles->appends(Request::all())->links("pagination::bootstrap-5") !!}
        </div>
    </div>
</div>
@endsection