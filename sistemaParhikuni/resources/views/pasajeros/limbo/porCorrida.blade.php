@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
    <h3>Boletos pendientes de asignación a corrida</h3>


    corrida
    fecha
    hora
    <table class="table table-striped table-parhi">
        <thead>
            <tr>
                <th>clave</th>
                <th>Origen</th>
                <th>destino</th>
                <th>Pasajero</th>
                <th>asiento</th>
                <th>costo base</th>
            </tr>
        </thead>
        <tbody>
            @foreach($boletos as $boleto)
                <tr>
                    <td>
                        {{ $boleto->nNumero }}
                    </td>
                    <td>
                        {{ $boleto->nOrigen }}
                    </td>
                    <td>
                        {{ $boleto->nDestino }}
                    </td>
                    <td>
                        {{ $boleto->aTipoPasajero }}
                    </td>
                    <td>
                        {{ $boleto->nAsiento }}
                    </td>
                    <td>
                        {{ $boleto->nMontoBase }}
                    </td>
                    
                </tr>
            @endforeach
        </tbody>
    </table>

    <table class="table table-striped table-parhi">
        <thead>
            <tr>
                <th></th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Autobus</th>
            </tr>
        </thead>
        <tbody>
            @foreach($corridas as $corrida)
                <tr>
                    <td>
                        <input id="sel-{{$corrida->nNumero}}" type="radio" name="nvaCorrida">
                        <label for="sel-{{$corrida->nNumero}}">Seleccionar</label>
                    </td>
                    <td>
                        {{ $corrida->fSalida }}
                    </td>
                    <td>
                        {{ $corrida->hSalida }}
                    </td>
                    <td>
                        {{ $corrida->nNumeroAutobus }}
                    </td>
                    
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection