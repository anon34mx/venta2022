@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 mx-auto">
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

<div class="col-12 row px-0">
    <div class="col-12 col-sm-3 row px-0 mx-0">
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Fecha</div>
            <div class="px-0 col-12 col-lg-6">{{$fechaDeSalida}}</div>
            <div class="px-0 col-12 col-lg-6">{{$fechaMax}}</div>
        </div>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="">Origen-Destino</div>
            <div class="px-0 col-12 col-lg-6">{{ isset($origen) ? $origen->aNombre : "origen" }}</div>
            <div class="px-0 col-12 col-lg-6">{{ isset($destino) ? $destino->aNombre : "destino" }}</div>
        </div>
        <div class="col-12 row mx-0">
            <div class="col-6 col-md-6 col-lg-3"><button>mad</button></div>
            <div class="col-6 col-md-6 col-lg-3"><button>mañ</button></div>
            <div class="col-6 col-md-6 col-lg-3"><button>tar</button></div>
            <div class="col-6 col-md-6 col-lg-3"><button>noc</button></div>
        </div>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="col-12">Adultos</div>
            <div class="col-3"><button>+</button></div>
            <div class="col-6"><input class="col-12" type="text" value="{{$adultos}}"></div>
            <div class="col-3"><button>-</button></div>
        </div>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="col-12">Menores</div>
            <div class="col-3"><button>+</button></div>
            <div class="col-6"><input class="col-12" type="text" value="{{$niños}}"></div>
            <div class="col-3"><button>-</button></div>
        </div>
        <div class="col-6 col-sm-12 row mx-0">
            <div class="col-12">INSEN</div>
            <div class="col-3"><button>+</button></div>
            <div class="col-6"><input class="col-12" type="text" value="{{$insen}}"></div>
            <div class="col-3"><button>-</button></div>
        </div>
    </div>
    <div class="col-12 col-sm-9">
        <form action="#">
            <table>
                <thead>
                    <tr>
                        <!-- <th>corrida</th> -->
                        <!-- <th>disp</th> -->
                        <th>Servicio</th>
                        <th>Salida</th>
                        <th>Llegada</th>
                        <th>Origen</th>
                        <th>Destino</th>
                        <th>Tarifa</th>
                        <th>Itinerario</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($corridas as $corrida)
                        <tr>
                            <!-- <td>{{$corrida->corrida}}</td> -->
                            <!-- <td>{{$corrida->disp}}</td> -->
                            <td>{{($corrida->claseServicio)}}</td>
                            <td>{{($corrida->fSalida)}}</td>
                            <td>{{($corrida->hLlegada)}}</td>
                            <td>{{$corrida->origen}}</td>
                            <td>{{$corrida->destino}}</td>
                            <td>${{number_format($corrida->tarifaBase + $corrida->iva,2)}}</td>
                            <td>consultar itinerario</td>
                            <td>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
            <input id="cor" name="cor" type="" value="x">
            <input id="disp" name="disp" type="" value="s">
            <div class="col-12">
                <span class="btn-collap float-right mx-1" title="Continuar">
                    <label for="Continuar" class="btn btn-sm btn-parhi-primary">
                        <i class="fa-solid fa-arrow-right"></i>
                        <span>Continuar</span>
                    </label>
                    <input id="Continuar" class="btn" type="submit">
                </span>
            </div>
        </form>
    </div>
</div>

</div>
@endsection
