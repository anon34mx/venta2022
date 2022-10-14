@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    <h3 class="titleWithAnchor" id="nuevoUsuario">
        <a href="#nuevoUsuario">Filtros</a>
    </h3>

    <form action method="POST" class="row needs-validation" novalidate>
        <div class="col-12 col-lg-6 col-xl-4 row mb-2">
            <div class="col-12 col-md-4">
                <label for="tipoDeViaje" class="float-md-right text-md-right">Tipo de viaje*</label>
            </div>
            <div class="col-12 col-md-8">
                <select name="tipoDeViaje" id="tipoDeViaje" class="form-control">
                    <option value="" disabled selected>Elije uno</option>
                    <option value="sencillo" >Viaje sencillo</option>
                    <option value="redondo" >Viaje redondo</option>
                </select>
            </div>
        </div>
    </form>
</div>
@endsection
