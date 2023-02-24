@extends('layouts.parhikuni')

@section('content')
<div class="col-12">
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

    @php
        $itinerario = $corridaDisponible->getItinerario();
    @endphp
    <table>
        <tr>
            <td>Autobus</td>
            <td>Conductor</td>
            <td>Corrida</td>
            <td>Origen - Destino</td>
        </tr>
        <tr>
            <td><b>{{@$corridaDisponible->autobus->nNumeroEconomico}}</b></td>
            <td><b>{{@$corridaDisponible->conductor->persona->aApellidos != null ? @$corridaDisponible->conductor->persona->aApellidos: "N/A"}}</b></td>
            <td><b>{{@$corridaDisponible->nNumero}}</b></td>
            <td>
                <b>{{@$itinerario[0]->origen}} -> {{@$itinerario[sizeOf($itinerario)-1]->destino}}</b>
                <span style="display: block;">
                    {{\Carbon\Carbon::createFromFormat("Y-m-d H:m:s", @$corridaDisponible->fSalida." ".$corridaDisponible->hSalida)->format("d-m-Y H:i")}}
                </span>
            </td>
        </tr>
    </table>
    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="table table-stripped table-parhi text-align-center" id="table">
            <thead>
                <tr>
                    <th>Asiento</th>
                    <th>Nombre</th>
                    <th>Tipo</th>
                    <th>Origen</th>
                    <th>Destino</th>
                    <th>Precio</th>
                </tr>
            </thead>
            <tbody>
                @if(sizeof($corridaDisponible->guiapasajeros)>0)
                    @foreach($corridaDisponible->guiapasajeros as $boleto)
                        <tr>
                            <td>
                                {{$boleto->nAsiento}}
                            </td>
                            <td class="text-left">
                                {{$boleto->aPasajero}}
                            </td>
                            <td>
                                {{$boleto->tipo->aDescripcion}}
                            </td>
                            <td>
                                {{$boleto->origen->aNombre}}
                            </td>
                            <td>
                                {{$boleto->destino->aNombre}}
                            </td>
                            <td class="text-right">
                                ${{number_format($boleto->nMontoBase, 2)}}
                            </td>
                        </tr>
                    @endforeach
                @else
                <tr><td colspan="999"><b>No hay pasajeros registrados</b></td></tr>
                @endif
            </tbody>
        </table>
        <span class="btn-collap float-right noprint" title="Imprimir" onclick="print()">
            <label class="btn btn-sm btn-parhi-primary">
                <i class="fa-solid fa-print"></i>
                <span>Imprimir</span>
            </label>
        </span>
        <div class="col-12" style="display:none;">
            <form action="{{route('corridas.disponibles.despachar',$corridaDisponible)}}" method="post" target="_blank">
                @csrf
                <!-- <input type="hidden" name="mode" value="print"> -->
                <span class="btn-collap float-right" title="Imprimir">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="sbmt-download">
                        <i class="fa-solid fa-print"></i>
                        <span>imprimir</span>
                    </label>
                </span>

                <input id="sbmt-show" type="submit" name="mode" value="Ver pdf" />
                <input id="sbmt-download" type="submit" name="mode" value="Descargar" />
            </form>
        </div>
        <!-- <div class="mt-3 d-flex justify-content-center">
            $corridasDisponibles->appends(Request::all())->links("pagination::bootstrap-5")
        </div> -->
    </div>
</div>
@endsection