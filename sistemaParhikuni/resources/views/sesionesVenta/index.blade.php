@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-11 col-md-11 col-lg-11 mx-auto">
    <h3>Corrida disponible {{ @$corridaDisponible->nNumero }}</h3>

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

    <div class="col-12">
        <h5>Filtrar</h5>
        <form action="{{route('sesionesventa.index')}}" class="col-12 row">
            <div class="col-6 my-1">
                <label for="fechaDeInicio" class="col-12">Fecha inicio</label>
                <input type="date" id="fechaDeInicio" name="fechaDeInicio" class="form-control col-12"
                    value="{{Request::get('fechaDeInicio')}}">
            </div>
            <div class="col-6 my-1">
                <label for="fechaDeFin" class="col-12">Fecha fin</label>
                <input type="date" id="fechaDeFin" name="fechaDeFin" class="form-control col-12"
                    value="{{Request::get('fechaDeFin')}}">
            </div>
            <div class="col-6 my-1">
                <label for="">usuario</label>
                <select name="usuario" id="usuario" class="form-control col-12">
                    <option value="">Todas</option>
                    @foreach($usuarios as $usuario)
                        @if(intval(Request::get('usuario'))==$usuario->id)
                            <option value="{{$usuario->id}}" selected>{{$usuario->personas->aNombres." ".$usuario->personas->aApellidos}}</option>
                            @else
                            <option value="{{$usuario->id}}">{{$usuario->personas->aNombres." ".$usuario->personas->aApellidos}}</option>
                        @endif
                    @endforeach
                </select>

            </div>
            @if(Auth::user()->hasRole("Admin"))
            <div class="col-6 my-1">
                <label for="">Oficina</label>
                <select name="aOficina" id="aOficina" class="col-12 form-control">
                    <option value="">Seleccione</option>
                    @foreach($oficinas as $oficina)
                        <option value="{{$oficina->nNumero}}">{{$oficina->aNombre}}</option>
                    @endforeach
                </select>
            </div>
            @endif
            <div class="col-6 row my-1">
                <label for="">Estado</label>
                <div class="col-6 row">
                    <label for="estadoAbierta" class="my-0">Abierta</label>
                    <input id="estadoAbierta" class="radio my-0" type="radio" name="estado" value="abierta">
                </div>
                <div class="col-6 row">
                    <label for="estadoCerrada" class="my-0">Cerrada</label>
                    <input id="estadoCerrada" class="radio my-0" type="radio" name="estado" value="cerrada">
                </div>
            </div>
            <div class="col-12 my-1">
                <span class="btn-collap mx-2" title="Abrir sesion">
                    <label class="btn btn-sm btn-parhi-primary" for="filtrar">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Filtrar</span>
                    </label>
                    <input id="filtrar" type="submit" class="btn">
                </span>
                <span class="btn-collap mx-2" title="Abrir sesion">
                    <label class="btn btn-sm btn-parhi-primary" for="borrarFiltros">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>borrar filtros</span>
                    </label>
                    <input id="borrarFiltros" type="button" onclick='quitarFiltros()'>
                </span>

                
            </div>
        </form>
    </div>
    @if(!session()->has("sesionVenta"))
    <div class="col-12">
        <form action="{{route('sesionesventa.abrir')}}" method="post">
            @csrf
            <span class="btn-collap" title="Abrir sesion">
                <label class="btn btn-sm btn-parhi-primary" for="abrirSesion">
                    <i class="fa-solid fa-store"></i>
                    <span>Abrir nueva sesión de venta</span>
                </label>
                <input id="abrirSesion" type="submit" class="btn">
            </span>
        </form>
    </div>
    @endif

    <table class="table table-parhi">
        <thead>
            <tr>
                <th>Número</th>
                @if(Auth::user()->hasRole("Admin"))
                <th>usuario</th>
                @endif
                <th>Oficina</th>
                <th>Fecha Contable</th>
                <th>Estado</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            @foreach($sesiones as $sesion)
                <tr class="<?= session("sesionVenta")==$sesion->nNumero ? "table-warning":""?>">
                    <td>{{$sesion->nNumero}}</td>
                    @if(Auth::user()->hasRole("Admin"))
                        <td>{{$sesion->usuario->name}}</td>
                    @endif
                    <td>{{$sesion->oficina->aNombre}}</td>
                    <td>{{$sesion->fContable}}</td>
                    @if($sesion->fCerrada==null)
                        <td>
                            <?= session("sesionVenta")==$sesion->nNumero ? "Activa":"Abierta"?>
                        </td>
                        <td>
                            <form action="{{route('sesionesventa.edit', $sesion)}}">
                                <span class="btn-collap" title="Cerrar sesión">
                                <label class="btn btn-sm btn-danger" for="cerrarSesion">
                                    <i class="fa-solid fa-store-slash"></i>
                                    <span>Cerrar sesión</span>
                                </label>
                                <input id="cerrarSesion" type="submit" class="btn">
                            </span>
                            </form>
                        </td>
                    @else
                        <td>
                            Cerrada
                        </td>
                        <td>
                            @if(Auth::user()->can("sesionesVenta.show"))
                                Recibido ${{number_format($sesion->nMontoRecibido,2)}}
                            @endif
                        </td>
                    @endif
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection