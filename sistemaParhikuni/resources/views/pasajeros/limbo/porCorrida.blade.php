@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-11 col-md-11 col-lg-11 mx-auto">
    <h3>Boletos pendientes de asignación a corrida</h3>

    <form action="{{route('boletos.limbo.reasignar',$corridaDisponible)}}" method="post">
        <table class="table table-striped table-parhi">
            <thead>
                <tr>
                    <th></th>
                    <th>Boleto</th>
                    <th>Origen - Destino</th>
                    <th>Pasajero</th>
                    <th>Fecha original</th>
                    <th>Pasajero</th>
                    <th>asiento</th>
                    <th>costo base</th>
                </tr>
            </thead>
            <tbody>
                @foreach($boletos as $boleto)
                    <tr>
                        <td>
                            <input id="boleto[{{$boleto->nNumero}}]" class="boleto" type="checkbox" name="boleto[]" value="{{$boleto->nNumero}}">
                            <label for="boleto[{{$boleto->nNumero}}]">Seleccionar</label>
                        </td>
                        <td>
                            {{ $boleto->nNumero }}
                        </td>
                        <td>
                            {{ $boleto->origen->aNombre }}
                            <br>
                            {{ $boleto->destino->aNombre }}
                        </td>
                        </td>
                        <td>
                            {{ $boleto->aPasajero }}
                        </td>
                        <td>
                            @php
                            @endphp
                            
                            {{$fechahora=\Carbon\Carbon::parse($boleto->fSalida." ".$boleto->hSalida)->format("d/m/Y H:i")}}
                        </td>
                        <td>
                            {{ $boleto->aTipoPasajero }}
                        </td>
                        <td>
                            {{ $boleto->nAsiento }}
                        </td>
                        <td>
                            ${{ $boleto->nMontoBase }}
                        </td>
                        
                    </tr>
                @endforeach
                <tr>
                    <td colspan="6"></td>
                    <td>
                        Seleccionados
                    </td>
                    <td>
                        <input id="inpSel" type="number" name="seleccionados" value="0" max="0" min="1">
                    </td>
                </tr>
            </tbody>
        </table>
    
        <table class="table table-striped table-parhi">
            <thead>
                <tr>
                    <th>Corrida</th>
                    <th>Fecha</th>
                    <th>Hora</th>
                    <th>Autobus</th>
                    <th>Clase</th>
                    <th>Espacios</th>
                </tr>
            </thead>
            <tbody>
                @foreach($corridas as $corrida)
                    <tr>
                        <td>
                            <input id="sel-{{$corrida->nNumero}}" type="radio" name="nvaCorrida" value="{{$corrida->nNumero}}">
                            <label for="sel-{{$corrida->nNumero}}">{{$corrida->nNumero}}</label>
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
                        <td>
                            {{ $corrida->servicio}}
                        </td>
                        <td>
                            {{ $corrida->libres}} de {{ $corrida->asientos}}
                        </td>
                        
                    </tr>
                @endforeach
            </tbody>
        </table>
        @csrf
        <div class="col-12 row">
            <div class="col-12 justify-content-center">
                <a href="#tbl-diagrama">
                    <span class="btn-collap float-right" title="Continuar">
                        <label class="btn btn-sm btn-parhi-primary"
                            for="Continuar">
                            <i class="fa-solid fa-angles-right"></i>
                            <span>Continuar</span>
                        </label>
                    </span>
                </a>
            </div>
        </div>
        <table id="tbl-diagrama" border="1">
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
            <tr><td>DIAGRAMA</td></tr>
        </table>
        <div class="col-12 row">
            <div class="col-12 justify-content-center">
                <span class="btn-collap float-right" title="Guardar">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="guardar">
                        <i class="fa-solid fa-floppy-disk"></i>
                        <span>Guardar</span>
                    </label>
                    <input id="guardar" type="submit"
                    class="btn">
                </span>
            </div>
        </div>
    </form>
    
</div>
@endsection