@extends('layouts.parhikuni')
@section('content')
<div class="col-11 col-sm-11 col-md-11 col-lg-11 px-0 mx-auto">
    <div class="col-12 row px-0 mx-0">
        <div class="col-3 row px-0 mx-0">
            <form id="filtros" action="#" class="col-12 px-2 py-3 mx-0 my-0 pt-4" target="_self">
                include('venta.interna.tiempo&alertas',[
                    "rest" => "/ventaInterna"
                ])
                <div class="col-12 linea-inf-bnco">
                    Detalles del viaje ✅
                </div>
                <div class="col-12 px-0 mx-0">
                    <input class="input-trans-osc text-center col-12 px-0 mx-0" type="date" value="{{session('ida_fecha')}}" readonly style="display: inline-grid;">
                </div>
                <div class="linea-inf-bnco">
                    <div class="col-12 row mx-0 px-0">
                        <div class="col-12 col-md-6 text-center">
                            {{session("ida_origenNombre")}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{(@$disponibilidad->hSalida)}}
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
                            {{session("ida_destinoNombre")}}
                        </div>
                        <div class="col-12 col-md-6 text-center">
                            {{(@$disponibilidad->hLlegada)}}
                        </div>
                    </div>
                </div>
                <div class="linea-inf-bnco">
                    <div>Asientos</div>
                </div>
            </form>
        </div>
        <div class="col-9 row pr-0">
            <div class="col-12 px-0 mx-0">
                <div class="col-10 row float-right mx-0 px-0 "> <!--  -->
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Viaje</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Asientos</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Confirmación</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra-selected">
                        <b>Pago</b>
                    </div>
                </div>
                <div class="row col-12 mx-0 px-0 bg-gris">
                    <b>Pago</b>
                </div>
            </div>
            <!--  -->
            <form class="col-12 row px-0 mx-0 mt-3" action="{{route('venta.interna.abonar')}}" method="post">
                <div class="tabGroup row px-0 mx-0 ">
                    <div class="col-3 px-0 mx-0">
                        <input class="" hid.den id="pagoEnEfectivo" type="radio" name="formaDePago" value="EF" checked>
                        <label for="pagoEnEfectivo">
                            <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt="">
                            <br>
                            Efectivo
                        </label>
                    </div>
                    <div class="col-3 px-0 mx-0">
                        <input class="" hid.den id="pagoConTarjeta" type="radio" name="formaDePago" value="TB" >
                        <label for="pagoConTarjeta">
                            <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt="">
                            <br>
                            Tarjeta
                        </label>
                    </div>
                    <div class="col-3 px-0 mx-0">
                        <input class="" hid.den id="pagoConVales" type="radio" name="formaDePago" value="VL" >
                        <label for="pagoConVales">
                            <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt="">
                            <br>
                            Vales
                        </label>
                    </div>
                    <div class="col-3 px-0 mx-0">
                        <input class="" hid.den id="pagoConDocumento" type="radio" name="formaDePago" value="DOC" >
                        <label for="pagoConDocumento">
                            <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt="">
                            <br>
                            Convenio
                        </label>
                    </div>
                </div>
            <!-- 
                <div class="col-12 row px-0 mx-0 tabGroup">
                    <div class="col-4 col-sm-3 px-0 mx-0 py-0 my-0 tabGroup">
                        <label class="" for="pagoEnEfectivo">Efectivo</label>
                        <input class="" hid.den id="pagoEnEfectivo" type="radio" name="formaDePago" value="EF" checked>
                    </div>
                    <div class="col-4 col-sm-3 px-0 mx-0 py-0 my-0">
                        <label class="" for="pagoConTarjeta">Tarjeta</label>
                        <input class="" hid.den id="pagoConTarjeta" type="radio" name="formaDePago" value="TB" >
                    </div>
                    <div class="col-4 col-sm-3 px-0 mx-0 py-0 my-0">
                        <label class="" for="pagoConVales">Vales</label>
                        <input class="" hid.den id="pagoConVales" type="radio" name="formaDePago" value="VL" >
                    </div>
                    <div class="col-4 col-sm-3 px-0 mx-0 py-0 my-0">
                        <label class="" for="pagoConDocumento">Convenio</label>
                        <input class="" hid.den id="pagoConDocumento" type="radio" name="formaDePago" value="DOC" >
                    </div>
                </div> -->

                <div class="col-12 bg-gris py-3">
                    @csrf
                    <!-- Pago en efectivo -->
                    <div class="col-8 mx-auto">
                        <b>Total</b>
                        <input id="total" type="" class="form-control form-control-sm nospinner"
                            value="{{ number_format(($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado), 2) }}" disabled
                            data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}">
                    </div>
                    <div class="col-8 mx-auto mx-0 row">
                        <b>Recibido</b>
                        <div class="col-12 col-md-9 px-0">
                            <input id="recibido" name="cantidadRecibida" type="" class="form-control form-control-sm nospinner use-inputmask"
                                value="" min="0" max="${{$venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado}}" step="0.1"
                                placeholder="00.00"
                                data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}"
                                autocomplete="off" required
                                >
                        </div>
                        <div class="col-12 col-md-3 px-2 mx-0">
                            <button id="borrarRecibido" hidden></button>
                            <label class="btn btn-sm btn-danger float-right" for="borrarRecibido"  >
                                <i class="fa-solid fa-delete-left"></i>
                                <span></span>
                            </label>
                        </div>
                    </div>
                    <div class="col-8 mx-auto">
                        <b id="cambio-lbl">Cambio</b>
                        <input id="cambio" type="" class="form-control form-control-sm nospinner" value="0" disabled
                        data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}">
                    </div>

                </div>
            </form>
            <!--  -->


            <div class="col-12 my-2">
                <span class="btn-collap float-right mx-2" title="Cancelar">
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
                <span class="btn-collap float-right mx-2" title="Guardar">
                    <label class="btn btn-sm btn-parhi-primary" for="Pagar" tabindex="9999">
                        <i class="fa-solid fa-book"></i>
                        <span>Pagar</span>
                    </label>
                    <input id="Pagar" type="submit" class="btn">
                </span>
            </div>
        </div>
    </div>
</div>
@endsection