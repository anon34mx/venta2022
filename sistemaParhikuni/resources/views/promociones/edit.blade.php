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
    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
    <h3>Editar promoción</h3>
    <form action="{{route('promociones.update', $promocion)}}" class="col-12 row mx-0 px-0 needs-validation" novalidate method="post">
        <div class="col-12 col-md-6 row mx-0 mt-2">
            <div class="col-12 col-sm-6">
                <label for="" class="col-12">Descripción</label>
            </div>
            <div class="col-12 col-sm-6">
                <input name="descripcion" class="form-control col-12" type="text" value="{{$promocion->aDescripcion}}" required>
            </div>
        </div>
        <div class="col-12 col-md-6 row mx-0 mt-2">
            <div class="col-12 col-sm-6">
                <label for="" class="col-12">% descuento</label>
            </div>
            <div class="col-12 col-sm-6">
                <input name="descuento" class="form-control col-12" type="number" value="{{$promocion->nDescuento}}" min="1" max="99" required>
            </div>
        </div>
        <div class="col-12 col-md-6 row mx-0 mt-2">
            <div class="col-12 col-sm-6">
                <label for="" class="col-12">Aplicar por</label>
            </div>
            <div class="col-12 col-sm-6">
                @if($promocion->aTipo!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Tipo de pasajero" required>
                    <!-- <input readonly disabled value="pasajero" required> -->
                @elseif($promocion->nCorridaProgramada!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Corrida programada" required>
                    <!-- <input readonly disabled value="corrida" required> -->
                @elseif($promocion->nOficina!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Oficina de venta" required>
                    <!-- <input readonly disabled value="oficina" required> -->
                @elseif($promocion->nOrigen!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Origen" required>
                    <!-- <input readonly disabled value="origen" required> -->
                @elseif($promocion->nDestino!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Destino" required>
                    <!-- <input readonly disabled value="destino" required> -->
                @elseif($promocion->viajeRedondo!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Viaje redondo" required>
                    <!-- <input readonly disabled value="redondo" required> -->
                @elseif($promocion->nTipoServicio!=null)
                    <input class="col-12 form-control" type="text" readonly disabled value="Tipo de servicio" required>
                    <!-- <input readonly disabled value="servicio" required> -->
                @endif
            </div>
        </div>
        <div class="col-12 col-md-6 row mx-0 mt-2">
            <div class="col-12 col-sm-6">
                <label for="" class="col-12">Inicio</label>
            </div>
            <div class="col-12 col-sm-6">
                <input name="fechaDeInicio" class="form-control col-12" type="date" value="{{$promocion->fInicio}}" required>
            </div>
        </div>
        <div class="col-12 col-md-6 row mx-0 mt-2">
            <div class="col-12 col-sm-6">
                <label for="" class="col-12">Fin</label>
            </div>
            <div class="col-12 col-sm-6">
                <input name="fechaDeFin" class="form-control col-12" type="date" value="{{$promocion->fFin}}" required>
            </div>
        </div>
        <div class="col-12 my-3">
            <span class="btn-collap col-auto" title="Guardar">
                <label class="btn btn-sm btn-parhi-primary float-right" for="guardar">
                <i class="fa-solid fa-floppy-disk"></i>
                <span>Guardar</span>
                </label>
                <input id="guardar" type="submit" class="btn" hidden required>
            </span>
            @csrf
        </div>
    </form>
</div>
@endsection
