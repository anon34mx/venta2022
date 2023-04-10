@extends('layouts.parhikuni')
@section('content')
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
                            {{@$disponibilidad->origen->aNombre}}
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
                            {{@$disponibilidad->destino->aNombre}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{\Carbon\Carbon::parse($disponibilidad->fLlegada)->format("d/m/Y")}}
                            {{\Carbon\Carbon::parse($disponibilidad->hLlegada)->format("H:i")}}h
                        </div>
                    </div>
                </div>
                <div class="linea-inf-bnco">
                    {{@$corrida->servicio->aDescripcion}}
                </div>
            </form>
        </div>
        <div class="col-9 row pr-0 mx-0">
            <div class="col-12 px-0 mx-0">
                <div class="col-12 row float-right mx-0 px-0 ">
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
                <div class="row col-12 mx-0 px-0 bg-gris">
                    <b class="">Verifica que todos los datos sean correctos.</b>
                </div>
            </div>
            <form action="{{route('venta.interna.confirmacionGuardar')}}" method="post">
                @csrf
                <input type="submit" id="guardar" hidden>
                <table class="table table-parhi-osc table-striped">
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
                                $<span class="iva">{{$tarifas->tarifaRutaIVA}}</span>
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
                                    $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                                    <span class="original textoTachado">${{number_format($tarifas->tarifaRuta+$tarifas->tarifaRutaIVA, 2)}}</span>
                                @else
                                    $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                                    <span class="original textoTachado">${{number_format($tarifas->tarifaRuta+$tarifas->tarifaRutaIVA, 2)}}</span>
                                @endif
                            </td>
                        </tr>
                        @endfor
                        <tfoot>
                            <tr>
                                <th colspan="3"></th>
                                <th><b>TOTAL</b></th>
                                <th>
                                    <b>
                                        <span class="total">
                                            ${{number_format($total,2)}}
                                        </span>
                                    </b>
                                </th>
                            </tr>
                        </tfoot>
                    </tbody>
                </table>
            </form>
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
</div>

<script>
    const promos={!! ($corrida->promociones()) !!};
    const IVA={{env("IVA")}};
</script>

<table id="promociones" hidden>
    @if(sizeof($promociones)>0)
        @foreach($promociones as $promocion)
            <tr>
                <td id="promo-{{$promocion->id}}">
                    <span>0.{{str_pad($promocion->porcentProm, 2, "0", STR_PAD_LEFT)}}</span>
                </td>
            </tr>
        @endforeach
    @endif
</table>
@endsection