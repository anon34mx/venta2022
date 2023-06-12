@extends('layouts.parhikuni')
@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0" style="min-height: 100vh;">
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
<script id="oneTab">
async function oneTab(pagina){
    // Broadcast that you're opening a page.
    localStorage.openpages = await Date.now();
    var onLocalStorageEvent = await function(e){
        if(e.key == "openpages"){
            // otras pestañas
            localStorage.page_available = Date.now();
        }
        if(e.key == "page_available"){
            //esta pestaña
            window.location.replace( route('oneTab', {reason: "Sólo puedes abrir una instancia de la venta"}) );
        }
        if(e.url.match(window.location.origin+pagina)){
        }
    };
    var urlbase=window.location.origin+"/ventaInterna/";
    await window.addEventListener('storage', onLocalStorageEvent, false);
    setTimeout(function(){
        $("#oneTab").remove();
    }, 100);
}
oneTab("/ventaInterna");
</script>



@php
$fechaMayor=false;
$fechaBuscada=\Carbon\Carbon::parse($fechaDeSalida." 00:00:00");
@endphp
<div class="col-12 row px-0 mx-0">
    <form id="filtros" action="#" class="col-sm-3 px-0 py-0 mx-0 my-0 pt-4" target="_self">
        <div class="linea-inf-bnco px-3">
            <h3 class="titleWithAnchor" id="x">Filtros</h3>
        </div>


        <div class="col-12 row mx-0 linea-inf-bnco py-1 gpo-btns">
            <div class="col-12 col-sm-6 row my-1 mx-0 px-sm-0">
                <select class="form-control form-control-sm px-1 px-md-2 text-center mx-auto" name="origen" id="origen" onChange="cargarDestinos(this.value,false)">
                    <option value="" >Origen</option>
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
                            >{{@$key["aNombre"]}}</option>
                        @endforeach
                </select>
            </div>
            <div class="col-12 col-sm-6 row my-1 mx-0 px-sm-0">
                <select class="form-control form-control-sm px-1 px-md-2 text-center mx-auto" name="destino" id="destino">
                    <option value="" >Destino</option>
                    @foreach($oficinas as $key)
                        <option value="{{$key['nNumero']}}" {{@$key['nNumero']==@$destino->nNumero ? "selected": "" }}>{{$key["aNombre"]}}</option>
                    @endforeach
                </select>
            </div>
        </div>


        <div class="col-12 row mx-0 my-0 px-0 px-md-2 linea-inf-bnco py-1">
            <!-- <div class="">Tipo de viaje</div> -->
            <div class="px-0 col-6 col-md-6 lbl-radio px-1">
                <div class="float-right">
                    <input class="tipoDeViaje " type="radio" id="viajeSencillo" name="tipoDeViaje" value="sencillo"
                        @if (Request::get('tipoDeViaje')=='sencillo' || !Request::has("tipoDeViaje"))
                        {{"checked"}}
                        @endif
                        >
                    <label for="viajeSencillo" class="">sencillo</label>
                </div>
            </div>
            <div class="px-0 col-6 col-md-6 lbl-radio px-1">
                <div class="float-left">
                    <input class="tipoDeViaje" type="radio" id="viajeRedondo" name="tipoDeViaje" value="redondo" {{Request::get('tipoDeViaje')=='redondo' ? 'checked':''}}>
                    <label for="viajeRedondo" class="">redondo</label>
                </div>
            </div>
        </div>


        @if(Auth::user()->hasRole('Admin'))
        <div class="col-12 col-md-12 row mx-0 px-0 px-md-2 linea-inf-bnco py-1">
            <div class="float-left">
                <div class="px-0 col-12">
                    <input type="text" class="form-control use-inputmask" name="corrida" value="{{Request::get('corrida')}}"
                    data-inputmask-regex="[0-9]{1,}" placeholder="Corrida" autocomplete="off">
                </div>
            </div>
        </div>
        @endif
        

        <div class="col-12 px-0 mx-0 row linea-inf-bnco gpo-btns">
            <div class="col-12">Fecha</div>
            <div class="col-6 col-sm-12 col-lg-6 row mx-0 my-1 gpo-btns pl-3 pr-3 pl-lg-3 pr-lg-0">
                <input class="form-control px-1 fechaSalida mirrorInput" type="date" target="#fechaSalida"
                    min="{{date('Y-m-d')}}" name="fechaDeSalida" value="{{$fechaDeSalida}}" >
            </div>
            <div class="col-6 col-sm-12 col-lg-6 row mx-0 my-1 gpo-btns pl-3 pr-3 pl-lg-0 pr-lg-3 selectReg {{@Request::get('tipoDeViaje')=='redondo' ? '' : 'hidden'}}">
                <input class="form-control px-1 fechaRegreso mirrorInput" type="date" target="#fechaRegreso"
                    min="{{date('Y-m-d')}}" name="fechaRegreso" value="{{ Request::get('fechaRegreso')}}">
            </div>
        </div>

        
        <div class="col-12 row mx-0 px-0 px-md-2 linea-inf-bnco">
            <div class="col-6 col-sm-12 custom-control custom-checkbox pl-4 mx-auto">
                <input class="form-check-input" id="usarPromocionF" name="usarPromocion" type="checkbox" target="usarPromocion" {{ Request::get('usarPromocion') ? "checked": ""}}>
                <label class="form-check-label" for="usarPromocionF">Utilizar promoción</label>
            </div>
        </div>
        <!-- PASAJEROS -->
        <div class="linea-inf-bnco">
            <div class="col-12 row mx-0 my-2 px-1 px-md-2 pasajeros ">
                <div class="col-2 mx-0 px-0">
                    <button id="adultos+" class="cantidadPasajeros btn btn-sm btn-warning" value="+">+</button>
                </div>
                <div class="col-8 mx-0 px-0">
                    <input readonly id="inpt-adultos" name="adultos" class="form-control contadorPasajeros col-11 px-1 px-md-1 mx-auto" type="text" value="{{$adultos}}" step="1" min="0" max="10">
                    <label for="inpt-adultos" style="
                        pointer-events:none;
                        color:black;
                        position: absolute;
                        top: 7px;
                        left: 32px;
                    ">Adultos</label>
                </div>
                <div class="col-2 mx-0 px-0">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary float-right" value="-">-</button>
                </div>
            </div>
            <div class="col-12 row mx-0 my-2 px-1 px-md-2 pasajeros">
                <div class="col-2 mx-0 px-0">
                    <button class="cantidadPasajeros btn btn-sm btn-warning" value="+">+</button>
                </div>
                <div class="col-8 mx-0 px-0">
                    <input readonly id="inpt-niños" name="niños" class="form-control contadorPasajeros col-11 px-1 px-md-1 mx-auto" type="text" value="{{$niños}}" step="1" min="0" max="10">
                    <label for="inpt-adultos" style="
                        pointer-events:none;
                        color:black;
                        position: absolute;
                        top: 7px;
                        left: 32px;
                    ">Menores</label>
                </div>
                <div class="col-2 mx-0 px-0">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary float-right" value="-">-</button>
                </div>
            </div>
            <div class="col-12 row mx-0 my-2 px-1 px-md-2 pasajeros">
                <div class="col-2 mx-0 px-0">
                    <button class="cantidadPasajeros btn btn-sm btn-warning" value="+">+</button>
                </div>
                <div class="col-8 mx-0 px-0">
                    <input readonly id="inpt-insen" name="insen" class="form-control contadorPasajeros col-11 px-1 px-md-1 mx-auto" type="text" value="{{$insen}}" step="1" min="0" max="10">
                    <label for="inpt-adultos" style="
                        pointer-events:none;
                        color:black;
                        position: absolute;
                        top: 7px;
                        left: 32px;
                    ">Insen</label>
                </div>
                <div class="col-2 mx-0 px-0">
                    <button class="cantidadPasajeros btn btn-sm btn-parhi-primary float-right" value="-">-</button>
                </div>
            </div>
            @if($vacaciones==true)
                <div class="col-12 row mx-0 my-2 px-1 px-md-2 pasajeros">
                    <div class="col-2 mx-0 px-0">
                        <button class="cantidadPasajeros btn btn-sm btn-warning" value="+">+</button>
                    </div>
                    <div class="col-8 mx-0 px-0">
                        <input readonly id="inpt-estudiantes" name="estudiantes" class="form-control contadorPasajeros col-11 px-1 px-md-1 mx-auto" type="text" value="{{$estudiantes}}" step="1" min="0" max="10">
                        <label for="inpt-adultos" style="
                            pointer-events:none;
                            color:black;
                            position: absolute;
                            top: 7px;
                            left: 32px;
                        ">Estudiantes</label>
                    </div>
                    <div class="col-2 mx-0 px-0">
                        <button class="cantidadPasajeros btn btn-sm btn-parhi-primary float-right" value="-">-</button>
                    </div>
                </div>
                <div class="col-12 row mx-0 my-2 px-1 px-md-2 pasajeros">
                    <div class="col-2 mx-0 px-0">
                        <button class="cantidadPasajeros btn btn-sm btn-warning" value="+">+</button>
                    </div>
                    <div class="col-8 mx-0 px-0">
                        <input readonly id="inpt-profesores" name="profesores" class="form-control contadorPasajeros col-11 px-1 px-md-1 mx-auto" type="text" value="{{$profesores}}" step="1" min="0" max="10">
                        <label for="inpt-adultos" style="
                            pointer-events:none;
                            color:black;
                            position: absolute;
                            top: 7px;
                            left: 32px;
                        ">Profesores</label>
                    </div>
                    <div class="col-2 mx-0 px-0">
                        <button class="cantidadPasajeros btn btn-sm btn-parhi-primary float-right" value="-">-</button>
                    </div>
                </div>
            @endif
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
                <!-- <img id="busH" src="{{ Vite::asset('resources/images/bus_selec.png') }}" alt=""
                    style="width: 60px;
                        position: absolute;
                        bottom: 6px;
                        left: {{@Request::get('inptbusH') ?: '100%'}};
                        display: block;
                        z-index: 5;
                        pointer-events: none;
                        transition:0.5s;"> -->
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

        <div class="col-12 row nopadding mx-0 px-0 px-md-2">
            <div class="col-12 col-md-6 row mx-0 my-2">
                <button class="btn btn-sm btn-parhi-primary" target="_self">Filtrar</button>
            </div>
            <div class="col-12 col-md-6 row mx-0 my-2">
                <input class="btn btn-sm btn-warning" type="button" onclick="quitarFiltros()" value="Quitar filtros">
            </div>
        </div>
        <!-- </div> -->
    </form>

    <!-- <div class="col-12 col-sm-8 row pr-0"></div> -->
    <div class="col-sm-9 px-0 mx-0">
        <div class="row px-0 mx-0 ">
            <div class="col-12 px-0 mx-0">
                <div class="col-10 row float-right mx-0 px-0 "> <!--  -->
                    <div class="text-center py-1 col-3 pasosDeCompra-selected">
                        <b>Viaje</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Asientos</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Confirmación</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Pago</b>
                    </div>
                </div>
            </div>
            <div class="row col-12 mx-0 px-0 bg-gris">
                <div class="col-2 mx-auto linea-inf-EX">
                    <img src="{{ Vite::asset('resources/images/servicios/EX.png') }}" alt="">
                </div>
                <div class="col-2 mx-auto linea-inf-PC">
                    <img src="{{ Vite::asset('resources/images/servicios/PC.png') }}" alt="">
                </div>
                <div class="col-2 mx-auto linea-inf-UL">
                    <img src="{{ Vite::asset('resources/images/servicios/UL.png') }}" alt="">
                </div>
                <div class="col-2 mx-auto linea-inf-PL">
                    <img src="{{ Vite::asset('resources/images/servicios/PL.png') }}" alt="">
                </div>
                <div class="col-2 mx-auto linea-inf-BC">
                    <img src="{{ Vite::asset('resources/images/servicios/BC.png') }}" alt="">
                </div>
            </div>
        </div>
            <form id="tbl-corridas" action="{{route('venta.interna.guardarFiltros')}}" class="px-0" onsubmit="return validarFiltros()" method="post" target="_self">
                @csrf
                <div class="">
                    <table class="table table-striped table-parhi-osc" style="">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>Salida</th>
                                <th>Llegada</th>
                                <th>Escalas</th>
                                <th>Ocupacion</th>
                                <th>Tarifa</th>
                            </tr>
                        </thead>
                        <tbody>

                            @for($i=0; $i<0; $i++)
                                <tr>
                                    <td>00988</td>
                                    <td>
                                        <div class="circ-serv bg-clase-PL"></div>
                                    </td>
                                    <td class="origen">
                                        MORELIA
                                        <br>
                                        14:00h
                                    </td>
                                    <td>
                                        URUAPAN
                                        <br>
                                        16:00h
                                    </td>
                                    <td>Escalas</td>
                                    <td>08/15</td>
                                    <td>
                                        <div class="col-12">
                                            $000.00
                                        </div>
                                        <sub class="col-12 mt-2">
                                            $000.00
                                        </sub>
                                    </td>
                                </tr>
                            @endfor
                            @if(sizeof($corridas)<=0)
                                <tr>
                                    <td colspan="8">No se encontraron corridas con los parámetros especificados</td>
                                </tr>
                            @endif
                            @foreach($corridas as $corrida)


                            @php
                                $fechoraHoraSalida=\Carbon\Carbon::parse($corrida->fSalida." ".$corrida->hSalida);
                                $fechaHoraLlegada=\Carbon\Carbon::parse($corrida->fLlegada." ".$corrida->hLlegada);
                                if($fechoraHoraSalida->gt(\Carbon\Carbon::now()) && $fechaMayor==false && !$fechaBuscada->gte(\Carbon\Carbon::now()) && $page<=1){ //&& !$fechaBuscada->gte(\Carbon\Carbon::now())
                                    @endphp
                                    <tr><td colspan="7"><div class="py-2 bg-info rounded">== Más corridas ==</div></td></tr>
                                    @php
                                    $fechaMayor=true;
                                }
                            @endphp

                            @php
                                $auxEdo="";
                                if($corrida->estadoCorrida=="D"){
                                    @endphp
                                    <tr id="disp-{{$corrida->disp}}" class="" onclick="seleccionarCorrida(this,'{{$corrida->corrida}}','{{$corrida->disp}}')">
                                        @php
                                }else{
                                    $auxEdo="text-light bg-secondary";
                                    @endphp
                                    <tr class="bg-danger">
                                    @php
                                }

                            @endphp
                                    <td class="py-2 {{$auxEdo}}">
                                        {{$corrida->corrida}}-{{($corrida->disp)}}
                                        <br>
                                        <div class="circ-serv bg-clase-{{($corrida->claveServicio)}}" title="{{($corrida->claseServicio)}}"></div>
                                        {{($corrida->claseServicio)}}
                                        <br>
                                        <sub class="mt-1">
                                            <br>
                                            {{$corrida->edoUwu}}
                                        </sub>
                                    </td>
                                    <!-- <td>
                                        <div class="circ-serv bg-clase-{{($corrida->claveServicio)}}" title="{{($corrida->claseServicio)}}"></div>
                                    </td> -->

                                    <td class="py-2 {{$auxEdo}} origen">
                                        <b>
                                            {{$corrida->origen}}
                                            <br>
                                            {{$fechoraHoraSalida->format("H:i:s")}}
                                        </b>
                                        <br>
                                        <sub>
                                            {{$fechoraHoraSalida->format("d/m/Y")}}
                                        </sub>
                                    </td>
                                    <td class="py-2 {{$auxEdo}} destino">
                                        {{$corrida->destino}}
                                        <br>
                                        {{$fechaHoraLlegada->format("H:i:s")}}
                                        <br>
                                        <sub>
                                            {{$fechoraHoraSalida->format("d/m/Y")}}
                                        </sub>
                                    </td>
                                    <td class="py-2 {{$auxEdo}}">
                                        @if($auxEdo=='')
                                            <button class="btn btn-success btn-samall"
                                                onclick="event.preventDefault();getRecorrido({{$corrida->corrida}},{{$corrida->nOrigen}}, {{$corrida->nDestino}})" >
                                                <i class="fa-solid fa-map-location-dot"></i>
                                                Itinerario
                                            </button>
                                        @endif
                                    </td>
                                    <td class="py-2 {{$auxEdo}}"
                                        @php 
                                            if($corrida->totalAsientos - $corrida->ocupados <= 5){
                                                echo 'class="text-danger"';
                                            }elseif($corrida->totalAsientos - $corrida->ocupados <= 10){
                                                echo 'class="text-warning"';
                                            }else{
                                                echo 'class="text-success"';
                                            }
                                        @endphp
                                        >
                                        <span class="ocupados">{{($corrida->ocupados)}}</span>
                                        /
                                        <span class="totalAsientos">{{$corrida->totalAsientos}}</span>
                                    </td>
                                    <td class="py-2 tarifa {{$auxEdo}}">$<span>{{number_format($corrida->tarifaBase + $corrida->iva,2)}}</span></td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <div class="mt-3 d-flex justify-content-center">
                    {!! $corridas->appends(Request::all())->links("pagination::bootstrap-5") !!}
                </div>
                <input id="corr" hidden name="cor" type="" value="{{ Request::get('cor') ?: 0 }}">
                <input id="disp" hidden name="disp" type="" value="{{ Request::get('disp') ?: 0 }}">
                <input id="adultos" hidden name="AD" type="" value="{{ Request::get('adultos') ?: 0 }}">
                <input id="niños" hidden name="NI" type="" value="{{ Request::get('niños') ?: 0 }}">
                <input id="insen" hidden name="IN" type="" value="{{ Request::get('insen') ?: 0 }}">
                @if($vacaciones)
                <input id="estudiantes" hidden name="ES" type="" value="{{ Request::get('estudiantes') ?: 0 }}">
                <input id="profesores" hidden name="MA" type="" value="{{ Request::get('profesores') ?: 0 }}">
                @endif
                <input id="tipoDeViaje" hidden name="tipoDeViaje" type="checkbox" {{ @Request::get('tipoDeViaje')=='redondo' ? 'checked': '' }}>
                <label hidden for="tipoDeViaje">Viaje redondo</label>
                <input hidden class="form-check-input" id="usarPromocion" name="usarPromocion" type="checkbox"
                {{ Request::get('usarPromocion') ? 'checked': ''}}>
                <label hidden for="usarPromocion">Usar promocion</label>
                <input id="fechaSalida" hidden name="fechaSalida" type="date" readonly value="{{Request::get('fechaDeSalida')}}"}}>
                <input id="fechaRegreso" hidden name="fechaRegreso" type="date" readonly value="{{Request::get('fechaRegreso')}}"}}>
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
