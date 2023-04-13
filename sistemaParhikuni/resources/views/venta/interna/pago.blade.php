@extends('layouts.parhikuni')
@section('content')
<div class="col-11 col-sm-11 col-md-11 col-lg-11 px-0 mx-auto">
    <div class="col-12 row px-0 mx-0">
        <div class="col-3 row px-0 mx-0">
            <form id="filtros" action="#" class="col-12 px-2 py-3 mx-0 my-0 pt-4" target="_self">
                @include('venta.interna.tiempo&alertas',[
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
            <form class="col-12 row px-0 mx-0 mt-3 needs-validation" action="{{route('venta.interna.abonar')}}" method="post" novalidate>
                <input id="Pagar" type="submit" class="btn" hidden>
                @csrf
                <div class="tabGroup row px-0 mx-0 ">
                    <!-- tabs -->
                    <div class="row mx-0 mx-0">
                        <div class="col-3 px-0 mx-0">
                            <input class="" hidden id="pagoEnEfectivo" type="radio" name="formaDePago" value="EF" target=".view-1" onclick="$('.views').fadeOut();$(this.target+'').fadeIn()">
                            <label for="pagoEnEfectivo">
                                <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt=""><br>Efectivo
                            </label>
                        </div>
                        <div class="col-3 px-0 mx-0">
                            <input class="" hidden id="pagoConTarjeta" type="radio" name="formaDePago" value="TB" target=".view-2" onclick="">
                            <label for="pagoConTarjeta">
                                <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt=""><br>Tarjeta
                            </label>
                        </div>
                        <div class="col-3 px-0 mx-0">
                            <input class="" hidden id="pagoConVales" type="radio" name="formaDePago" value="VL" target=".view-3" onclick="">
                            <label for="pagoConVales">
                                <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt=""><br>Vales
                            </label>
                        </div>
                        <div class="col-3 px-0 mx-0">
                            <input class="" hidden id="pagoConDocumento" type="radio" name="formaDePago" value="DOC" target=".view-3" onclick="">
                            <label for="pagoConDocumento">
                                <img src="{{ Vite::asset('resources/images/favicon.ico') }}" alt=""><br>Convenio
                            </label>
                        </div>
                    </div>
                        <!-- Pago en efectivo -->
                        <div class="views view-1 col-12 bg-gris py-3">
                            <div class="col-8 mx-auto">
                                <b>Total</b>
                                <input id="total" type="" class="form-control form-control-sm nospinner"
                                    value="{{ number_format(($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado), 2) }}" readonly
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
                                    <label class="btn btn-danger" for="borrarRecibido"  >
                                        <i class="fa-solid fa-delete-left"></i>
                                        <span></span>
                                    </label>
                                </div>
                            </div>
                            <div class="col-8 mx-auto">
                                <b id="cambio-lbl">Cambio</b>
                                <input id="cambio" type="" class="form-control form-control-sm nospinner" value="0" readonly
                                data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}">
                            </div>
        
                        </div>
                        <!-- Pago con tarjeta -->
                        <div class="views view-2 col-12 bg-gris py-3">
                            <div class="col-8 mx-auto">
                                <b>Introduzca la tarjeta en la terminal</b>
                                <div class="col-12 mx-auto">
                                    <b>Total</b>
                                    <input id="total" type="" class="form-control form-control-sm nospinner"
                                        value="{{ number_format(($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado), 2) }}" disabled
                                        data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}" readonly>
                                </div>
                            <div class="col-12 mx-auto mx-0 row">
                                <b>Pagar</b>
                                <div class="col-12 col-md-9 px-0">
                                    <input id="recibido" name="cantidadRecibida" class="form-control form-control-sm nospinner use-inputmask"
                                        value="{{ number_format(($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado), 2) }}"
                                        min="1"
                                        max="{{ number_format(($venta->calcularAdeudo()->total - $venta->calcularAdeudo()->abonado), 2) }}" step="0.1"
                                        placeholder="00.00"
                                        data-inputmask-regex="[0-9]{2,}\.[0-9]{2,2}"
                                        autocomplete="off" required
                                        >
                                </div>
                                <div class="col-12 col-md-3 px-2 mx-0 py-2">
                                    <button id="borrarAPagar" hidden></button>
                                    <label class="btn btn-danger" for="borrarAPagar"  >
                                        <i class="fa-solid fa-delete-left"></i>
                                        <span></span>
                                    </label>
                                </div>
                                </div>
                                    <center><img src="{{ Vite::asset('resources/images/card.png') }}" alt="inserte tarjeta" style="width: 50%"></center>
                                </div>
                                <div class="col-12 row">
                                    <div class="col-12" >
                                        <input id='tarjeta' placeholder='tarjeta'>
                                    </div>    
                                    <div class="col-12" >
                                        <input id='expiracion' placeholder='expiracion'>
                                    </div>    
                                    <div class="col-12" >
                                        <input id='ccv' placeholder='ccv'>
                                    </div>    
                                </div>
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
                <span class="btn-collap float-right mx-2" title="Pagar">
                    <label class="btn btn-sm btn-parhi-primary" for="Pagar" tabindex="9999">
                        <i class="fa-solid fa-book"></i>
                        <span>Pagar</span>
                    </label>
                </span>
            </div>
        </div>
    </div>
</div>
<script>
    setInterval(() => {
        try {
            leerTarjetaBancaria()
        } catch (error) {
            console.error(error)
        }
    }, 1100);
</script>
@endsection