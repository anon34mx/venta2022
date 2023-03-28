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
    <h3>Promociones</h3>
    <a href="{{route('promociones.create')}}">
        <span class="btn-collap" title="Añadir">
            <label class="btn btn-sm btn-primary float-right"
                for="addpermission">
                <i class="fa-solid fa-circle-plus"></i>
                <span>Añadir</span>
            </label>
            <input id="addpermission" type="submit"
            class="btn" >
        </span>
    </a>
    <div style="
        width: 100%;
        height: 50vh;
        overflow: auto;
    ">
        <table class="table table-stripped table-parhi">
            <thead style="
                position: sticky;
                top: 0px;
            ">
                <tr>
                    <th>Descripción</th>
                    <th>Pasajero</th>
                    <th>Corrida</th>
                    <th>Oficina</th>
                    <th>Origen</th>
                    <th>Destino</th>
                    <th>Viaje redondo</th>
                    <th>Tipo servicio</th>
                    <th>% descuento</th>
                    <th>Vigencia</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                @foreach($promociones as $promocion)
                    <tr>
                        <td>{{@$promocion->aDescripcion ?: "-"}}</td>
                        <td>{{@$promocion->tipoPasajero->aDescripcion ?: "-"}}</td>
                        <td>{{@$promocion->nCorridaProgramada ?: "-"}}</td>
                        <td>{{@$promocion->nOficina ?: "-"}}</td>
                        <td>{{@$promocion->nOrigen ?: "-"}}</td>
                        <td>{{@$promocion->nDestino ?: "-"}}</td>
                        <td>{{@$promocion->viajeRedondo ?: "-"}}</td>
                        <td>{{@$promocion->nTipoServicio ?: "-"}}</td>
                        <td>{{@$promocion->nDescuento ?: "-"}}</td>
                        <td>{{@$promocion->fInicio}} - {{$promocion->fFin}}</td>
                        <td colspan="1">
                            <a href="{{route('promociones.edit', $promocion)}}">
                                <span class="btn-collap" title="Editar">
                                <label class="btn btn-sm btn-primary" for="edit-{{$promocion}}">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                    <span>Editar</span>
                                </label>
                                <input id="edit-{{$promocion}}" type="submit" class="btn" onclick="">
                            </span>
                            </a>


                            <span class="btn-collap" title="Eliminar">
                                <label class="btn btn-sm btn-danger" for="del">
                                    <i class="fa-solid fa-circle-minus"></i>
                                    <span>Eliminar</span>
                                </label>
                                <input id="del" type="submit" class="btn" onclick="return confirm('¿Eliminar usuario?')">
                            </span>
                        </td>
                    </tr>
                @endforeach
            </tbody>
        </table>
    </div>
</div>
@endsection
