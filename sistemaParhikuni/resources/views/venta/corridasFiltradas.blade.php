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


<div class="col-12 row px-0 mx-0">
    <form action="#" class="col-12 col-sm-3 row px-0 mx-0 " style="height: fit-content;display: block;position: sticky;top: 70px;">
        <h3 class="titleWithAnchor" id="nuevoUsuario">
            <a href="#nuevoUsuario">Filtros</a>
        </h3>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Tipo de viaje</div>
            <div class="px-0 col-12 col-lg-6">
                <label for="viajeSencillo" class="">sencillo</label>
                <input class="" type="radio" id="viajeSencillo" name="tipoDeViaje" value="sencillo">
            </div>
            <div class="px-0 col-12 col-lg-6">
                <label for="viajeRedondo" class="">redondo</label>
                <input class="" type="radio" id="viajeRedondo" name="tipoDeViaje" value="redondo" checked>
            </div>
        </div>
        @if(Auth::user()->hasRole('Admin'))
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Corrida</div>
            <div class="px-0 col-12">
                <input type="text" class="form-control" name="corrida">
            </div>
        </div>
        @endif
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Origen</div>
            <div class="px-0 col-12">
                <select class="form-control" name="origen" id="origen" onChange="cargarDestinos(this.value,false)">
                    <option value="" >Seleccione Origen</option>
                    @foreach($oficinas as $key)
                        <option value="{{$key["nNumero"]}}" {{@$key['nNumero']==@$origen->nNumero ? "selected": "" }} >{{@$key["origen"]}}</option>
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Destino</div>
            <div class="px-0 col-12">
                <select class="form-control" name="destino" id="destino">
                    <option value="" >Seleccione Destino</option>
                    @foreach($oficinas as $key)
                        <option value="{{$key['nNumero']}}" {{@$key['nNumero']==@$destino->nNumero ? "selected": "" }}>{{@$key["origen"]}}</option>
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Fecha</div>
            <div class="px-0 col-12">
                <input class="form-control" type="date" min="{{date('Y-m-d')}}" name="fechaDeSalida" value="{{ $fechaDeSalida!='' ? $fechaDeSalida : date('Y-m-d') }}">
            </div>
        </div>
        <!-- <div class="col-12 col-sm-3 row px-0 mx-0 pt-4" style="height: fit-content;display: block;position: sticky;top: 0px;"> -->
            <div class="col-12 row mx-0">
                <div class="col-6 col-md-6 col-lg-3"><button onclick="preventDefault()">mad</button></div>
                <div class="col-6 col-md-6 col-lg-3"><button onclick="preventDefault()">mañ</button></div>
                <div class="col-6 col-md-6 col-lg-3"><button onclick="preventDefault()">tar</button></div>
                <div class="col-6 col-md-6 col-lg-3"><button onclick="preventDefault()">noc</button></div>
            </div>
            <div class="col-6 col-sm-12 row mx-0">
                <div class="col-12">Adultos</div>
                <div class="col-3">
                    <button class="cantidadPasajeros" value="+">+</button>
                </div>
                <div class="col-6">
                    <input class="col-12" type="text" value="{{$adultos}}" step="1" min="0" max="10">
                </div>
                <div class="col-3">
                    <button class="cantidadPasajeros" value="-">-</button>
                </div>
            </div>
            <div class="col-6 col-sm-12 row mx-0">
                <div class="col-12">Menores</div>
                <div class="col-3">
                    <button class="cantidadPasajeros" value="+">+</button>
                </div>
                <div class="col-6">
                    <input class="col-12" type="text" value="{{$niños}}" step="1" min="0" max="10">
                </div>
                <div class="col-3">
                    <button class="cantidadPasajeros" value="-">-</button>
                </div>
            </div>
            <div class="col-6 col-sm-12 row mx-0">
                <div class="col-12">INSEN</div>
                <div class="col-3">
                    <button class="cantidadPasajeros" value="+">+</button>
                </div>
                <div class="col-6">
                    <input class="col-12" type="text" value="{{$insen}}" step="1" min="0" max="10">
                </div>
                <div class="col-3">
                    <button class="cantidadPasajeros" value="-">-</button>
                </div>
            </div>
            <div class="col-6 col-sm-12 row mx-0">
                <button>Filtrar</button>
            </div>
        <!-- </div> -->
    </form>


    <div class="col-12 col-sm-9 row pr-0">
        <form id="tbl-corridas" action="{{route('corridas.disponibles.asientos')}}" class="pr-0">
            <table class="table table-parhi" style="">
                <thead style="position: sticky;top: 69px;">
                    <tr>
                        <th>corrida</th>
                        <!-- <th>estado</th> -->
                        <!-- <th>disp</th> -->
                        <th>Servicio</th>
                        <th >Salida</th>
                        <th>Llegada</th>
                        <th>Origen
                            <br> 
                            Destino</th>
                        <th>Tarifa</th>
                        <th>Ocupacion</th>
                        <th>Itinerario</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($corridas as $corrida)
                    @if($corrida->estado=='B' || $corrida->estado=='C' || $corrida->estado=='T' || $corrida->estado=='L')
                        <tr class="bg-danger text-danger">
                    @elseif($corrida->aEstadoNuevo=="S")
                        <tr class="bg-warning text-warning">
                    @else
                        <tr class="" onclick="seleccionarCorrida(this,'{{$corrida->corrida}}','{{$corrida->disp}}')">
                    @endif
                            <td>{{$corrida->corrida}}
                                <br>
                                {{$corrida->aEstadoNuevo!="" ? $corrida->aEstadoNuevo : $corrida->estado}}
                            </td>
                            <!-- <td>{{$corrida->disp}}</td> -->
                            <td>{{($corrida->claseServicio)}}</td>
                            <td class="fecha">{{($corrida->fSalida)}}<br>{{($corrida->hSalida)}}</td>
                            <td class="fecha">{{($corrida->fLlegada)}}<br>{{($corrida->hLlegada)}}</td>
                            <td>{{$corrida->origen}}<br>{{$corrida->destino}}</td>
                            <td>${{number_format($corrida->tarifaBase + $corrida->iva,2)}}</td>
                            <td>
                                <span class="ocupados">{{$corrida->ocupados}}</span>
                                /
                                <span class="totalAsientos">{{$corrida->totalAsientos}}</span>
                            </td>
                            <td><button onclick="event.preventDefault();getRecorrido({{$corrida->corrida}},{{$corrida->nOrigen}}, {{$corrida->nDestino}})" >Ver</button></td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <input id="corr" name="cor" type="" value="x">
            <input id="disp" name="disp" type="" value="s">
            <div class="col-12">
                <span class="btn-collap float-right mx-1" title="Continuar">
                    <label for="Continuar" class="btn btn-sm btn-parhi-primary">
                        <i class="fa-solid fa-arrow-right"></i>
                        <span>Continuar</span>
                    </label>
                    <input id="Continuar" class="btn" type="submit">
                </span>
            </div>
        </form>
    </div>
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
