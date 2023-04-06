@extends('layouts.parhikuni')
@section('content')
@php
$totalReg=0;
@endphp
<div class="col-12 px-0 mx-auto">
    <div class="col-12 row px-0 mx-0">
        <div class="col-3 row px-0 mx-0">
            <form id="filtros" action="#" class="col-12 px-2 py-3 mx-0 my-0 pt-4" target="_self">
                @include('venta.interna.tiempo&alertas',[
                    "rest" => "/ventaInterna"
                ])
                <div class="linea-inf-bnco">
                    <div class="col-12 row mx-0 px-0">
                        <div class="col-12 col-md-6 text-center">
                            {{$disponibilidad->origen->aNombre}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{\Carbon\Carbon::parse($disponibilidad->fSalida)->format("d/m/Y")}}
                            {{\Carbon\Carbon::parse($disponibilidad->hSalida)->format("H:i")}}h
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
                            {{$disponibilidad->destino->aNombre}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{\Carbon\Carbon::parse($disponibilidad->fLlegada)->format("d/m/Y")}}
                            {{\Carbon\Carbon::parse($disponibilidad->hLlegada)->format("H:i")}}h
                        </div>
                    </div>
                </div>
                <div class="linea-inf-bnco">
                    <div class="col-12 row mx-0 px-0">
                        <div class="col-12 col-md-6 text-center">
                            {{$reg_disponibilidad->origen->aNombre}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{\Carbon\Carbon::parse($reg_disponibilidad->fSalida)->format("d/m/Y")}}
                            {{\Carbon\Carbon::parse($reg_disponibilidad->hSalida)->format("H:i")}}h
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
                            {{$reg_disponibilidad->destino->aNombre}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{\Carbon\Carbon::parse($reg_disponibilidad->fLlegada)->format("d/m/Y")}}
                            {{\Carbon\Carbon::parse($reg_disponibilidad->hLlegada)->format("H:i")}}h
                        </div>
                    </div>
                </div>
            </form>
        </div>

    <div class="col-9 row pr-0 mx-0">
        <form action="{{route('venta.interna.confirmacionGuardar')}}" method="post"
            class="row col-12 mx-0 my-0 py-0 px-0">
            @csrf
            <input type="submit" id="guardar" hidden>
            <!-- IDA -->
            <div class="col-12 mx-0 pl-lg-0">
            <div class="col-12 row px-0 mx-0 mb-3">
                <div class="col-12 px-0 mx-0">
                    <div class="col-10 row float-right mx-0 px-0 ">
                        <div class="text-center py-1 col-3 pasosDeCompra">
                            <b>Viaje</b>
                        </div>
                        <div class="text-center py-1 col-3 pasosDeCompra">
                            <b>Asientos</b>
                        </div>
                        <div class="text-center py-1 col-3 pasosDeCompra-selected">
                            <b>Confirmación</b>
                        </div>
                        <div class="text-center py-1 col-3 pasosDeCompra">
                            <b>Pago</b>
                        </div>
                    </div>
                </div>
                <div class="row col-12 mx-0 px-0 bg-gris">
                    <b class="">Verifica que todos los datos sean correctos.</b>
                </div>
            </div>
                <table id="conf-ida" class="table table-sm table-parhi-osc table-striped col-6">
                    <thead>
                        <tr>
                            <th>Asiento</th>
                            <th
                            {{session("cmpra_usarPromocion")==false ? "colspan=2" : ""}}
                            >Pasajero</th>
                            <th>Importe</th>
                            @if(session("cmpra_usarPromocion")==true)
                                <th>Promoción</th>
                            @endif
                            <th style="font-size: 0.8rem">SUBTOTAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php
                            $total=0;
                        @endphp
                        @for($i=0;$i<sizeof($pasajeros);$i++)
                        <tr id="asiento-{{$pasajeros[$i]->asiento}}" class="my-2">
                            @php
                                $importeTemp=0;
                                $IVATemp=0;
                                $promocionTemp=0;
                            @endphp
            
                            @if($pasajeros[$i]->tipoID != "AD")
                                @foreach($promociones as $promocion)
                                    @php
                                        if($promocion->tipoPasajero==$pasajeros[$i]->tipoID){
                                            $promocionTemp=$promocion->porcentProm;
                                            break;
                                        }
                                    @endphp
                                @endforeach
                            @endif
                            <td>
                                {{$pasajeros[$i]->asiento}}
                                <br>
                                {{$pasajeros[$i]->tipo}}
                            </td>
                            <td
                                {{session("cmpra_usarPromocion")==false ? "colspan=2" : ""}}
                                >
                                {{$pasajeros[$i]->pasajero}}
                            </td>
                            <td class="tarifa text-left">
                                &nbsp;$<span class="siniva">{{$tarifas->tarifaRuta}}</span>
                                <br>
                                +$<span class="iva">{{$tarifas->tarifaRutaIVA}}</span>
                                <sub>iva</sub>
                            </td>
                            @if(session("cmpra_usarPromocion")==true)
                                <td>
                                    @if(sizeof($promociones)>0)
                                        @if($pasajeros[$i]->tipoID!="AD")
                                            <select name="promoIda[{{$i}}]" id="listProm-{{$pasajeros[$i]->asiento}}" class="form-control form-control-sm promociones" row="{{$pasajeros[$i]->asiento}}" readonly>
                                                @foreach($promociones as $promocion)
                                                    @if($promocion->tipoPasajero == $pasajeros[$i]->tipoID)
                                                        <option value="{{$promocion->id}}" porcentaje="{{$promocion->porcentProm/100}}" selected>
                                                            <p>{{str_pad($promocion->porcentProm, 2, "0", STR_PAD_LEFT)}}</p>    % - {{$promocion->descripPromo}}
                                                        </option>
                                                    @endif
                                                @endforeach
                                            </select>
                                        @else
                                            <select name="promoIda[{{$i}}]" id="listProm-{{$pasajeros[$i]->asiento}}" class="form-control form-control-sm promociones" row="{{$pasajeros[$i]->asiento}}">
                                                <option value="NA" porcentaje="0">Seleccione</option>
                                                @foreach($promociones as $promocion)
                                                    @if($promocion->tipoPasajero == $pasajeros[$i]->tipoID)
                                                        <option value="{{$promocion->id}}" porcentaje="{{$promocion->porcentProm/100}}">
                                                            <p>{{str_pad($promocion->porcentProm, 2, "0", STR_PAD_LEFT)}}</p>    % - {{$promocion->descripPromo}}
                                                        </option>
                                                    @endif
                                                @endforeach
                                            </select>
                                        @endif
                                    @endif
                                </td>
                            @endif
                            <td class="subtotal">
                                @php
                                    $porcentajeAplicado=number_format(($promocionTemp/100), 2);
                                    $descuentoAplicado=number_format($tarifas->tarifaRuta*$porcentajeAplicado,2);
                                    $importeTemp=number_format($tarifas->tarifaRuta-($descuentoAplicado),2);
                                    $IVATemp=number_format($importeTemp*(env("IVA")/100), 2);
                                    $total=$total+number_format($importeTemp+$IVATemp,2);
                                @endphp
                                @if($promocionTemp!=0)
                                    <span class="original textoTachado">${{number_format($tarifas->tarifaRuta+$tarifas->tarifaRutaIVA, 2)}}</span>
                                    $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                                @else
                                    <span class="original textoTachado hidden">${{number_format($tarifas->tarifaRuta+$tarifas->tarifaRutaIVA, 2)}}</span>
                                    $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                                @endif
                            </td>
                        </tr>
                        @endfor
                        @for($i=0;$i<sizeof($reg_pasajeros);$i++)
                            <tr id="asiento-{{$reg_pasajeros[$i]->asiento}}" class="my-2">
                                @php
                                    $importeTemp=0;
                                    $IVATemp=0;
                                    $promocionTemp=0;
                                @endphp
                
                                @if($reg_pasajeros[$i]->tipoID != "AD")
                                    @foreach($reg_promociones as $promocion)
                                        @php
                                            if($promocion->tipoPasajero==$reg_pasajeros[$i]->tipoID){
                                                $promocionTemp=$promocion->porcentProm;
                                                break;
                                            }
                                        @endphp
                                    @endforeach
                                @endif
                                <td>
                                    {{$reg_pasajeros[$i]->asiento}}
                                    <br>
                                    {{$reg_pasajeros[$i]->tipo}}
                                </td>
                                <td
                                    {{session("cmpra_usarPromocion")==false ? "colspan=2" : ""}}
                                    >
                                    {{$reg_pasajeros[$i]->pasajero}}
                                </td>
                                <td class="tarifa text-left">
                                    &nbsp;$<span class="siniva">{{$reg_tarifas->tarifaRuta}}</span>
                                    <br>
                                    +$<span class="iva">{{$reg_tarifas->tarifaRutaIVA}}</span>
                                    <sub>iva</sub>
                                </td>
                                @if(session("cmpra_usarPromocion")==true)
                                    <td>
                                        @if(sizeof($reg_promociones)>0)
                                            @if($reg_pasajeros[$i]->tipoID!="AD")
                                                <select name="promoReg[{{$i}}]" id="listProm-{{$reg_pasajeros[$i]->asiento}}" class="form-control form-control-sm promociones" row="{{$reg_pasajeros[$i]->asiento}}" readonly>
                                                    @foreach($reg_promociones as $promocion)
                                                        @if($promocion->tipoPasajero == $reg_pasajeros[$i]->tipoID)
                                                            <option value="{{$promocion->id}}" porcentaje="{{$promocion->porcentProm/100}}" selected>
                                                                <p>{{str_pad($promocion->porcentProm, 2, "0", STR_PAD_LEFT)}}</p>    % - {{$promocion->descripPromo}}
                                                            </option>
                                                        @endif
                                                    @endforeach
                                                </select>
                                            @else
                                                <select name="promoReg[{{$i}}]" id="listProm-{{$reg_pasajeros[$i]->asiento}}" class="form-control form-control-sm promociones" row="{{$reg_pasajeros[$i]->asiento}}">
                                                    <option value="NA" porcentaje="0">Seleccione</option>
                                                    @foreach($reg_promociones as $promocion)
                                                        @if($promocion->tipoPasajero == $reg_pasajeros[$i]->tipoID)
                                                            <option value="{{$promocion->id}}" porcentaje="{{$promocion->porcentProm/100}}">
                                                                <p>{{str_pad($promocion->porcentProm, 2, "0", STR_PAD_LEFT)}}</p>    % - {{$promocion->descripPromo}}
                                                            </option>
                                                        @endif
                                                    @endforeach
                                                </select>
                                            @endif
                                        @endif
                                    </td>
                                @endif
                                <td class="subtotal">
                                    @php
                                        $porcentajeAplicado=number_format(($promocionTemp/100), 2);
                                        $descuentoAplicado=number_format($reg_tarifas->tarifaRuta*$porcentajeAplicado,2);
            
                                        $importeTemp=number_format($reg_tarifas->tarifaRuta-($descuentoAplicado),2);
                                        $IVATemp=number_format($importeTemp*(env("IVA")/100), 2);
            
            
            
                                        $total=$total+number_format($importeTemp+$IVATemp,2);
                                        $totalReg=$total;
                                    @endphp
                                    @if($promocionTemp!=0)
                                        <span class="original textoTachado">${{number_format($reg_tarifas->tarifaRuta+$reg_tarifas->tarifaRutaIVA, 2)}}</span>
                                        $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                                    @else
                                        <span class="original textoTachado hidden">${{number_format($reg_tarifas->tarifaRuta+$reg_tarifas->tarifaRutaIVA, 2)}}</span>
                                        $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                                    @endif
                                </td>
                            </tr>
                        @endfor
                    </tbody>
                    <thead>
                        <tr>
                            <th colspan="{{ session('cmpra_usarPromocion') ? 6 : 5 }}">
                                <!-- if(session("cmpra_usarPromocion")==true) -->
                                TOTAL ${{number_format($total,2)}}
                            </th>
                        </tr>
                    </thead>
                </table>
            </div>
        </form>
    </div>

    <div class="col-12 px-0">
        <table class="table table-parhi-osc">
            <thead>
                
            </thead>
        </table>
    </div>
    <div class="col-12 justify-content-center">
        <span class="btn-collap float-right mx-2" title="Guardar">
            <label class="btn btn-sm btn-parhi-primary"
                for="guardar">
                <i class="fa-solid fa-hand-holding-dollar"></i>
                <span>PROCEDER AL PAGO</span>
            </label>
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
<script>
    const promos={!! ($corrida->promociones()) !!};
    const IVA={{env("IVA")}};
</script>
@endsection