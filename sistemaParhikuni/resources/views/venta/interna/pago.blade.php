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
                <div class="col-4">
                    <b>Total</b>
                    <input id="total" type="text" class="form-control form-control-sm nospinner" value="{{$venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado}}" disabled>
                </div>
                <div class="col-4">
                    <b>Recibido</b>
                    <input id="recibido" name="cantidadRecibida" type="Number" class="form-control form-control-sm nospinner"
                        value="0" min="0" max="${{$venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado}}" step="0.1">
                </div>
                <div class="col-4">
                    <b id="cambio-lbl">Cambio</b>
                    <input id="cambio" type="Number" class="form-control form-control-sm nospinner" value="0" disabled>
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