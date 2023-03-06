@extends('layouts.parhikuni')
@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
    @include('venta.interna.tiempo&alertas',[
        "rest" => "/ventaInterna"
        ])
<div class="col-12 row px-0 mx-0">
    <form action="#" class="col-12 col-sm-3 col-xl-3 row px-0 mx-0 " style="height: fit-content;display: block;position: sticky;top: 70px;">
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Filtros</a>
        </h3>
        <div class="col-12 col-md-12 row mx-0 my-1">
            <div class="">Tipo de viaje</div>
            <div class="px-0 col-12 col-md-6 lbl-radio px-1">
                <input class="tipoDeViaje" type="radio" id="viajeSencillo" name="tipoDeViaje" value="sencillo"
                    @if (Request::get('tipoDeViaje')=='sencillo' || !Request::has("tipoDeViaje"))
                    {{"checked"}}
                    @endif
                    >
                <label for="viajeSencillo" class="btn col-12 px-1">sencillo</label>
            </div>
            <div class="px-0 col-12 col-md-6 lbl-radio px-1">
                <input class="tipoDeViaje" type="radio" id="viajeRedondo" name="tipoDeViaje" value="redondo" {{Request::get('tipoDeViaje')=='redondo' ? 'checked':''}}>
                <label for="viajeRedondo" class="btn col-12 px-1">redondo</label>
            </div>
        </div>
        @if(Auth::user()->hasRole('Admin'))
        <div class="col-12 col-md-12 row mx-0 my-1">
            <div class="">Corrida</div>
            <div class="px-0 col-12">
                <input type="text" class="form-control use-inputmask" name="corrida" value="{{Request::get('corrida')}}"
                data-inputmask-regex="[0-9]{1,}" placeholder="#" autocomplete="off">
            </div>
        </div>
        @endif
        <div class="row col-12 mx-0 px-2">
            <div class="col-12 col-sm-6 row mx-0 px-1 my-1">
                <div class="">Origen</div>
                <div class="px-0 col-12">
                    <select class="form-control" name="origen" id="origen" onChange="cargarDestinos(this.value,false)">
                        <option value="" >Seleccione Origen</option>
                        <option value="todos" 
                            @if(request()->get('origen')=="todos" )
                                {{"selected"}}
                            @endif
                        >Todos</option>
                        @php
                        $origenEncontrado = false;
                        @endphp
                        @foreach($oficinas as $key)
                            <option value="{{$key['nNumero']}}"
                                @if(request()->get('origen')!=null)
                                   @if(request()->get('origen')==$key['nNumero'])
                                        {{"selected"}}
                                   @endif
                                @else
                                   @if($key['nNumero']==session("oficinaid"))
                                        {{"selected"}}
                                   @endif
                                @endif
                            >{{@$key["origen"]}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 row mx-0 px-1 my-1">
                <div class="">Destino</div>
                <div class="px-0 col-12">
                    <select class="form-control" name="destino" id="destino">
                        <option value="" >Seleccione Destino</option>
                        @foreach($oficinas as $key)
                            <option value="{{$key['nNumero']}}" {{@$key['nNumero']==@$destino->nNumero ? "selected": "" }}>{{@$key["origen"]}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
        </div>
        <div class="col-12 px-0 mx-0 row">
            <div class="col-12 col-lg-6 row mx-0 my-1">
                <div class="">Fecha</div>
                <div class="px-0 col-12">
                    <input class="form-control px-2 fechaSalida" type="date" min="{{date('Y-m-d')}}" name="fechaDeSalida" value="{{$fechaDeSalida}}">
                </div>
            </div>
            <div class="col-12 col-lg-6 row mx-0 my-1">
                <div class="">Regreso</div>
                <div class="px-0 col-12">
                    <input class="form-control px-2 fechaRegreso" type="date" min="{{date('Y-m-d')}}" name="fechaDeSalida" value="{{$fechaDeSalida}}">
                </div>
            </div>
        </div>
        <div class="col-6 col-sm-12 row mx-0 my-1">
            <div class="custom-control custom-checkbox pl-4">
                <input class="form-check-input" id="usarPromocionF" name="usarPromocion" type="checkbox" target="usarPromocion" {{ Request::get('usarPromocion') ? "checked": ""}}>
                <label class="form-check-label" for="usarPromocionF">Utilizar promoción</label>
            </div>
        </div>
        <!-- PASAJEROS -->
        <div class="col-12 row mx-0 my-1">
            <div class="col-2 mx-0 px-0">
                <button id="adultos+" class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="+">+</button>
            </div>
            <div class="col-8 mx-0 px-2">
                <input readonly id="inpt-adultos" name="adultos" class="form-control contadorPasajeros col-12 px-2" type="text" value="{{$adultos}}" step="1" min="0" max="10">
                <label for="inpt-adultos" style="
                    position: absolute;
                    top: 7px;
                    left: 36px;
                ">Adultos</label>
            </div>
            <div class="col-2 mx-0 px-0">
                <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="-">-</button>
            </div>
        </div>
        <div class="col-12 row mx-0 my-1">
            <div class="col-2 mx-0 px-0">
                <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="+">+</button>
            </div>
            <div class="col-8 mx-0 px-2">
                <input readonly id="inpt-niños" name="niños" class="form-control contadorPasajeros col-12 px-2" type="text" value="{{$niños}}" step="1" min="0" max="10">
                <label for="inpt-adultos" style="
                    position: absolute;
                    top: 7px;
                    left: 36px;
                ">Menores</label>
            </div>
            <div class="col-2 mx-0 px-0">
                <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="-">-</button>
            </div>
        </div>
        <div class="col-12 row mx-0 my-1">
            <div class="col-2 mx-0 px-0">
                <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="+">+</button>
            </div>
            <div class="col-8 mx-0 px-2">
                <input readonly id="inpt-insen" name="insen" class="form-control contadorPasajeros col-12 px-2" type="text" value="{{$insen}}" step="1" min="0" max="10">
                <label for="inpt-adultos" style="
                    position: absolute;
                    top: 7px;
                    left: 36px;
                ">Insen</label>
            </div>
            <div class="col-2 mx-0 px-0">
                <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="-">-</button>
            </div>
        </div>
        @if(false==true)
            <div class="col-6 col-sm-12 row mx-0 my-1">
                <div class="col-12">Estudiantes</div>
                <div class="col-2">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="+">+</button>
                </div>
                <div class="col-8 mx-0 px-0">
                    <input readonly id="inpt-estudiantes" name="estudiantes" class="form-control contadorPasajeros col-12 px-2" type="text" value="{{$estudiantes}}" step="1" min="0" max="10">
                </div>
                <div class="col-2">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="-">-</button>
                </div>
            </div>
            <div class="col-6 col-sm-12 row mx-0 my-1">
                <div class="col-12">Profesores</div>
                <div class="col-3">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="+">+</button>
                </div>
                <div class="col-6">
                    <input readonly id="inpt-profesores" name="profesores" class="form-control contadorPasajeros col-12" type="text" value="{{$profesores}}" step="1" min="0" max="10">
                </div>
                <div class="col-3">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary" value="-">-</button>
                </div>
            </div>
        @endif
        <div class="col-6 col-sm-12 row mx-0 my-1">
            <div class="">Horario</div>
            <div class="px-0 col-12">
                <input class="form-control" hidden type="time" id="hInicio" name="hInicio" value="{{@Request::get('hInicio')}}" >
                <input class="form-control" hidden type="time" id="hFin" name="hFin" value="{{@Request::get('hFin')}}" >
            </div>
        </div>
        <div class="col-12 row mx-0 my-1 no-padding btn-group" role="group" aria-label="horario">
            <div class="col-12 lbl-radio">
                <input id="horarioCompleto" class="" value="Completo" type="radio" name="horario" {{@Request::get('horario')=='Completo' ? 'checked':''}} hidden autocomplete="off">
                <label for="horarioCompleto" class="col-12 btn lbl-horario {{Request::get('horario')=='Completo' ? 'selected' : ''}}" onclick="cambiarHorario('completo',event, 'lbl-horario')">
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
        </div>

            <div class="row nopadding mx-0">
                <div class="col-6 row mx-0 my-3">
                    <button class="btn btn-sm btn-parhi-primary">Filtrar</button>
                </div>
                <div class="col-6 row mx-0 my-3">
                    <input class="btn btn-sm btn-warning" type="button" onclick="quitarFiltros()" value="Quitar filtros">
                </div>
            </div>
        <!-- </div> -->
    </form>

    <div class="col-12 col-sm-9 row pr-0">
        <form id="tbl-corridas" action="{{route('venta.interna.guardarFiltros')}}" class="pr-0" onsubmit="return validarFiltros()" method="post">
            @csrf
            <table class="table table-stripe.d table-parhi" style="">
                <thead style="position: sticky;top: 69px;">
                    <tr>
                        <th></th>
                        <th>Servicio</th>
                        <th >Salida</th>
                        <th>Llegada</th>
                        <th>Origen
                            <br> 
                            Destino</th>
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
                    @if($corrida->estadoCorrida=='B' || $corrida->estadoCorrida=='C' || $corrida->estadoCorrida=='T' || $corrida->estadoCorrida=='L')
                        <tr class="bg-danger text-danger">
                    @elseif($corrida->estadoCorrida=="S" || $corrida->estadoCorrida=="R")
                        <tr class="bg-warning text-warning">
                    @else
                        <tr id="disp-{{$corrida->disp}}" class="" onclick="seleccionarCorrida(this,'{{$corrida->corrida}}','{{$corrida->disp}}')">
                    @endif
                            <td>{{$corrida->corrida}}
                            -{{($corrida->disp)}}-
                                <br>
                                {{$corrida->estadoCorrida}}
                            </td>
                            <td>{{($corrida->claseServicio)}}</td>
                            @php
                                $fechoraHoraSalida=\Carbon\Carbon::parse($corrida->fSalida." ".$corrida->hSalida);
                                $fechaHoraLlegada=\Carbon\Carbon::parse($corrida->fLlegada." ".$corrida->hLlegada);
                            @endphp
                            <td class="fecha">
                                {{$fechoraHoraSalida->format("d/m/Y")}}
                                <br>
                                <b>
                                    {{$fechoraHoraSalida->format("H:i:s")}}
                                </b>
                            </td>
                            <td class="hora">
                                {{$fechaHoraLlegada->format("d/m/Y")}}
                                <br>
                                {{$fechaHoraLlegada->format("H:i:s")}}
                            </td>
                            <td>{{$corrida->origen}}<br>{{$corrida->destino}}</td>
                            <td class="tarifa">$<span>{{number_format($corrida->tarifaBase + $corrida->iva,2)}}</span></td>
                            <td>
                                <span class="ocupados">{{($corrida->boletosVendidos)}}</span>
                                <span class="ocupados">{{($corrida->ocupados)}}</span>
                                /
                                <span class="totalAsientos">{{$corrida->totalAsientos}}</span>
                            </td>
                            <td>
                                <button class="btn btn-success btn-samall" onclick="event.preventDefault();getRecorrido({{$corrida->corrida}},{{$corrida->nOrigen}}, {{$corrida->nDestino}})" >
                                    <i class="fa-solid fa-map-location-dot"></i>
                                    Itinerario
                                </button>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <div class="mt-3 d-flex justify-content-center">
                {!! $corridas->appends(Request::all())->links("pagination::bootstrap-5") !!}
            </div>
            <input id="corr" hidden name="cor" type="" value="{{ Request::get('cor') ?: 0 }}">
            <input id="disp" hidden name="disp" type="" value="{{ Request::get('disp') ?: 0 }}">
            <input id="adultos" hidden name="AD" type="" value="{{ Request::get('adultos') ?: 0 }}">
            <input id="niños" hidden name="NI" type="" value="{{ Request::get('niños') ?: 0 }}">
            <input id="insen" hidden name="IN" type="" value="{{ Request::get('insen') ?: 0 }}">
            <input id="tipoDeViaje" hidden name="tipoDeViaje" type="checkbox"
                {{Request::get("tipoDeViaje")=="redondo" ? 'checked':''}}
                >
            <input hidden class="form-check-input" id="usarPromocion" name="usarPromocion" type="checkbox"
                {{ Request::get('usarPromocion') ? 'checked': ''}}>
            <div class="col-12">
                @if(sizeof($corridas)>0)
                <span class="btn-collap float-right mx-1" title="Continuar">
                    <label for="Continuar" class="btn btn-sm btn-parhi-primary">
                        <i class="fa-solid fa-arrow-right"></i>
                        <span>Continuar</span>
                    </label>
                    <input id="Continuar" class="btn" type="submit">
                </span>
                @endif
            </div>
        </form>
    </div>
</div>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="$('#exampleModalLong').modal('hide');">Cerrar</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>

@endsection
