@extends('layouts.parhikuni')

@section('content')
<div class="col-12">
    <h3>Corridas disponibles</h3>
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
                    <th colspan="2"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($corridasDisponibles as $cp)
                <tr class='
                        {{ $cp->aEstado=="C" ? "text-danger" : ""}}
                        {{ $cp->aEstado=="B" ? "text-secondary" : ""}}
                    '
                >
                    <td>{{$cp->nNumero}}</td>
                    <td>
                        @php
                        $itinerario = $cp->getItinerario();
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
                    <td>{{ $cp->servicio->aDescripcion }}</td>
                    <td class="nobreak">{{ $cp->fSalida }}</td>
                    <td class="nobreak">{{ substr($cp->hSalida, 0, 5) }}h</td>
                    <td>{{ $cp->aEstado }}</td>
                    <td>{{ $cp->autobus->nNumeroEconomico }}</td>
                    <td>{{ ($cp->nNumeroConductor==null) ? "NA": $cp->conductor->persona->aApellidos." - ".$cp->conductor->persona->aNombres}}</td>
                    <td>{{ $cp->aEstado=="C" ? sizeof($cp->boletosEnLimbo()) : sizeof($cp->boletosVendidos) }}</td>
                    <td>
                        @if($cp->aEstado=="C" && sizeof($cp->boletosEnLimbo())>0)
                            <a href="{{ route('boletos.limbo.show', $cp->nNumero) }}">
                                <span class="btn-collap" title="Editar">
                                    <label class="btn btn-sm btn-primary"
                                        for="edit-{{$cp->nNumero}}">
                                        <i class="fa-solid fa-arrow-rotate-right"></i>
                                        <span>Reubicar pasajeros</span>
                                    </label>
                                    <input id="edit-{{$cp->nNumero}}" type="submit"
                                    class="btn" onclick="">
                                </span>
                            </a>
                        @elseif($cp->aEstado=="C" && sizeof($cp->boletosEnLimbo())>0) 
                        
                        @else
                            <a href="{{ route('corridas.disponibles.edit', $cp->nNumero) }}">
                                <span class="btn-collap" title="Editar">
                                    <label class="btn btn-sm btn-primary"
                                        for="edit-{{$cp->nNumero}}">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                        <span>Editar</span>
                                    </label>
                                    <input id="edit-{{$cp->nNumero}}" type="submit"
                                    class="btn" onclick="">
                                </span>
                            </a>
                        @endif
                    </td>
                    <td>
                        <form action="{{route('corridas.programadas.destroy',$cp)}}" method="POST">
                            @csrf
                            @method('DELETE')
                            <span class="btn-collap" title="Eliminar">
                                <label class="btn btn-sm btn-danger"
                                    for="del-{{ $cp->nNumero }}">
                                    <i class="fa-solid fa-circle-minus"></i>
                                    <span>Eliminar</span>
                                </label>
                                <input id="del-{{ $cp->nNumero }}" type="submit"
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