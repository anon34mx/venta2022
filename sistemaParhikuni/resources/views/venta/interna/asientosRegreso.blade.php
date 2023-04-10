@extends('layouts.parhikuni')
@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
@php
$contAuxPasajeros=0;
@endphp
<div class="col-12 row px-0 mx-0">
    <div class="col-12 row mx-0 px-0">
        <div class="col-3 row px-0 mx-0">
            <form id="filtros" action="#" class="col-12 px-2 py-3 mx-0 my-0 pt-4" target="_self">
                @include('venta.interna.tiempo&alertas',[
                    "rest" => "/ventaInterna"
                ])
                <div class="col-12 linea-inf-bnco">
                    Detalles del viaje ✅
                </div>
                <div class="col-12 px-0 mx-0">
                    <input class="input-trans-osc text-center col-12 px-0" type="date" value="{{session('reg_fecha')}}" readonly style="display: inline-grid;">
                </div>
                <div class="linea-inf-bnco">
                    <div class="col-12 row mx-0 px-0">
                        <div class="col-12 col-md-6 text-center">
                            {{session("reg_origenNombre")}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{($disponibilidad->hSalida)}}
                        </div>
                    </div>
                    <div class="linea-recorrido my-2" style="
                        display: block;
                        position: relative;
                        width: 1px;
                        height: 50px;
                        border: 2px solid white !important;
                        left: 50%;
                        top: 0%;
                        ">
                        <div class="inicio"></div>
                        <div class="fin"></div>
                    </div>
                    <div class="col-12 row mx-0 px-0 ">
                        <div class="col-12 col-md-6 text-center">
                            {{session("reg_destinoNombre")}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{($disponibilidad->hLlegada)}}
                        </div>
                    </div>
                </div>
                <div class="linea-inf-bnco">
                    <div>Asientos</div>
                </div>
            </form>
        </div>


        <div class="col-9 row px-0 mx-0">
            <div class="col-12 px-0 mx-0">
                <div class="col-10 row float-right mx-0 px-0 "> <!--  -->
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Viaje</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra-selected">
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
                <b>Selección de asientos (regreso)</b>
            </div>
