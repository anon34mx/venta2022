@extends('layouts.parhikuni')
@section('content')
<div class="col-12 px-0 mx-auto">
    @include('venta.interna.tiempo&alertas',[
        "rest" => "/ventaInterna"
        ])

    <div class="col-12 row px-0 mx-0">
    <h3>Confirmación</h3>
    <div class="col-6">
        <table class="table table-parhi table-striped col-6">
        <thead>
            <tr>    
                <th>Fecha</th>
                <!-- <th>Hora</th> -->
                <th>Origen - estino</th>
                <th>Servicio</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    {{\Carbon\Carbon::parse($disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("d/m/Y")}}
                    <br>
                    {{\Carbon\Carbon::parse($disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("H:i")}}h
                </td>
                <td>{{$disponibilidad->origen->aNombre}} <i class="fa-solid fa-arrow-right"></i> {{$disponibilidad->destino->aNombre}}</td>
                <td>{{$corrida->servicio->aDescripcion}}</td>
            </tr>
        </tbody>
        </table>
    </div>
    <div class="col-6">
        <table class="table table-parhi table-striped col-6">
        <thead>
            <tr>    
                <th>Fecha</th>
                <!-- <th>Hora</th> -->
                <th>Origen - estino</th>
                <th>Servicio</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    {{\Carbon\Carbon::parse($reg_disponibilidad->fSalida." ".$reg_disponibilidad->hSalida)->format("d/m/Y")}}
                    <br>
                    {{\Carbon\Carbon::parse($reg_disponibilidad->fSalida." ".$reg_disponibilidad->hSalida)->format("H:i")}}h
                </td>
                <td>{{$reg_disponibilidad->origen->aNombre}} <i class="fa-solid fa-arrow-right"></i> {{$reg_disponibilidad->destino->aNombre}}</td>
                <td>{{$corrida->servicio->aDescripcion}}</td>
            </tr>
        </tbody>
        </table>
    </div>
    <h3>Pasajeros</h3>
    <form action="{{route('venta.interna.confirmacionGuardar')}}" method="post" class="row px-0 mx-0">
        @csrf
        <input type="submit" id="guardar" hidden>
        <!-- IDA -->
        <div class="col-6">
            <table id="conf-ida" class="table table-parhi table-striped">
                <thead>
                    <tr>
                        <th>Asiento</th>
                        <th
                        {{session("cmpra_usarPromocion")==false ? "colspan=2" : ""}}
                        >Pasajero</th>
                        <th>Importe</th>
                        <!-- <th>IVA</th> -->
                        @if(session("cmpra_usarPromocion")==true)
                            <th>Promoción</th>
                        @endif
                        <th>SUBTOTAL</th>
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
                            $<span class="siniva">{{$tarifas->tarifaRuta}}</span>
                            <br>
                            +$<span class="iva">{{$tarifas->tarifaRutaIVA}}</span>(iva)
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
                    <tr>
                        <td colspan="3"></td>
                        <td><b>TOTAL</b></td>
                        <td>
                            <b>
                                <span class="total">
                                    ${{number_format($total,2)}}
                                </span>
                            </b>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <!-- REGRESO -->
        <div class="col-6">
            <table id="conf-ida" class="table table-parhi table-striped">
                <thead>
                    <tr>
                        <th>Asiento</th>
                        <th
                        {{session("cmpra_usarPromocion")==false ? "colspan=2" : ""}}
                        >Pasajero</th>
                        <th>Importe</th>
                        <!-- <th>IVA</th> -->
                        @if(session("cmpra_usarPromocion")==true)
                            <th>Promoción</th>
                        @endif
                        <th>SUBTOTAL</th>
                    </tr>
                </thead>
                <tbody>
                    @php
                        $total=0;
                    @endphp
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
                            <!-- &emsp; -->
                            $<span class="siniva">{{$reg_tarifas->tarifaRuta}}</span>
                            <br>
                            +$<span class="iva">{{$reg_tarifas->tarifaRutaIVA}}</span>(iva)
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
                    <tr>
                        <td colspan="3"></td>
                        <td><b>TOTAL</b></td>
                        <td>
                            <b>
                                <span class="total">
                                    ${{number_format($total,2)}}
                                </span>
                            </b>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
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