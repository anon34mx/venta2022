@extends('layouts.parhikuni')
@section('content')
@if(session()->has("cmpra_tiempoCompra"))
<div class="tiempoRestanteCont">
    <span class="mx-1">Tiempo para la compra</span>
    <input id="tiempoRestante"
        readonly
        step="3600000" initial="{{session("cmpra_tiempoCompra")-time()}}">
</div>
@endif
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif

@php
$contAuxPasajeros=0;
@endphp
<div class="col-12 row px-0 mx-0">
    <h3>ASIENTOS</h3>
    <div class="col-3">
        <table style="width:200px" class="tbl-diagrama-bus">
            <tr>
                <td>
                    <img alt="" style="" width="34"
                        class="logo-color mx-auto my-3" src="{{ Vite::asset('resources/images/asientos/Conductor.png') }}">
                </td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            @php
            $contAuxAsien=0;
            $sizeAsientos=sizeof($asientosOcupados);
            @endphp
            @foreach(explode("|" ,$cordis->autobus->distribucionAsientos->aDistribucion) as $row)
                <tr>
                    @foreach(explode(",",$row) as $col)
                        <td>
                            @if($col=="00")
                            __
                            @elseif($col=="PU")
                                <div class="asiento_nmr">[PU]</div>
                            @elseif($col=="BH")
                                <div class="asiento_nmr">{{$col}}</div>
                            @elseif($col=="BM")
                                <div class="asiento_nmr">{{$col}}</div>
                            @elseif($col=="CA")
                                <div class="asiento_nmr">{{$col}}</div>
                            @else
                                @php
                                $numAsiento=substr($col,0,2);
                                $ocupado=0;
    
                                @endphp
                                @if( @$asientosOcupados[$numAsiento])
                                    @if(strpos($col,"T")>0)
                                        <div id="asiento-{{$numAsiento}}" class="asiento tv  ocupado" numero="{{$numAsiento}}">
                                            <img alt="Ocupado" style=""
                                                class="logo-color mx-auto my-0" src="">
                                                <span>{{$numAsiento}}</span>
                                        </div>
                                    @else
                                        <div id="asiento-{{$numAsiento}}" class="asiento ocupado" numero="{{$numAsiento}}">
                                            <img alt="Ocupado" style=""
                                                class="logo-color mx-auto my-0" src="">
                                                
                                                <span>{{$numAsiento}}x</span>
                                        </div>
                                    @endif
                                    @php
                                        $contAuxAsien=$contAuxAsien+1;
                                    @endphp
                                @else
                                    @if(strpos($col,"T")>0)
                                        <div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                            <img alt="Libre" style=""
                                            class="logo-color mx-auto my-0">
                                            <span>{{$numAsiento}}</span>
                                        </div>
                                    @else
                                        <div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                            <img alt="Libre" style=""
                                            class="logo-color mx-auto my-0">
                                            <span>{{$numAsiento}}</span>
                                        </div>
                                    @endif
                                @endif
                                <div class="asiento_nmr">{{$col}}</div>
                            @endif
                        </td>
                    @endforeach
                </tr>
                @php
                // break;
                @endphp
            @endforeach
        </table>
    </div>
    <div class="col-9">
        {{$disponibilidad->origen->aNombre." a ".$disponibilidad->destino->aNombre}}
        {{\Carbon\Carbon::createFromFormat("Y-m-d H:i:s", $disponibilidad->fSalida." ".$disponibilidad->hSalida)->format("d/m/Y H:i")}}h

        <form id="pasajerosAsientos" action="{{route('venta.interna.apartar')}}" method="post">
            @csrf
            <table id="tbl-datosPasajeros" class="tbl-datosPasajeros">
                <thead>
                    <tr>
                        <th colspan="5">Pasajeros</th>
                    </tr>
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
                    </datalist>
                </tbody>
            </table>
            <div class="col-12">
                <button id="btn-apartar" hidden>Apartar</button>
            </div>
        </form>
    </div>
    <div class="col-12 justify-content-center">
        <span class="btn-collap float-right mx-2" title="Guardar">
            <label class="btn btn-sm btn-parhi-primary"
                for="btn-apartar" tabindex="9999">
                <i class="fa-solid fa-book"></i>
                <span>Apartar</span>
            </label>
            <input id="guardar" type="submit"
            class="btn">
        </span>

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

<div id="posiblesPasajeros" hidden>
    <select class="listaPasajeroTipo form-control px-1">
        <option value="">Seleccione</option>
        @foreach($tiposPasajeros as $tipoPasajero)
            @foreach($pasajerosSolic as $key=>$value)
                @if($key==$tipoPasajero->aClave)
                <option value="{{$tipoPasajero->aClave}}" max="{{$pasajerosSolic[$tipoPasajero->aClave]['max']}}">
                    {{$tipoPasajero->aDescripcion}}
                </option>
                @endif
            @endforeach
        @endforeach
    </select>
</div>
<!-- Modal -->
<div class="modal fade" id="exampleModalLong" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="$('#exampleModalLong').modal('hide');">Cerrar</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>

<script>
    var pasajeros={!! json_encode($pasajerosSolic) !!};
    var totalPasajeros={{ $totalPasajeros }};
    var tiposPasajeros={!! json_encode($tiposPasajeros) !!}
</script>
@endsection