<!--  -->

            <div class="col-12 col-sm-6 col-md-5 col-lg-4 col-xl-3 mx-0">
                <table id="asientos-reg" class="tbl-diagrama-bus mx-auto mt-2" style="
                    max-width: 300px;
                    margin: auto;
                    ">
                    <tr>
                        <td>
                            <img alt="" style="" width="34"
                                class="logo-color mx-auto my-0" src="{{ Vite::asset('resources/images/asientos/Conductor.png') }}">
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    @php
                    $contAuxAsien=0;
                    $sizeAsientos=sizeof($asientosOcupados);
                    @endphp
                    @foreach(explode("|" ,$cordis->autobus->distribucionAsientos->aDistribucion) as $row)
                        <tr>
                            @foreach(explode(",",$row) as $col)
                                <td>
                                    @if($col=="00")
                                        <div class="pasillo"></div>
                                    @elseif($col=="PU")
                                        <div class="asiento_nmr">[PU]</div>
                                    @elseif($col=="BH")
                                        <div class="asiento_nmr">{{$col}}</div>
                                    @elseif($col=="BM")
                                        <div class="asiento_nmr">{{$col}}</div>
                                    @elseif($col=="CA")
                                        <div class="asiento_nmr">{{$col}}</div>
                                    @else
                                        @php
                                        $numAsiento=substr($col,0,2);
                                        $ocupado=0;
            
                                        @endphp
                                        @if( @$asientosOcupados[$numAsiento])
                                            @if(strpos($col,"T")>0)
                                                <div id="asiento-{{$numAsiento}}" class="asiento tv  ocupado" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}</span>
                                                    <br>
                                                    <sub>tv</sub>
                                                </div>
                                            @else
                                                <div id="asiento-{{$numAsiento}}" class="asiento ocupado" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}x</span>
                                                    <br>
                                                    <sub>_</sub>
                                                </div>
                                            @endif
                                            @php
                                                $contAuxAsien=$contAuxAsien+1;
                                            @endphp
                                        @else
                                            @if(strpos($col,"T")>0)
                                                <div id="asiento-{{$numAsiento}}" class="asiento regreso" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}</span>
                                                    <br>
                                                    <sub>tv</sub>
                                                </div>
                                            @else
                                                <div id="asiento-{{$numAsiento}}" class="asiento regreso" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}</span>
                                                    <br>
                                                    <sub>_</sub>
                                                </div>
                                            @endif
                                        @endif
                                    @endif
                                </td>
                            @endforeach
                        </tr>
                        @php
                        // break;
                        @endphp
                        @endforeach
                        <tr>
                            <td colspan="5">clase</td>
                        </tr>
                        <tr>
                            <td colspan="5">serbisios</td>
                        </tr>
                </table>
            </div>
            <div class="col-12 col-sm-6 col-md-7 col-lg-8 col-xl-8 mx-0 mx-xl-auto px-0">
                <div class="col-12 mx-0 px-0 row">
                    <div class="col-10 col-md-4 row px-0 mx-auto mx-md-0 border border-secondary">
                        <div class="col-12 text-center ocupado">ocupado</div>
                    </div>
                    <div class="col-10 col-md-4 row px-0 mx-auto mx-md-0 border border-secondary">
                        <div class="col-12 text-center libre">libre</div>
                    </div>
                    <div class="col-10 col-md-4 row px-0 mx-auto mx-md-0 border border-secondary">
                        <div class="col-12 text-center apartado">seleccionado</div>
                    </div>
        
                </div>
                <form id="pasajerosAsientos" action="{{route('venta.interna.asientosRegreso.apartar')}}" method="post">
                    @csrf
                    <table id="tbl-datosPasajeros" class="tbl-datosPasajeros">
                        <thead>
                            <tr>
                                <th class="col-1">Tipo</th>
                                <th class="col-1">Asiento</th>
                                <th class="col-3">Nombre</th>
                                <th class="col-1"></th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <div class="col-12">
                        <button id="btn-apartar" hidden>Apartar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-12 justify-content-center">
        <span class="btn-collap float-right mx-2" title="Guardar">
            <label class="btn btn-sm btn-parhi-primary"
                for="btn-apartar" tabindex="9999">
                <i class="fa-solid fa-book"></i>
                <span>Apartar</span>
            </label>
            <input id="guardar" type="submit"
            class="btn">
        </span>

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

<table id="pasajeros" class="hidden">
@for($i=0; $i<sizeof($pasajeros); $i++)
    <tr pasajero="{{$i}}">
        <td class="id">{{$i}}</td>
        <td class="pasajero">
            <span>{{($pasajeros[$i]->pasajero)}}</span>
        </td>
        <td class="tipoID">
            <span>{{($pasajeros[$i]->tipoID)}}</span>
        </td>
        <td class="tipo">
            <span>{{($pasajeros[$i]->tipo)}}</span>
        </td>
    </tr>
@endfor
</table>
@endsection
<div id="tipoNombrePasajeroCont" class="tipoNombrePasajero"
    style="
    background: #60606029;
    backdrop-filter: blur(1px);
    position: fixed;
    top: 70px;
    left: 0px;
    height: 100vh;
    width: 100vw;
    display:none;
    z-index: 1;">
    <div class="" style="
    width: 230px;
    height: 150px;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    ">
        <select name="" id="tipoNombrePasajero" style="" class="form-control">
            <option value="">Seleccione</option>
            @for($i=0; $i<sizeof($pasajeros); $i++)
                <option value="{{$i}}">
                    {{($pasajeros[$i]->tipo)}} - {{($pasajeros[$i]->pasajero)}}
                </option>
            @endfor
        </select>
        <br>
        <button onclick="cancelSelecAsientoReg();"
            class="btn btn-sm btn-parhi-primary float-right">cancelar</button>
    </div>
</div>
