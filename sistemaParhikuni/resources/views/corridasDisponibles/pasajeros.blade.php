
dd($corridaDisponible->boletos)
<style>
    table{
        width:100%;
        text-align:center;
        border:1px solid red;
        margin-bottom:4px;
    }
    .opciones{
        display:none;
    }
</style>

<div id="content" class="col-12">
    <h3><center>Guía de pasajeros</center></h3>

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

    <table>
        @php
            $itinerario = $corridaDisponible->getItinerario();
        @endphp
        <tr>
            <td>Autobus</td>
            <td>Conductor</td>
            <td>Corrida</td>
            <td>origen-destino</td>
        </tr>
        <tr>
            <td><b>{{$corridaDisponible->autobus->nNumeroEconomico}}</b></td>
            <td><b>{{$corridaDisponible->conductor->persona->aApellidos}}</b></td>
            <td><b>{{$corridaDisponible->nNumero}}</b></td>
            <td><b>{{$itinerario[0]->origen}}->{{$itinerario[sizeOf($itinerario)-1]->destino}}</b</td>
        </tr>
    </table>
    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="table table-stripped table-parhi text-align-center" id="table">
            <thead>
                <tr>
                    <th>Asiento</th>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Origen-Destino</th>
                    <th>Precio</th>
                </tr>
            </thead>
            <tbody>
                @foreach($corridaDisponible->guiapasajeros as $boleto)
                    <tr>
                        <td>
                            {{$boleto->nAsiento}}
                        </td>
                        <td>
                            {{$boleto->aPasajero}}
                        </td>
                        <td>
                            {{$boleto->aTipoPasajero}}
                        </td>
                        <td>
                            {{$boleto->nOrigen}}{{$boleto->nDestino}}
                        </td>
                        <td>
                            ${{number_format($boleto->nMontoBase-$boleto->nMontoDescuento, 2)}}
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
        <div class="col-12 opciones">
            <form action="{{route('corridas.disponibles.despachar',$corridaDisponible)}}" method="post" target="_blank">
                @csrf
                <!-- <input type="hidden" name="mode" value="print"> -->
                <span class="btn-collap float-right" title="Imprimir">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="sbmt-download">
                        <i class="fa-solid fa-print"></i>
                        <span>Descargar</span>
                    </label>
                </span>

                <input id="sbmt-show" type="submit" name="mode" value="Ver pdf" />
                <input id="sbmt-download" type="submit" name="mode" value="Descargar" />
            </form>
        </div>
    </div>
</div>
