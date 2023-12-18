@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 mx-auto">
    <h3 class="mt-4">Paquetería</h3>

    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif

    <a href="{{route('paqueteria.create')}}">
        <span class="btn-collap col-auto float-right" title="Buscar">
            <label class="btn btn-sm btn-parhi-primary" for="busc-rem">
                <i class="fa-solid fa-circle-plus"></i>
                <span>Registrar envío</span>
            </label>
            <!-- <input id="del-" type="submit" class="btn" onclick="event.preventDefault()"> -->
            <button id="busc-rem" type="button" class="btn btn-primary hidden" data-toggle="modal" data-target="#modl-busc-rem"></button>
        </span>
    </a>
<!--
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modl-busc-rem">
  Launch demo modal
</button>

<div class="modal fade" id="modl-busc-rem" tabindex="-1" role="dialog" aria-labelledby="modl-busc-remLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modl-busc-remLabel">Buscar remitente</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        Cargando...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
-->
</div>
@endsection