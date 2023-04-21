@extends('layouts.parhikuni')
@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">

@php
$contAuxPasajeros=0;
@endphp
<div class="col-12 row px-0 mx-0">
    <div class="col-12 row mx-0 px-0">
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
                            {{($disponibilidad->hSalida)}}
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
                            {{($disponibilidad->hLlegada)}}
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
                    <div class="text-center py-1 col-3 pasosDeCompra-selected">
                        <b>Asientos</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Confirmación</b>
                    </div>
                    <div class="text-center py-1 col-3 pasosDeCompra">
                        <b>Pago</b>
                    </div>
                </div>
            </div>
            <div class="row col-12 mx-0 px-0 bg-gris">
                <b>Selección de asientos</b>
            </div>
            <!--  -->

            <div class="col-12 col-sm-6 col-md-5 col-lg-4 col-xl-3 mx-auto">
                <table id="asientos-ida" class="tbl-diagrama-bus mx-auto mt-2" style="
                    max-width: 300px;
                    margin: auto;
                    ">
                    <tr>
                        <td>
                            <img alt="" style="" width="34"
                                class="logo-color mx-auto my-0" src="{{ Vite::asset('resources/images/diagramaAutobus/Conductor.png') }}">
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
                                        <div class="pasillo"></div>
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
                                                <div id="asiento-{{$numAsiento}}" class="asiento tv ocupado" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}</span>
                                                    <br>
                                                    <sub>tv</sub>
                                                </div>
                                            @else
                                                <div id="asiento-{{$numAsiento}}" class="asiento ocupado" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}x</span>
                                                    <br>
                                                    <sub>notv</sub>
                                                </div>
                                            @endif
                                            @php
                                                $contAuxAsien=$contAuxAsien+1;
                                            @endphp
                                        @else
                                            @if(strpos($col,"T")>0)
                                                <div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                                    <span>{{"$numAsiento"}}</span>
                                                    <br>
                                                    <sub>tv</sub>
                                                </div>
                                            @else
                                                <div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                                    <span>{{$numAsiento}}</span>
                                                    <br>
                                                    <sub>notv</sub>
                                                </div>
                                            @endif
                                        @endif
                                    @endif
                                </td>
                            @endforeach
                        </tr>
                        @php
                        // break;
                        @endphp
                    @endforeach
                    <tr>
                        <td colspan="5">
                            <img src="{{ Vite::asset('resources/images/servicios/'.$cordis->servicio->aClave.'.png') }}" alt="">
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">serbisios</td>
                    </tr>
                </table>
            </div>
            <div class="col-12 col-sm-6 col-md-7 col-lg-8 col-xl-8 mx-0 mx-xl-auto px-0">
                <div class="col-12 mx-0 px-0 row">
                    <div class="col-10 col-md-4 row px-0 mx-auto mx-md-0 border border-secondary">
                        <div class="col-12 text-center ocupado">ocupado</div>
                    </div>
                    <div class="col-10 col-md-4 row px-0 mx-auto mx-md-0 border border-secondary">
                        <div class="col-12 text-center libre">libre</div>
                    </div>
                    <div class="col-10 col-md-4 row px-0 mx-auto mx-md-0 border border-secondary">
                        <div class="col-12 text-center apartado">seleccionado</div>
                    </div>

                </div>
                <form id="pasajerosAsientos" action="{{route('venta.interna.apartar')}}" method="post" class="">
                    @csrf
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
                    <div class="col-12">
                        <button id="btn-apartar" hidden>Apartar</button>
                    </div>
                </form>
            </div>
        </div>
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
    <select class="listaPasajeroTipo form-control form-control-sm px-1" required last="">
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
