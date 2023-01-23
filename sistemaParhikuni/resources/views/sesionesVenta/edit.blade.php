@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-11 mx-auto">
    <h3>Corte de venta, sesión{{ @$sesion->nNumero }}</h3>

    <div>
        @if(session()->has('status'))
            <p class="alert alert-success">{{session('status')}}</p>
        @endif
    </div>
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    <form action="{{route('sesionesventa.update', $sesion)}}" class="col-6 row mx-auto" method="post">
        @csrf
        <div class="col-12 row my-4">
            <label class="col-6 row">
                Recibido
            </label>
            <div class="col-6 row">
                <input class="form-control form-control-sm" type="number" name="recibido" step="0.5" min="0">
            </div>
        </div>
        <div class="col-12 justify-content-center my-4">
            <span class="btn-collap float-right" title="Guardar">
                <label class="btn btn-sm btn-parhi-primary"
                    for="guardar">
                    <i class="fa-solid fa-floppy-disk"></i>
                    <span>Guardar</span>
                </label>
                <input id="guardar" type="submit"
                class="btn">
            </span>
        </div>
    </form>
</div>
@endsection