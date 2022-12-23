@extends('layouts.parhikuni')

@section('content')
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

@php
$totalPasajeros=$pasajeros['adulto']+$pasajeros['niño']+$pasajeros['insen']+$pasajeros['profesores']+$pasajeros['estudiantes'];
$contAuxPasajeros=0;
@endphp
<div class="col-12 row px-0 mx-0">
    <h3>ASIENTOS</h3>
    <table style="width:200px">
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
                        @elseif($col=="BH")
                        [bh]
                        @elseif($col=="BM")
                        [bm]
                        @elseif($col=="CA")
                        ca
                        @else
                            @php
                            $numAsiento=substr($col,0,2);
                            $ocupado=0;
                            // if($contAuxAsien<$sizeAsientos){
                                // $ocupado=str_pad($asientosOcupados[$contAuxAsien], 2, "0", STR_PAD_LEFT);
                            // }
                            @endphp
                            <!-- {{$contAuxAsien}} / {{$sizeAsientos}} -->
                            <!-- if( $numAsiento == $ocupado) -->
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
                                        <!-- src="{{ Vite::asset('resources/images/asientos/asientolibreTV.png') }}"> -->
                                        <span>{{$numAsiento}}</span>
                                    </div>
                                @else
                                    <div id="asiento-{{$numAsiento}}" class="asiento" numero="{{$numAsiento}}">
                                        <img alt="Libre" style=""
                                        class="logo-color mx-auto my-0">
                                        <!-- src="{{ Vite::asset('resources/images/asientos/asientolibre.png') }}"> -->
                                        <span>{{$numAsiento}}</span>
                                    </div>
                                @endif
                            @endif
                            <!-- if(strpos($col,"T")=="")
                                <img alt="" style="" width="34"
                                class="logo-color mx-auto my-3" src="{{ Vite::asset('resources/images/asientos/asientolibre.png') }}">
                            else
                                <img alt="" style="" width="34"
                                class="logo-color mx-auto my-3" src="{{ Vite::asset('resources/images/asientos/asientolibreTV.png') }}">
                            endif -->
                        @endif
                    </td>
                @endforeach
            </tr>
            @php
            // break;
            @endphp
        @endforeach
    </table>
    <div class="col-8">
        <form id="pasajerosAsientos" action="{{route('corridas.disponibles.apartar')}}" method="post" >
            @csrf
            <input type="text" name="cor" value="{{ Request::get('cor') }}">
            <input type="text" name="disp" value="{{ Request::get('disp') }}">
            <input type="text" name="adultos" value="{{ Request::get('adultos') }}">
            <input type="text" name="niños" value="{{ Request::get('niños') }}">
            <input type="text" name="insen" value="{{ Request::get('insen') }}">
            <input type="text" name="profesores" value="{{ Request::get('profesores') }}">
            <input type="text" name="estudiantes" value="{{ Request::get('estudiantes') }}">
            <table class="tbl-datosPasajeros">
                <thead>
                    <tr>
                        <th colspan="5">Pasajeros</th>
                    </tr>
                    <tr>
                        <th>Tipo</th>
                        <th>Asiento</th>
                        <th>Nombre</th>
                        <!-- <th>*</th> -->
                    </tr>
                </thead>
                <tbody>
                    @foreach($pasajeros as $tipo=>$cantidad)
                        @for($a=0; $a<$cantidad && $cantidad>0; $a++)
                            <tr id="pasajero-{{$a}}" class="pt-1 pb-1 pasajeroContainer">
                                <td> <input class="pasajeroTipo form-control" readonly name="pasajeroTipo[]" value="{{$tipo}}"> </td>
                                <td>
                                    <select name="asiento[{{$contAuxPasajeros}}]" id="asiento[{{$contAuxPasajeros}}]" class="form-control pasajeroAsiento">
                                        <option value="">Seleccionar</option>
                                        @for($i=1; $i<=$cordis->autobus->distribucionAsientos->nAsientos; $i++)
                                            <option class="{{str_pad(substr($i,0,2), 2, '0', STR_PAD_LEFT)}}"
                                                value="{{str_pad(substr($i,0,2), 2, '0', STR_PAD_LEFT)}}">
                                                {{$i}}
                                            </option>
                                        @endfor
                                    </select>
                                </td>
                                <td >
                                    <input class="form-control pasajeroNombre" type="text" name="pasajero[{{$contAuxPasajeros}}]" value="">
                                </td>
                                <!-- <td><button>delete</button></td> -->
                            </tr>
                            @php
                                $contAuxPasajeros++;
                            @endphp
                        @endfor
                    @endforeach
                </tbody>
            </table>
            <div class="col-12">
                <button id="btn-apartar" hidden>Apartar</button>
            </div>
        </form>
    </div>
    <div class="col-12">
        <label for="btn-apartar">
            <span>Apartar</span>
        </label>
    </div>
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
@endsection
