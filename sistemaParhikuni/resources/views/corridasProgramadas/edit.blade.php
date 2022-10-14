@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
    <h3>Corrida programada {{ $corridaProgramada->nNumero }}</h3>

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

    
    <form action="" class="row needs-validation">
        <div class="col-12 row mb-2">
            <div class="col-12 col-md-4 col-lg-3">
                <label for="itinerario" class="float-md-right text-md-right">Itinerario*</label>
            </div>
            <div class="col-12 col-md-8 col-lg-9">
                <select name="itinerario" id="itinerario" class="form-control">
                    <option value="" disabled>seleccione</option>
                    @foreach($itinerarios as $itinerario=>$tramos)
                        <option value="{{ $itinerario }}" {{ ($itinerario==$corridaProgramada->nItinerario) ? "selected": ""}}>
                            @for($i=0; $i<sizeof($tramos);$i++)
                                @if($i==sizeof($tramos)-1)
                                    {{($tramos[$i]->claveOrigen)}} ➡ {{($tramos[$i]->claveDestino)}}
                                @else
                                    {{($tramos[$i]->claveOrigen)}} ➡
                                @endif
                            @endfor
                        </option>
                    @endforeach

                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="tipoDeServicio" class="float-md-right text-md-right">Tipo de servicio*</label>
            </div>
            <div class="col-12 col-md-8">
                <select name="tipoDeServicio" id="tipoDeServicio" class="form-control">
                    <option value="" disabled>Seleccione</option>
                    @foreach($servicios as $servicio)
                        <option value="{{($servicio->nNumero)}}">{{($servicio->aDescripcion)}}</option>
                    @endforeach
                </select>
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="horaDeSalida" class="float-md-right text-md-right">Hora de salida*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="horaDeSalida" type="time" name="horaDeSalida" placeholder="Apellidos" class="form-control"
                    value="{{$corridaProgramada->hSalida}}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeInicio" class="float-md-right text-md-right">Fecha de inicio*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="fechaDeInicio" type="date" name="fechaDeInicio" placeholder="Apellidos" class="form-control"
                    value="{{$corridaProgramada->fInicio}}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeFin" class="float-md-right text-md-right">Fecha de fin*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="fechaDeFin" type="date" name="fechaDeFin" placeholder="Apellidos" class="form-control"
                    value="{{$corridaProgramada->fFin}}">
            </div>
        </div>
        <table class="table mb-2 mx-4">
            <tr>
                <td>
                    <input id="lunes" type="checkbox" class="form-check-input" name="lunes"
                        {{ ($corridaProgramada->lLunes==true) ? "checked" : ""}}>
                    <label for="lunes" class="px-2">L</label>
                </td>
                <td>
                    <input id="martes" type="checkbox" class="form-check-input" name="martes"
                        {{ ($corridaProgramada->lMartes==true) ? "checked" : ""}}>
                    <label for="martes" class="px-2">M</label>
                </td>
                <td>
                    <input id="miercoles" type="checkbox" class="form-check-input" name="miercoles"
                        {{ ($corridaProgramada->lMiercoles==true) ? "checked" : ""}}>
                    <label for="miercoles" class="px-2">I</label>
                </td>
                <td>
                    <input id="jueves" type="checkbox" class="form-check-input" name="jueves"
                        {{ ($corridaProgramada->lJueves==true) ? "checked" : ""}}>
                    <label for="jueves" class="px-2">J</label>
                </td>
                <td>
                    <input id="viernes" type="checkbox" class="form-check-input" name="viernes"
                        {{ ($corridaProgramada->lViernes==true) ? "checked" : ""}}>
                    <label for="viernes" class="px-2">V</label>
                </td>
                <td>
                    <input id="sabado" type="checkbox" class="form-check-input" name="sabado"
                        {{ ($corridaProgramada->lSabado==true) ? "checked" : ""}}>
                    <label for="sabado" class="px-2">S</label>
                </td>
                <td>
                    <input id="domingo" type="checkbox" class="form-check-input" name="domingo"
                        {{ ($corridaProgramada->lDomingo==true) ? "checked" : ""}}>
                    <label for="domingo" class="px-2">D</label>
                </td>
            </tr>
        </table>
    </form>
</div>
@endsection