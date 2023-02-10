@extends('layouts.parhikuni')
@section('content')
@if(session()->has("tiempoCompra")==true)
<div class="tiempoRestanteCont">
    <span class="mx-1">Tiempo para la compra</span>
    <input id="tiempoRestante"
        readonly
        step="3600000" initial="{{session('tiempoCompra')-time()}}">
</div>
@endif
<div class="col-11 col-sm-11 col-md-11 col-lg-11 px-0 mx-auto">
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

<div class="col-12 row px-0 mx-0">

    <h3>Confirmación</h3>
    <table class="table table-parhi table-striped">
        <thead>
            <tr>    
                <th>Fecha</th>
                <th>Hora</th>
                <th>Origen</th>
                <th>Destino</th>
                <th>Servicio</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>{{\Carbon\Carbon::parse($disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("d/m/Y")}}</td>
                <td>{{\Carbon\Carbon::parse($disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("H:i")}}h</td>
                <td>{{$disponibilidad->origen->aNombre}}</td>
                <td>{{$disponibilidad->destino->aNombre}}</td>
                <td>{{$corrida->servicio->aDescripcion}}</td>
            </tr>
        </tbody>
    </table>
    <h3>Pasajeros</h3>
    <form action="{{route('venta.interna.confirmacionGuardar')}}" method="post">
        @csrf
        <input type="submit" id="guardar" hidden>
        <table class="table table-parhi table-striped">
            <thead>
                <tr>
                    <th>Asiento</th>
                    <th>Pasajero</th>
                    <th>Importe</th>
                    <th>IVA</th>
                    @if(session("usarPromocion")==true)
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
                    <td>
                        {{$pasajeros[$i]->pasajero}}
                    </td>
                    <td class="tarifa">
                        $<span>{{$tarifas->tarifaRuta}}</span>
                    </td>
                    <td class="iva">
                        $<span>{{$tarifas->tarifaRutaIVA}}</span>
                    </td>
                    @if(session("usarPromocion")==true)
                        <td>
                            @if(sizeof($promociones)>0)
                                @if($pasajeros[$i]->tipoID!="AD")
                                    <select name="promo[{{$i}}]" id="listProm-{{$pasajeros[$i]->asiento}}" class="form-control form-control-sm promociones" row="{{$pasajeros[$i]->asiento}}" readonly>
                                        @foreach($promociones as $promocion)
                                            @if($promocion->tipoPasajero == $pasajeros[$i]->tipoID)
                                                <option value="{{$promocion->id}}" selected>
                                                    <p>{{str_pad($promocion->porcentProm, 2, "0", STR_PAD_LEFT)}}</p>    % - {{$promocion->descripPromo}}
                                                </option>
                                            @endif
                                        @endforeach
                                    </select>
                                @else
                                    <select name="promo[{{$i}}]" id="listProm-{{$pasajeros[$i]->asiento}}" class="form-control form-control-sm promociones" row="{{$pasajeros[$i]->asiento}}">
                                        <option value="NA">Seleccione</option>
                                        @foreach($promociones as $promocion)
                                            @if($promocion->tipoPasajero == $pasajeros[$i]->tipoID)
                                                <option value="{{$promocion->id}}">
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
                            $<span class="porPagar">{{number_format($importeTemp+$IVATemp, 2)}}</span>
                        @endif
                    </td>
                </tr>
                @endfor
                <tr>
                    <td colspan="4"></td>
                    <td><b>TOTAL</b></td>
                    <td>
                        <b>
                            <span id="total">
                                ${{number_format($total,2)}}
                            </span>
                        </b>
                    </td>
                </tr>
            </tbody>
        </table>
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