@extends('layouts.parhikuni')

@section('content')
<div class="col-12">
    <h3 class="titleWithAnchor" id="nuevoUsuario">
        <a href="#nuevoUsuario">Corridas programadas</a>
    </h3>
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    <form action="{{route('corridas.programadas.store')}}" method="POST" class="needs-validation" novalidate>
        @csrf
        <div class="row form-group">
            <div class="col-12 row mb-2 px-md-4">
                <div class="col-12 col-md-4 col-lg-3">
                    <label for="itinerario" class="float-md-right text-md-right">Itinerario*</label>
                </div>
                <div class="col-12 col-md-8 col-lg-9">
                    <select name="itinerario" id="itinerario" class="form-control" required>
                        <option value="" disabled selected>Seleccione</option>
                        @foreach($itinerarios as $itinerario=>$tramos)
                            <option value="{{ $itinerario }}">
                                @php
                                $tiempoTotal=0;
                                for($i=0; $i<sizeof($tramos);$i++){
                                    $tiempoTotal+=$tramos[$i]->nTiempo+$tramos[$i]->nEstancia;
                                    if($i==sizeof($tramos)-1){
                                        echo $tramos[$i]->claveOrigen." ➡ ".$tramos[$i]->claveDestino;
                                    }else{
                                        echo $tramos[$i]->claveOrigen." ➡";
                                    }
                                }
                                @endphp
                            </option>
                        @endforeach
                    </select>
                    @php
                    foreach($itinerarios as $itinerario=>$tramos){
                        $tiempoTotal=0;
                        for($i=0; $i<sizeof($tramos);$i++){
                            $tiempoTotal+=$tramos[$i]->nTiempo+$tramos[$i]->nEstancia;
                        }
                        @endphp
                        <div class="hidden">
                            <div id="tiempo-{{$itinerario}}">{{$tiempoTotal}}</div>
                        </div>
                        @php
                    }

                    @endphp
                </div>
            </div>
            <div class="col-12 col-md-6 row mb-2">
                <div class="col-12 col-md-4 col-lg-3">
                    <label for="itinerario" class="float-md-right text-md-right">Servicio*</label>
                </div>
                <div class="col-12 col-md-8 col-lg-9">
                    <select name="tipoDeServicio" id="tipoDeServicio" class="form-control" required onchange="calcHoraLlegada();">
                        <option value="" disabled selected>Seleccione</option>
                        @foreach($servicios as $servicio)
                            <option value="{{($servicio->nNumero)}}">{{($servicio->aDescripcion)}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-md-6 row mb-2">
                <div class="col-12 col-md-4 col-lg-3">
                    <label for="horaDeSalida" class="float-md-right text-md-right">Hora de salida*</label>
                </div>
                <div class="col-12 col-md-8 col-lg-9">
                    <input id="horaDeSalida" type="time" name="horaDeSalida" class="form-control" value="{{old('horaDeSalida')}}" onchange="calcHoraLlegada();" required>
                </div>
            </div>
            <!-- <div class="col-12 col-md-6 row mb-2">
                <div class="col-12 col-md-4 col-lg-3">
                    <label for="horaDeLlegada" class="float-md-right text-md-right">Hora de llegada*</label>
                </div>
                <div class="col-12 col-md-8 col-lg-9">
                    <input id="horaDeLlegada" type="time" class="form-control" readonly>
                </div>
            </div> -->
            <div class="col-12 col-md-6 row mb-2">
                <div class="col-12 col-md-4 col-lg-3">
                    <label for="fechaDeInicio" class="float-md-right text-md-right">Fecha de inicio*</label>
                </div>
                <div class="col-12 col-md-8 col-lg-9">
                    <input id="fechaDeInicio" type="date" name="fechaDeInicio" class="form-control" min="{{date('Y-m-d')}}" value="{{date('Y-m-d')}}" required>
                </div>
            </div>
            <div class="col-12 col-md-6 row mb-2">
                <div class="col-12 col-md-4 col-lg-3">
                    <label for="fechaDeFin" class="float-md-right text-md-right">Fecha de fin*</label>
                </div>
                <div class="col-12 col-md-8 col-lg-9">
                    <input id="fechaDeFin" type="date" name="fechaDeFin" class="form-control" min="{{date('Y-m-d')}}" required>
                </div>
            </div>
            <div class="col-12 row mb-2 px-4">
                <div class="col-0 col-sm-1"></div>
                <table class="col-12 col-sm-10 px-4 text-center">
                    <tr>
                        <td class="col-auto px-4">
                            <input id="lunes" type="checkbox" class="form-check-input" name="dias[lLunes]"
                                {{ (@$corridaProgramada->lLunes==true) ? "checked" : ""}}>
                            <label for="lunes" class="px-2">L</label>
                        </td>
                        <td class="col-auto px-4">
                            <input id="martes" type="checkbox" class="form-check-input" name="dias[lMartes]"
                                {{ (@$corridaProgramada->lMartes==true) ? "checked" : ""}}>
                            <label for="martes" class="px-2">M</label>
                        </td>
                        <td class="col-auto px-4">
                            <input id="miercoles" type="checkbox" class="form-check-input" name="dias[lMiercoles]"
                                {{ (@$corridaProgramada->lMiercoles==true) ? "checked" : ""}}>
                            <label for="miercoles" class="px-2">I</label>
                        </td>
                        <td class="col-auto px-4">
                            <input id="jueves" type="checkbox" class="form-check-input" name="dias[Jueves]"
                                {{ (@$corridaProgramada->lJueves==true) ? "checked" : ""}}>
                            <label for="jueves" class="px-2">J</label>
                        </td>
                        <td class="col-auto px-4">
                            <input id="viernes" type="checkbox" class="form-check-input" name="dias[lViernes]"
                                {{ (@$corridaProgramada->lViernes==true) ? "checked" : ""}}>
                            <label for="viernes" class="px-2">V</label>
                        </td>
                        <td class="col-auto px-4">
                            <input id="sabado" type="checkbox" class="form-check-input" name="dias[lSabado]"
                                {{ (@$corridaProgramada->lSabado==true) ? "checked" : ""}}>
                            <label for="sabado" class="px-2">S</label>
                        </td>
                        <td class="col-auto px-4">
                            <input id="domingo" type="checkbox" class="form-check-input" name="dias[lDomingo]"
                                {{ (@$corridaProgramada->lDomingo==true) ? "checked" : ""}}>
                            <label for="domingo" class="px-2">D</label>
                        </td>
                    </tr>
                </table>
                <div class="col-0 col-sm-1"></div>
                <div class="col-12">
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
        </div>
    </form>

    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="table table-parhi table-stripped ">
            <thead>
                <tr>
                    <th>Clave</th>
                    <th>Itinerario</th>
                    <th>Tipo Servicio</th>
                    <th>Inicio</th>
                    <th>Fin</th>
                    <th>Hora</th>
                    <th>L</th>
                    <th>M</th>
                    <th>I</th>
                    <th>J</th>
                    <th>V</th>
                    <th>S</th>
                    <th>D</th>
                    <th colspan="2"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($corridasProgramadas as $cp)
                <tr>
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
                    <td class="nobreak">{{$cp->fInicio}}</td>
                    <td class="nobreak">{{$cp->fFin}}</td>
                    <td>{{ $cp->hSalida }}</td>
                    <td>{{ ($cp->lLunes == 1 ? "🟢" :"🔘") }}</td>
                    <td>{{ ($cp->lMartes == 1 ? "🟢" :"🔘") }}</td>
                    <td>{{ ($cp->lMiercoles == 1 ? "🟢" :"🔘") }}</td>
                    <td>{{ ($cp->lJueves == 1 ? "🟢" :"🔘") }}</td>
                    <td>{{ ($cp->lViernes == 1 ? "🟢" :"🔘") }}</td>
                    <td>{{ ($cp->lSabado == 1 ? "🟢" :"🔘") }}</td>
                    <td>{{ ($cp->lDomingo == 1 ? "🟢" :"🔘") }}</td>
                    <td>
                        <a href="{{ route('corridas.programadas.show', $cp->nNumero) }}">
                            <span class="btn-collap" title="Detalles">
                                <label class="btn btn-sm btn-primary"
                                    for="edit-{{$cp->nNumero}}">
                                    <i class="fa-solid fa-eye"></i>
                                    <span>Detalles</span>
                                </label>
                                <input id="edit-{{$cp->nNumero}}" type="submit"
                                class="btn" onclick="">
                            </span>
                        </a>
                    </td>
                    <td>
                        <form action="{{ route('corridas.programadas.transfer', $cp->nNumero) }}" method="post">
                            @csrf
                            <span class="btn-collap" title="Transferir">
                                <label class="btn btn-sm btn-primary"
                                    for="transfer-{{$cp->nNumero}}">
                                    <i class="fa-solid fa-arrow-right-arrow-left"></i>
                                    <span>Transferir</span>
                                </label>
                                <input id="transfer-{{$cp->nNumero}}" type="submit"
                                class="btn" onclick="">
                            </span>
                        </form>
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
                                onclick="return confirm('¿Eliminar corrida programada?\n⚠Esto eliminará sus corridas disponibles')">
                            </span>
                        </form>
                    </td>
                </tr>
                @endforeach
            </tbody>
        </table>
        <div class="mt-3 d-flex justify-content-center">
        {!! $corridasProgramadas->appends(Request::all())->links("pagination::bootstrap-5") !!}
    </div>
    </div>
</div>
@endsection