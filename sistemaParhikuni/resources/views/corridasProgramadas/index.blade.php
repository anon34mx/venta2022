@extends('layouts.parhikuni')

@section('content')
<div class="col-12">
    <table class="table table-stripped table-parhi">
        <thead>
            <tr>
                <th>Clave</th>
                <th>Itinerario</th>
                <th>Tipo Servicio</th>
                <th>Hora</th>
                <th>L</th>
                <th>M</th>
                <th>I</th>
                <th>J</th>
                <th>V</th>
                <th>S</th>
                <th>D</th>
                <th>Inicio</th>
                <th>Fin</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            @foreach($corridasProgramadas as $cp)
            <tr>
                <td>{{$cp->nNumero}}</td>
                <td>{{$cp->nItinerario}}</td>
                <td>{{$cp->nTipoServicio}}</td>
                <td>{{$cp->hSalida}}</td>
                <td>{{ ($cp->lLunes == 1 ? "✔" :"") }}</td>
                <td>{{ ($cp->lMartes == 1 ? "✔" :"") }}</td>
                <td>{{ ($cp->lMiercoles == 1 ? "✔" :"") }}</td>
                <td>{{ ($cp->lJueves == 1 ? "✔" :"") }}</td>
                <td>{{ ($cp->lViernes == 1 ? "✔" :"") }}</td>
                <td>{{ ($cp->lSabado == 1 ? "✔" :"") }}</td>
                <td>{{ ($cp->lDomingo == 1 ? "✔" :"") }}</td>

                <td>{{$cp->fInicio}}</td>
                <td>{{$cp->fFin}}</td>
                <td>
                    <a href="{{ route('corridas.programadas.edit', $cp->nNumero) }}">
                        <span class="btn-collap" title="Editar">
                            <label class="btn btn-sm btn-primary"
                                for="edit-{{$cp->nNumero}}">
                                <i class="fa-solid fa-pen-to-square"></i>
                                <span>Editar</span>
                            </label>
                            <input id="edit-{{$cp->nNumero}}" type="submit"
                            class="btn" onclick="">
                        </span>
                    </a>
                </td>
            </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection