@vite([
    'resources/js/controlador_admin.js'
    ])
@extends('layouts.parhikuni')
@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 px-0">
    <h3>TITULO</h3>
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
    <br>
        <form action="{{route('promociones.store')}}" class="col-12 mx-auto row needs-validation" novalidate method="post">
            <div class="col-12 mt-1">
                <div class="col-12">
                    <label class="my-0" for="">Descripción</label>
                </div>
                <div class="col-12">
                    <input class="form-control" type="text" maxlength="20" value="" name="descripcion" required>
                </div>
            </div>
            <div class="col-12 mt-1">
                <div class="col-12">
                    <label class="my-0" for="">Aplicable a</label>
                </div>
                <div class="col-12">
                    <select id="aplicarPromoA" name="aplicarPromoA" class="form-control" required>
                        <option value="">Seleccione</option>
                        <option value="viajeRedondo">Viaje redondo</option>
                        <option value="tipoDePasajero">Tipo de pasajero</option>
                        <option value="tipoDeServicio">Tipo de servicio</option>
                        <option value="corridaProgramada">Corrida programada</option>
                        <option value="Oficina">Oficina</option>
                        <option value="Origen">Origen</option>
                        <option value="Destino">Destino</option>
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1">
                <div class="col-12">
                    <label class="my-0" for="">Descuento</label>
                </div>
                <div class="col-12">
                    <input class="form-control" name="descuento" id="descuento" type="number" step="1" min="1" max="100" placeholder="1-100%" required>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1">
                <div class="col-12">
                    <label class="my-0" for="">Inicio</label>
                </div>
                <div class="col-12">
                    <input id="fechaDeInicio" name="fechaDeInicio" class="form-control" type="date" min="{{date('Y-m-d')}}" required>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1">
                <div class="col-12">
                    <label class="my-0" for="">Fin</label>
                </div>
                <div class="col-12">
                    <input id="fechaDeFin" name="fechaDeFin" class="form-control" type="date" required>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1 aplicarPor hidden tipoDePasajero">
                <div class="col-12">
                    <label class="my-0" for="">Tipo de pasajero</label>
                </div>
                <div class="col-12">
                    <select class="form-control" name="tipoPasajero" id="tipoPasajero">
                        <option value="">seleccione</option>
                        @foreach($tiposPasajeros as $tipoPasajero)
                            <option value="{{$tipoPasajero->aClave}}">{{$tipoPasajero->aDescripcion}}</option>
                        @endforeach
                    </select>
                </div>
            </div>




            <div class="col-12 col-sm-6 col-md-4 mt-1 aplicarPor hidden tipoDeServicio">
                <div class="col-12">
                    <label class="my-0" for="">Tipo de servicio</label>
                </div>
                <div class="col-12">
                    <select class="form-control" name="tipoDeServicio" id="tipoDeServicio">
                        <option value="">seleccione</option>
                        @foreach($tiposServicios as $tipoServicio)
                            <option value="{{$tipoServicio->aClave}}">{{$tipoServicio->aDescripcion}}</option>
                        @endforeach
                    </select>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-md-4 mt-1 aplicarPor hidden corridaProgramada">
                <div class="col-12">
                    <label class="my-0" for="">Corrida programada</label>
                </div>
                <div class="col-12">
                    <input class="form-control" name="corridaProgramada" id="corridaProgramada" type="number" min="1">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1 aplicarPor hidden Oficina">
                <div class="col-12">
                    <label class="my-0" for="">Área de venta</label>
                </div>
                <div class="col-12">
                    <select class="form-control" name="areaDeVenta" id="areaDeVenta">
                        <option value="">Seleccione</option>
                        @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1 aplicarPor hidden Origen">
                <div class="col-12">
                    <label class="my-0" for="">Origen</label>
                </div>
                <div class="col-12">
                    <select class="form-control" name="origen" id="origen">
                        <option value="">Seleccione</option>
                        @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-md-4 mt-1 aplicarPor hidden Destino">
                <div class="col-12">
                    <label class="my-0" for="">Destino</label>
                </div>
                <div class="col-12">
                    <select class="form-control" name="destino" id="destino">
                        <option value="">Seleccione</option>
                        @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12">
                @csrf
                <span class="btn-collap col-auto float-right" title="Guardar">
                    <label class="btn btn-sm btn-parhi-primary"
                        for="guardar">
                    <i class="fa-solid fa-floppy-disk"></i>
                    <span>Guardar</span>
                    </label>
                    <input id="guardar" type="submit" class="btn">
                </span>
            </div>
        </form>
</div>
@endsection
