@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
    <h3>Corrida programada {{ @$corridaProgramada->nNumero }}</h3>

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

    <div class="row needs-validation">
        <div class="col-12 row mb-2">
            <div class="col-12 col-md-4 col-lg-3">
                <label for="itinerario" class="float-md-right text-md-right">Itinerario*</label>
            </div>
            <div class="col-12 col-md-8 col-lg-9">
                @php
                $itinerario=$corridaProgramada->getItinerario();
                $size = sizeof($itinerario);
                for($i=0; $i<sizeof($itinerario); $i++){
                    if($i==$size-1){
                        echo '➡'.$itinerario[$i]->claveOrigen.'<br>➡'.$itinerario[$i]->claveDestino;
                    }else{
                        echo '➡'.$itinerario[$i]->claveOrigen.'<br>';
                    }
                }
                @endphp
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="tipoDeServicio" class="float-md-right text-md-right">Tipo de servicio*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="horaDeSalida"class="form-control" readonly
                    value="{{@$corridaProgramada->servicio->aDescripcion}}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="horaDeSalida" class="float-md-right text-md-right">Hora de salida*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="horaDeSalida"class="form-control" readonly
                    value="{{@$corridaProgramada->hSalida}}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeInicio" class="float-md-right text-md-right">Fecha de inicio*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="horaDeSalida"class="form-control" readonly
                    value="{{@$corridaProgramada->fInicio}}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeFin" class="float-md-right text-md-right">Fecha de fin*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="horaDeSalida"class="form-control" readonly
                value="{{@$corridaProgramada->fFin}}">
            </div>
        </div>
        <table class="table mb-2 mx-4">
            <tr>
                <td>
                    <input id="lunes" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lLunes==true) ? "checked" : ""}}>
                    <label for="lunes" class="px-2">L</label>
                </td>
                <td>
                    <input id="martes" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lMartes==true) ? "checked" : ""}}>
                    <label for="martes" class="px-2">M</label>
                </td>
                <td>
                    <input id="miercoles" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lMiercoles==true) ? "checked" : ""}}>
                    <label for="miercoles" class="px-2">I</label>
                </td>
                <td>
                    <input id="jueves" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lJueves==true) ? "checked" : ""}}>
                    <label for="jueves" class="px-2">J</label>
                </td>
                <td>
                    <input id="viernes" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lViernes==true) ? "checked" : ""}}>
                    <label for="viernes" class="px-2">V</label>
                </td>
                <td>
                    <input id="sabado" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lSabado==true) ? "checked" : ""}}>
                    <label for="sabado" class="px-2">S</label>
                </td>
                <td>
                    <input id="domingo" type="checkbox" class="form-check-input" disabled
                        {{ (@$corridaProgramada->lDomingo==true) ? "checked" : ""}}>
                    <label for="domingo" class="px-2">D</label>
                </td>
            </tr>
        </table>
        <div class="col-12 justify-content-center">
            <!-- <a href="javascript:history.back()">
                <span class="btn-collap float-right" title="volver">
                    <label class="btn btn-sm btn-parhi-primary"
                        >
                        <i class="fa-solid fa-arrow-left"></i>
                        <span>Volver</span>
                    </label>
                    <input id="volver"
                    class="btn">
                </span>
            </a> -->
        </div>
    </div>

    
    <form action="{{route('corridas.programadas.storeTransfer', $corridaProgramada)}}" class="row needs-validation mt-4"
        novalidate method="post">
        <div class="col-12 row mb-2">
            <div class="col-12 col-md-4 col-lg-3">
                <label for="itinerario" class="float-md-right text-md-right">Itinerario*</label>
            </div>
            <div class="col-12 col-md-8 col-lg-9">
                <select name="itinerario" id="itinerario" class="form-control" required>
                    <option value="" disabled selected>seleccione</option>
                    @foreach($itinerarios as $itinerario=>$tramos)
                        <option value="{{ $itinerario }}" >
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
                <select name="tipoDeServicio" id="tipoDeServicio" class="form-control" required>
                    <option value="" disabled selected>Seleccione</option>
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
                    value="">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeInicio" class="float-md-right text-md-right">Fecha de inicio*</label>
                
            </div>
            <div class="col-12 col-md-8">
                <input id="fechaDeInicio" type="date" name="fechaDeInicio" placeholder="Apellidos" class="form-control"
                    value=""
                    min="{{ date('Y-m-d', strtotime($corridaProgramada->fFin. ' + 1 days')) }}">
            </div>
        </div>
        <div class="col-12 col-lg-6 col-xl-6 row mb-2">
            <div class="col-12 col-md-4">
                <label for="fechaDeFin" class="float-md-right text-md-right">Fecha de fin*</label>
            </div>
            <div class="col-12 col-md-8">
                <input id="fechaDeFin" type="date" name="fechaDeFin" placeholder="Apellidos" class="form-control"
                    value=""
                    min="{{ date('Y-m-d', strtotime($corridaProgramada->fFin. ' + 1 days')) }}">
            </div>
        </div>
        <table class="table mb-2 mx-4">
            <tr>
                <td>
                    <input id="lunes" type="checkbox" class="form-check-input" name="lunes">
                    <label for="lunes" class="px-2">L</label>
                </td>
                <td>
                    <input id="martes" type="checkbox" class="form-check-input" name="martes">
                    <label for="martes" class="px-2">M</label>
                </td>
                <td>
                    <input id="miercoles" type="checkbox" class="form-check-input" name="miercoles">
                    <label for="miercoles" class="px-2">I</label>
                </td>
                <td>
                    <input id="jueves" type="checkbox" class="form-check-input" name="jueves">
                    <label for="jueves" class="px-2">J</label>
                </td>
                <td>
                    <input id="viernes" type="checkbox" class="form-check-input" name="viernes">
                    <label for="viernes" class="px-2">V</label>
                </td>
                <td>
                    <input id="sabado" type="checkbox" class="form-check-input" name="sabado">
                    <label for="sabado" class="px-2">S</label>
                </td>
                <td>
                    <input id="domingo" type="checkbox" class="form-check-input" name="domingo">
                    <label for="domingo" class="px-2">D</label>
                </td>
            </tr>
        </table>
        <div class="col-12 row">
            @csrf
            <div class="col-12 justify-content-center">
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
        </div>
    </form>
</div>
@endsection