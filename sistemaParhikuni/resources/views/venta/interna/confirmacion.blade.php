@extends('layouts.parhikuni')

@section('content')
<div class="col-10 col-sm-10 col-md-10 col-lg-10 px-0 mx-auto">
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
    <input id="tiempoRestante" value="{{\Carbon\Carbon::parse($tiempoRestante)->format("m:s");}}" type="" step="3600000" initial="{{$tiempoRestante}}">
    <h3>Confirmación</h3>
    <table>
        <tr>
            <th>Fecha</th>
            <th>Hora</th>
            <th>Origen</th>
            <th>Destino</th>
            <th>Servicio</th>
        </tr>
        <tbody>
            <tr>
                <td>{{\Carbon\Carbon::parse($disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("d-m-Y")}}h</td>
                <td>{{\Carbon\Carbon::parse($disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("H:i")}}h</td>
                <td>{{$disponibilidad->origen->aNombre}}</td>
                <td>{{$disponibilidad->destino->aNombre}}</td>
                <td>{{$corrida->servicio->aDescripcion}}</td>
            </tr>
        </tbody>
    </table>
    <h3>Pasajeros</h3>
    <table>
        <thead>
            <tr>
                <th>Asiento</th>
                <th>Pasajero</th>
                <th>Tipo</th>
                <th>Importe</th>
                <th>IVA</th>
                <th>SUBTOTAL</th>
            </tr>
        </thead>
        <tbody>
            @php
                $asientoApartado=json_decode($_COOKIE["asientos"]);
                $pasajeros=json_decode($_SESSION["pasajeros"]);
                $tipos=json_decode($_SESSION["pasajerosTipos"]);
            @endphp
            @for($i=0;$i<sizeof($asientoApartado);$i++)
            <tr>
                <td>{{$asientoApartado[$i]}}</td>
                <td>{{$pasajeros[$i]}}</td>
                <td>{{$tipos[$i]}}</td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            @endfor
            <tr>
                <td colspan="4"></td>
                <td><b>TOTAL</b></td>
                <td>$00.00</td>
            </tr>
        </tbody>
    </table>

    <br>
    Datos del pasajero<br><br>
    *nombre<br>
    *tipo<br>
    *asiento<br>
    *IMPORTE<br>
    *IVA<br>
    *SUBTOTAL<br>

    <!-- METODOS DE PAGO<br><br> -->

    <button>PROCEDER AL PAGO</button>
</div>

@endsection