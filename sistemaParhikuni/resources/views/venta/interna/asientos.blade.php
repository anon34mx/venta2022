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
$totalPasajeros=$pasajeros['AD']+$pasajeros['NI']+$pasajeros['IN']+$pasajeros['MA']+$pasajeros['ES'];
$contAuxPasajeros=0;
@endphp
<div class="col-12 row px-0 mx-0">
    <h3>ASIENTOS</h3>
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
    <div class="col-8">
        <form id="pasajerosAsientos" action="{{route('corridas.disponibles.apartar')}}" method="post">
            @csrf
            <input type="text" hidden name="cor" value="{{ Request::get('cor') }}">
            <input type="text" hidden name="disp" value="{{ Request::get('disp') }}">
            <input type="text" hidden name="adultos" value="{{ Request::get('adultos') }}">
            <input type="text" hidden name="niños" value="{{ Request::get('niños') }}">
            <input type="text" hidden name="insen" value="{{ Request::get('insen') }}">
            <input type="text" hidden name="profesores" value="{{ Request::get('profesores') }}">
            <input type="text" hidden name="estudiantes" value="{{ Request::get('estudiantes') }}">
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
                    @php
                        $aux=0;
                    @endphp
                    @foreach($pasajeros as $tipo=>$cantidad)
                        @for($a=0; $a<$cantidad && $cantidad>0; $a++)
                            <tr id="pasajero-{{$a}}" class="pt-1 pb-1 pasajeroContainer">
                                <td>
                                    <label for="" class="pasajeroTipo form-control">{{$tipo}}</label>
                                    <input hidden class="pasajeroTipo form-control" readonly name="pasajeroTipo[]" value="{{$tipo}}" tabindex="-1" style="pointer-events:none;">
                                </td>
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
                                    <input class="form-control pasajeroNombre" type="text" name="pasajero[{{$contAuxPasajeros}}]"
                                        value="">
                                </td>
                                <!-- <td><button>delete</button></td> -->
                            </tr>
                            @php
                                $contAuxPasajeros++;
                            @endphp
                        @endfor
                        @php
                            $aux=$aux+1;
                        @endphp 
                    @endforeach
                    <!-- endif -->
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
            <label class="btn btn-sm btn-danger float-right"
                for="">
                <i class="fa-solid fa-arrow-left-long"></i>
                <span>Volver</span>
            </label>
        </span>
    
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