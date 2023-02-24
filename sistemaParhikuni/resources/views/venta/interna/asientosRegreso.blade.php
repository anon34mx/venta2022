@extends('layouts.parhikuni')
@section('content')
@if(session()->has("cmpra_tiempoCompra"))
<div class="tiempoRestanteCont">
    <span class="mx-1">Tiempo para la compra</span>
    <input id="tiempoRestante"
        readonly
        step="3600000" initial="{{session("cmpra_tiempoCompra")*10-time()}}">
</div>
@endif
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
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

@php
$contAuxPasajeros=0;
@endphp
<div class="col-12 row px-0 mx-0">
    <h3>ASIENTOS</h3>
    <div class="col-3">
        <table id="asientos-reg" style="width:200px" class="tbl-diagrama-bus">
            <tr>
                <td>
                    <img alt="" style="" width="34"
                        class="logo-color mx-auto my-3" src="{{ Vite::asset('resources/images/asientos/Conductor.png') }}">
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
                            __
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
                                            <img alt="Ocupado" style=""
                                                class="logo-color mx-auto my-0" src="">
                                                <span>{{$numAsiento}}</span>
                                        </div>
                                    @else
                                        <div id="asiento-{{$numAsiento}}" class="asiento ocupado" numero="{{$numAsiento}}">
                                            <img alt="Ocupado" style=""
                                                class="logo-color mx-auto my-0" src="">
                                                
                                                <span>{{$numAsiento}}x</span>
                                        </div>
                                    @endif
                                    @php
                                        $contAuxAsien=$contAuxAsien+1;
                                    @endphp
                                @else
                                    @if(strpos($col,"T")>0)
                                        <div id="asiento-{{$numAsiento}}" class="asiento regreso" numero="{{$numAsiento}}">
                                            <img alt="Libre" style=""
                                            class="logo-color mx-auto my-0">
                                            <span>{{$numAsiento}}</span>
                                        </div>
                                    @else
                                        <div id="asiento-{{$numAsiento}}" class="asiento regreso" numero="{{$numAsiento}}">
                                            <img alt="Libre" style=""
                                            class="logo-color mx-auto my-0">
                                            <span>{{$numAsiento}}</span>
                                        </div>
                                    @endif
                                @endif
                                <div class="asiento_nmr">{{$col}}</div>
                            @endif
                        </td>
                    @endforeach
                </tr>
                @php
                // break;
                @endphp
            @endforeach
        </table>
    </div>
    <div class="col-9">
        {{$disponibilidad->origen->aNombre." a ".$disponibilidad->destino->aNombre}}
        {{\Carbon\Carbon::createFromFormat("Y-m-d H:i:s", $disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("d/m/Y H:i")}}h
        <form id="pasajerosAsientos" action="{{route('venta.interna.asientosRegreso.apartar')}}" method="post">
            @csrf
            <table id="tbl-datosPasajeros" class="tbl-datosPasajeros">
                <thead>
                    <tr>
                        <th colspan="5">Pasajeros</th>
                    </tr>
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
