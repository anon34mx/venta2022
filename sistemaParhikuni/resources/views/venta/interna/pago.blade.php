@extends('layouts.parhikuni')
@section('content')
<div class="col-11 col-sm-11 col-md-11 col-lg-11 px-0 mx-auto">
    @include('venta.interna.tiempo&alertas',[
        "rest" => "/ventaInterna"
        ])

<div class="col-12 row px-0 mx-0">
    <div>
        <h3>PAGO</h3>
        <br>
        
        <form class="12 row" action="{{route('venta.interna.abonar')}}" method="post">
        <div class="col-12">
            <h5>Forma de pago</h5>
            <div class="col-6">
                <label for="pagoEnEfectivo">Efectivo</label>
                <input id="pagoEnEfectivo" type="radio" name="formaDePago" value="EF" checked>
            </div>
            <div class="col-6">
                <label for="pagoConTarjeta">Tarjeta</label>
                <input id="pagoConTarjeta" type="radio" name="formaDePago" value="TB" disabled>
            </div>
        </div>
        <div class="col-12">
                @csrf
                <!-- Pago en efectivo -->
                <div class="col-6 mx-auto">
                    <b>Total</b>
                    <input id="total" type="" class="form-control form-control-sm nospinner"
                        value="{{ number_format(($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado), 2) }}" disabled
                        data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}">
                </div>
                <div class="col-6 mx-auto mx-0 row">
                    <b>Recibido</b>
                    <div class="col-12 col-md-8 px-0">
                        <input id="recibido" name="cantidadRecibida" type="" class="form-control form-control-sm nospinner use-inputmask"
                            value="" min="0" max="${{$venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado}}" step="0.1"
                            placeholder="00.00"
                            data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}"
                            autocomplete="off" required
                            >
                    </div>
                    <div class="col-12 col-md-4 px-2 mx-0">
                        <button id="borrarRecibido" hidden></button>
                        <label class="btn btn-sm btn-danger float-right" for="borrarRecibido"  >
                            <i class="fa-solid fa-ban"></i>
                            <span>Cancelar</span>
                        </label>
                    </div>
                </div>
                <div class="col-6 mx-auto">
                    <b id="cambio-lbl">Cambio</b>
                    <input id="cambio" type="" class="form-control form-control-sm nospinner" value="0" disabled
                    data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}">
                </div>
                <div class="col-12 my-2">
                    <span class="btn-collap float-right mx-2" title="Guardar">
                        <label class="btn btn-sm btn-parhi-primary" for="Pagar" tabindex="9999">
                            <i class="fa-solid fa-book"></i>
                            <span>Pagar</span>
                        </label>
                        <input id="Pagar" type="submit" class="btn">
                    </span>
                </div>
            </div>
        </form>
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
@endsection