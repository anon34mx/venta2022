@extends('layouts.parhikuni')
@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
<div class="col-12 row px-0 mx-0">
    <form id="filtros" action="#" class="col-12 col-sm-3 row px-0 mx-0 " style="height: fit-content;display: block;position: sticky;top: 70px;">
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Filtros</a>
        </h3>

        @include('venta.interna.tiempo&alertas',[
            "rest" => "/ventaInterna"
        ])
        <div class="col-6 col-sm-12 row mx-0 my-1">
            <div class="">Fecha</div>
            <div class="px-0 col-12">
                <input class="form-control" type="date" min="{{$fechaMin}}"
                    name="fechaDeSalida" value="{{$fechaDeSalida}}">
            </div>
        </div>
        <div class="col-12 col-sm-12 row mx-0 my-1">
            <div class="col-12">
                Horario
                <span class="horarioTxt">
                    @if(@Request::get('horario') == "Madr")
                        madrugada
                    @elseif(@Request::get('horario') == "Maña")
                        mañana
                    @elseif(@Request::get('horario') == "Tard")
                        tarde
                    @elseif(@Request::get('horario') == "Noch")
                        noche
                    @else
                        todo el día
                    @endif
                </span>
            </div>
            <div class="px-0 col-12">
                <input class="form-control" hidden type="time" id="hInicio" name="hInicio" value="{{@Request::get('hInicio')}}" >
                <input class="form-control" hidden type="time" id="hFin" name="hFin" value="{{@Request::get('hFin')}}" >
            </div>
        </div>
        <div class="col-12 col-sm-12 row mx-0 my-1">
            <div class="col-6 col-sm-12 row px-0 mx-auto selectH">
                <input id="inptbusH" name="inptbusH" value="{{@Request::get('inptbusH')}}" hidden>

                <input id="horarioMadr" class="" value="Madr" type="radio" name="horario"{{@Request::get('horario')=='Madr' ? 'checked':''}} hidden >
                <label for="horarioMadr" class="col-3 madr" onclick="cambiarHorario('Madr', new Event(''), 'lbl-horario');autobusHora(0)" title="Madrugada">
                    <img src="{{ Vite::asset('resources/images/venta/Madrugada.png') }}" alt="">
                </label>

                <input id="horarioMaña" class="" value="Maña" type="radio" name="horario"{{@Request::get('horario')=='Maña' ? 'checked':''}} hidden>
                <label for="horarioMaña" class="col-3 maña" onclick="cambiarHorario('Maña', new Event(''), 'lbl-horario');autobusHora(25)" title="Mañana">
                    <img src="{{ Vite::asset('resources/images/venta/Día.png') }}" alt="">
                </label>

                <input id="horarioTard" class="" value="Tard" type="radio" name="horario"{{@Request::get('horario')=='Tard' ? 'checked':''}} hidden>
                <label for="horarioTard" class="col-3 tard" onclick="cambiarHorario('Tard', new Event(''), 'lbl-horario');autobusHora(50)" title="Tarde">
                    <img src="{{ Vite::asset('resources/images/venta/Tarde.png') }}" alt="">
                </label>

                <input id="horarioNoch" class="" value="Noch" type="radio" name="horario"{{@Request::get('horario')=='Noch' ? 'checked':''}} hidden>
                <label for="horarioNoch" class="col-3 noch" onclick="cambiarHorario('Noch', new Event(''), 'lbl-horario');autobusHora(75)" title="Noche">
                    <img src="{{ Vite::asset('resources/images/venta/Noche.png') }}" alt="">
                </label>

            </div>
            <input id="horarioCompleto" class="" value="Completo" type="radio"
                name="horario" {{@Request::get('horario')=='Completo' ? 'checked':''}} hidden>
            <label for="horarioCompleto" onclick='cambiarHorario("completo", new Event(""), "lbl-horario");autobusHora(100);'
                class="btn-parhi-primary col-6 col-sm-12 btn lbl-horario my-2 {{Request::get('horario')=='Completo' ? '' : ''}}"
                >Todo el día</label>
        </div>
        <!-- <div class="col-12 row mx-0 my-1 no-padding btn-group" role="group" aria-label="horario">
            <div class="col-12 lbl-radio">
                <input id="horarioMadr" class="" value="Madr" type="radio" name="horario" {{@Request::get('horario')=='Madr' ? 'checked':''}} hidden autocomplete="off">
                <label for="horarioMadr" class="col-12 btn lbl-horario {{Request::get('horario')=='Madr' ? 'selected' : ''}}" onclick="cambiarHorario('',event, 'lbl-horario')">
                    Todo el día
                </label>
            </div>
            <div class="col-12 col-lg-6 lbl-radio">
                <input id="horarioMadr" class="" value="Madr" type="radio" name="horario" {{@Request::get('horario')=='Madr' ? 'checked':''}} hidden autocomplete="off">
                <label for="horarioMadr" class="col-12 btn lbl-horario {{Request::get('horario')=='Madr' ? 'selected' : ''}}" onclick="cambiarHorario('Madr',event, 'lbl-horario')">
                    Madrugada
                </label>
            </div>
            <div class="col-12 col-lg-6 lbl-radio">
                <input id="horarioMaña" class="" value="Maña" type="radio" name="horario" {{@Request::get('horario')=='Maña' ? 'checked':''}} hidden autocomplete="off">
                <label for="horarioMaña" class="col-12 btn lbl-horario {{Request::get('horario')=='Maña' ? 'selected' : ''}}" onclick="cambiarHorario('Maña',event, 'lbl-horario')">
                    Mañana
                </label>
            </div>
            <div class="col-12 col-lg-6 lbl-radio">
                <input id="horarioTard" class="" value="Tard" type="radio" name="horario" {{@Request::get('horario')=='Tard' ? 'checked':''}} hidden autocomplete="off">
                <label for="horarioTard" class="col-12 btn lbl-horario {{Request::get('horario')=='Tard' ? 'selected' : ''}}" onclick="cambiarHorario('Tard',event, 'lbl-horario')">
                    Tarde
                </label>
            </div>
            <div class="col-12 col-lg-6 lbl-radio">
                <input id="horarioNoch" class="" value="Noch" type="radio" name="horario" {{@Request::get('horario')=='Noch' ? 'checked':''}} hidden autocomplete="off">
                <label for="horarioNoch" class="col-12 btn lbl-horario {{Request::get('horario')=='Noch' ? 'selected' : ''}}" onclick="cambiarHorario('Noch',event, 'lbl-horario')">
                    Noche
                </label>
            </div>
        </div> -->

            <div class="row nopadding mx-0">
                <div class="col-12 row mx-0 my-3 px-4">
                    <button class="btn btn-sm btn-parhi-primary">Filtrar</button>
                </div>
            </div>
    </form>

    <div class="col-12 col-sm-9 row pr-0 pt-5">
        <form id="tbl-corridas" action="{{route('venta.interna.corridasRegresoGuardar')}}" class="px-0 mx-0" onsubmit="return validarFiltros()" method="post">
            @csrf
            <table class="table table-stripe.d table-parhi-osc" style="">
                <thead style="position: sticky;top: 69px;">
                    <tr>
                        <th></th>
                        <th>Servicio</th>
                        <th >Salida</th>
                        <th>Llegada</th>
                        <!-- <th>Origen
                            <br> 
                            Destino</th> -->
                        <th>Tarifa</th>
                        <th>Ocupacion</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    @if(sizeof($corridas)<=0)
                        <tr>
                            <td colspan="8">No se encontraron corridas con los parámetros especificados</td>
                        </tr>
                    @endif
                    @foreach($corridas as $corrida)
                    @if($corrida->aEstado=='B' || $corrida->aEstado=='C' || $corrida->aEstado=='T' || $corrida->aEstado=='L')
                        <tr class="bg-danger text-danger">
                    @elseif($corrida->aEstado=="S")
                        <tr class="bg-warning text-warning">
                    @else
                        <tr id="disp-{{$corrida->disp}}" class="" onclick="seleccionarCorrida(this,'{{$corrida->corrida}}','{{$corrida->disp}}')">
                    @endif
                            <td>{{$corrida->corrida}}
                            -{{($corrida->disp)}}-
                                <br>
                                <sub>
                                    {{$corrida->estadoCorrida}}
                                </sub>
                            </td>
                            <td>
                                <!-- {{($corrida->claseServicio)}} -->
                                <div class="circ-serv bg-clase-{{($corrida->claveServicio)}}" title="{{($corrida->claseServicio)}}"></div>
                            </td>
                            @php
                                $fechoraHoraSalida=\Carbon\Carbon::parse($corrida->fSalida." ".$corrida->hSalida);
                                $fechaHoraLlegada=\Carbon\Carbon::parse($corrida->fLlegada." ".$corrida->hLlegada);
                            @endphp
                            <td class="fecha">
                                <!-- {{$fechoraHoraSalida->format("d/m/Y")}} -->
                                {{$corrida->origen}}
                                <br>
                                <b>
                                    {{$fechoraHoraSalida->format("H:i:s")}}
                                </b>
                            </td>
                            <td class="hora">
                                <!-- {{$fechaHoraLlegada->format("d/m/Y")}} -->
                                {{$corrida->destino}}
                                <br>
                                {{$fechaHoraLlegada->format("H:i:s")}}
                            </td>
                            <td>
                                <button class="btn btn-success btn-samall" onclick="event.preventDefault();getRecorrido({{$corrida->corrida}},{{$corrida->nOrigen}}, {{$corrida->nDestino}})" >
                                    <i class="fa-solid fa-map-location-dot"></i>
                                    Itinerario
                                </button>
                            </td>
                            <td>
                                <span class="ocupados">{{($corrida->boletosVendidos)}}</span>
                                <span class="ocupados">{{($corrida->ocupados)}}</span>
                                /
                                <span class="totalAsientos">{{$corrida->totalAsientos}}</span>
                            </td>
                            <td class="tarifa">$<span>{{number_format($corrida->tarifaBase + $corrida->iva,2)}}</span></td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3 d-flex justify-content-center">
                {!! $corridas->appends(Request::all())->links("pagination::bootstrap-5") !!}
            </div>
            <input id="corr" hidden readonly name="cor" type="" value="{{ Request::get('cor') ?: 0 }}">
            <input id="disp" hidden readonly name="disp" type="" value="{{ Request::get('disp') ?: 0 }}">
            
            <input id="adultos" hidden readonly name="AD" type="" value="{{ $adultos}}">
            <input id="niños" hidden readonly name="NI" type="" value="{{ $niños}}">
            <input id="insen" hidden readonly name="IN" type="" value="{{ $insen}}">
            @if($vacaciones)
            <input id="estudiantes" hidden readonly name="ES" type="" value="{{ $estudiantes}}">
            <input id="profesores" hidden readonly name="MA" type="" value="{{ $profesores}}">
            @endif
            <input id="Continuar" class="btn" type="submit" hidden>
        </form>
        <div class="col-12">
            @if(sizeof($corridas)>0)
            <span class="btn-collap float-right mx-1" title="Continuar">
                <label for="Continuar" class="btn btn-sm btn-parhi-primary">
                    <i class="fa-solid fa-arrow-right"></i>
                    <span>Continuar</span>
                </label>
            </span>
            @endif
            <span class="btn-collap float-right mx-2" title="Eliminar">
                <form action="{{route('venta.interna.cancelarCompra')}}" method="post">
                    @csrf
                    <input id="cancelarCompra" type="submit">
                    <label class="btn btn-sm btn-danger float-right"
                        for="cancelarCompra">
                        <i class="fa-solid fa-ban"></i>
                        <span>Cancelar</span>
                    </label>
                </form>
            </span>
        </div>
    </div>
</div>
</div>
@endsection
