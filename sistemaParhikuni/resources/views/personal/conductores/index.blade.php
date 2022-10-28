@extends('layouts.parhikuni')

@section('content')

<div class="col-12">

<table class="table table-stripped table-parhi">
    <thead>
        <tr>
            <th>Clave</th>
            <th>Nombre(s)</th>
            <th>Apellido(s)</th>
            <th>Oficina</th>
            <!-- <th>Licencia</th> -->
            <!-- <th>Vigencia licencia</th> -->
            <th>Estado</th>
            <th>Autobus</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        @foreach($conductores as $conductor)
            <tr class="{{$conductor->estado->aClave=='BA' ? 'text-danger' : ''}}"">
                <td>{{$conductor->nNumeroConductor}}</td>
                <td>{{$conductor->persona->aNombres}}</td>
                <td>{{$conductor->persona->aApellidos}}</td>
                <td>{{ $conductor->persona->oficina->aNombre }}</td>
                <!-- <td>{{$conductor->aLicencia}}</td> -->
                <!-- <td>{{$conductor->fVigenciaLicencia}}</td> -->
                <td>{{$conductor->estado->descripcion}}</td>
                <td>{{$conductor->autobus->nNumeroEconomico}}</td>
                <td>
                    @if($conductor->estado->aClave=='BA')
                        <span class="btn-collap" title="Editar">
                            <label class="btn btn-sm btn-danger"
                                for="edit-{{$conductor->nNumeroConductor}}">
                                <i class="fa-solid fa-x"></i>
                                <span>Baja</span>
                            </label>
                            <input id="edit-{{$conductor->nNumeroConductor}}" type="submit"
                            class="btn" onclick="">
                        </span>
                    @else
                    <a href="{{ route('personal.conductores.edit', $conductor->nNumeroConductor) }}">
                        <span class="btn-collap" title="Editar">
                            <label class="btn btn-sm btn-primary"
                                for="edit-{{$conductor->nNumeroConductor}}">
                                <i class="fa-solid fa-pen-to-square"></i>
                                <span>Editar</span>
                            </label>
                            <input id="edit-{{$conductor->nNumeroConductor}}" type="submit"
                            class="btn" onclick="">
                        </span>
                    </a>
                    @endif
                </td>
            </tr>
        @endforeach
    </tbody>
</table>

</div>

@endsection