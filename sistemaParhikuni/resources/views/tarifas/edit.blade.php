@extends('layouts.parhikuni')
@section('content')
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    @if (session('status'))
        <div class="alert alert-success alert-float-br">
            {{ session('status') }}
        </div>
    @endif
<div class="mx-auto col-12 col-sm-11 col-md-11 col-lg-11 px-0 row mx-auto">
    <h4>Tarifas</h4>
        <form class="col-12 row mx-0" method="post" action="{{route('tarifas.update', $tarifa)}}">
            <div class="col-12 col-sm-6 col-lg-4 row mx-0 my-1">
                <label for="claseDeServicio" class="col-12 col-sm-6">Servicio</label>
                <div class="col-12 col-sm-6">
                    <select name="claseDeServicio" id="claseDeServicio" class="form-control form-control-sm" required>
                        <option value="">Seleccione</option>
                        @foreach($TiposServicios as $tipoServicio)
                            <option value="{{$tipoServicio->nNumero}}"
                                {{ $tipoServicio->nNumero==$tarifa->nTipoServicio ? "selected": ""}}
                                >{{$tipoServicio->aDescripcion}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4 row mx-0 my-1">
                <label for="origen" class="col-12 col-sm-6">Origen</label>
                <div class="col-12 col-sm-6">
                    <select name="origen" id="origen" class="form-control form-control-sm" required>
                        <option value="">Seleccione</option>
                        @foreach($oficinas as $oficina)
                            <option value="{{$oficina->nNumero}}"
                                {{ $oficina->nNumero==$tarifa->nOrigen ? "selected": ""}}
                            >{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4 row mx-0 my-1">
                <label for="destino" class="col-12 col-sm-6">Destino</label>
                <div class="col-12 col-sm-6">
                    <select name="destino" id="destino" class="form-control form-control-sm" required>
                        <option value="">Seleccione</option>
                        @foreach($oficinas as $oficina)
                            <option value="{{$oficina->nNumero}}"
                                {{ $oficina->nNumero==$tarifa->nDestino ? "selected": ""}}
                            >{{$oficina->aNombre}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4 row mx-0 my-1">
                <label for="tarifaBaseRuta" class="col-12 col-sm-6">Tarifa base ruta</label>
                <div class="col-12 col-sm-6">
                    <input id="tarifaBaseRuta" name="tarifaBaseRuta" class="form-control form-control-sm" type="number" placeholder="$00.00" min="0" step="0.1" required
                        value="{{$tarifa->nMontoBaseRuta}}">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4 row mx-0 my-1">
                <label for="tarifaBasePaqueteria" class="col-12 col-sm-6">Tarifa base paquetería</label>
                <div class="col-12 col-sm-6">
                    <input id="tarifaBasePaqueteria" name="tarifaBasePaqueteria" class="form-control form-control-sm" type="number" placeholder="$00.00" min="0" step="0.1" required
                        value="{{$tarifa->nMontoBasePaqueteria}}">
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-4 row mx-0 my-1">
                <label for="fechaAplicacion" class="col-12 col-sm-6">Fecha aplicación</label>
                <div class="col-12 col-sm-6">
                    <input id="fechaAplicacion" name="fechaAplicacion" class="form-control form-control-sm" type="date" placeholder="__/__/__" step="0.1" required min="{{date('Y-m-d')}}"
                    value="{{$tarifa->fAplicacion}}">
                </div>
            </div>
            @csrf
            <input id="btn-guardar" type="submit" hidden>
        </form>
        <div class="col-12 my-4">
            <span class="btn-collap float-right" title="Eliminar">
                <label class="btn btn-sm btn-parhi-primary"
                    for="btn-guardar">
                    <i class="fa-solid fa-floppy-disk"></i>
                    <span>Guardar</span>
                </label>¿
            </span>
        </div>
</div>
@endsection