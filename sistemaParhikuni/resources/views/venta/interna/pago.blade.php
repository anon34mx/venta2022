@extends('layouts.parhikuni')

@section('content')
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
        <b>Total ${{$total}}</b>

        <div class="col-12">
            <h5>Forma de pago</h5>
            <div class="col-6">
                <label for="pagoEnEfectivo">Efectivo</label>
                <input id="pagoEnEfectivo" type="radio" name="formaDePago">
            </div>
            <div class="col-6">
                <label for="pagoConTarjeta">Tarjeta</label>
                <input id="pagoConTarjeta" type="radio" name="formaDePago">
            </div>
        </div>
        <div class="col-12">
            <div class="12">
                <!-- Pago en efectivo -->
                <div>asd</div>
            </div>
        </div>
    </div>
</div>
@endsection