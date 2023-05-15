@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-11 col-md-11 col-lg-11 mx-auto">
    <h3>Reasignar pasajeros manualmente</h3>
    <div>
        Seleccionar en grupos con el mismo origen-destino
    </div>

    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    @if(sizeof($boletos)>0 )
        <form action="{{route('boletos.reasignarManual',$corridaDisponible)}}" method="post">
            <table class="table table-parhi">
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
                        <tr id="asiento-{{$boleto->nNumero}}">
                            <td>
                                <input id="boleto[{{$boleto->nNumero}}]" class="boleto selecPTransferencia"
                                    type="checkbox" name="boleto[]" value="{{$boleto->nNumero}}"
                                    nOrigen="{{ $boleto->nOrigen }}" nDestino="{{ $boleto->nDestino }}">
                                <label for="boleto[{{$boleto->nNumero}}]">Seleccionar</label>
                            </td>
                            <td>
                                {{ $boleto->nNumero }}
                            </td>
                            <td class="">
                                {{ $boleto->origen->aNombre }}
                                <br>
                                {{ $boleto->destino->aNombre }}
                            </td>
                            <td class="nOrigen" hidden>
                                {{ $boleto->origen->nNumero }}
                            </td>
                            <td class="nDestino" hidden>
                                {{ $boleto->destino->nNumero }}
                            </td>
                            </td>
                            <td class="pasajero">
                                {{ $boleto->aPasajero }}
                            </td>
                            <td class="">
                                @php
                                @endphp
                                
                                {{$fechahora=\Carbon\Carbon::parse($boleto->fSalida." ".$boleto->hSalida)->format("d/m/Y H:i")}}
                            </td>
                            <td class="tipoPasajero">
                                {{ $boleto->aTipoPasajero }}
                            </td>
                            <td class="">
                                {{ $boleto->nAsiento }}
                            </td>
                            <td class="">
                                ${{ $boleto->nMontoBase }}
                            </td>
                            
                        </tr>
                    @endforeach
                </tbody>
            </table>
        
            <div class="col-12 row">
                <div class="col-12 justify-content-center">
                    <a href="#tbl-corridas">
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
            
            <table id="tbl-corridas" class="table table-striped table-parhi">
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
                </tbody>
            </table>
            @csrf
            
            <div class="col-12 row">
                <div class="col-5">
                    <table id="tbl-diagrama" border="1" width="100px" style="max-width:200px">
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
                </div>
                <div class="col-7">
                    <table id="tbl-datosPasajeros" class="tbl-datosPasajeros rounded-top table-striped">
                        <thead>
                            <tr>
                                <th class="col-3">Tipo</th>
                                <th class="col-1">Asiento</th>
                                <th>Nombre</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- endif -->
                            <datalist id="listaPasajeros">
                                @php
                                $pasajeros=json_decode(session("pasajeros"));
                                if($pasajeros!=null){
                                    for($i=0; $i<sizeof(@$pasajeros); $i++){
                                        echo '<option value="'.$pasajeros[$i]->pasajero.'">';
                                    }
                                }
                                @endphp
                                <option value="EDUARDO ESPINOSA">
                                <option value="JOSE ANTONIO BADIA">
                                <option value="MARIO LOPEZ">
                                <option value="ROBERTO ANDRADE">
                                <option value="HUGO PEREZ">
                            </datalist>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- <div class="col-12 row">
                <div class="col-12 justify-content-center">
                    <span class="btn-collap float-right" title="Guardar">
                        <label class="btn btn-sm btn-parhi-primary"
                            for="guardar">
                            <i class="fa-solid fa-floppy-disk"></i>
                            <span>Guardar</span>
                        </label>
                    </span>
                </div>
            </div> -->
            <input id="guardar" type="submit" class="btn">
        </form>
    @endif
    <script>
        var nCorrida={{$corridaDisponible->nNumero?:0}};
    </script>
</div>
@endsection