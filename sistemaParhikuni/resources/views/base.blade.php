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
    <h3>TITULO</h3>
    <br>
    <div class="col-12 row">
        <h5>Botones</h5>
        <div class="col-2">
            <span class="btn-collap col-auto" title="Guardar">
                <label class="btn btn-sm btn-parhi-primary"
                    for="guardar">
                <i class="fa-solid fa-floppy-disk"></i>
                <span>Guardar</span>
                </label>
                <input id="guardar" type="submit" class="btn">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap col-auto" title="Buscar">
                <label class="btn btn-sm btn-parhi-primary"
                for="del-">
                <i class="fa-solid fa-magnifying-glass"></i>
                <span>Buscar</span>
                </label>
                <input id="del-" type="submit" class="btn">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap" title="Eliminar">
                <label class="btn btn-sm btn-danger"
                    for="del">
                    <i class="fa-solid fa-circle-minus"></i>
                    <span>Eliminar</span>
                </label>
                <input id="del" type="submit"
                    class="btn" onclick="return confirm('¿Eliminar usuario?')">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap" title="Cancelar">
                <label class="btn btn-sm btn-danger"
                    for="cancel">
                    <i class="fa-solid fa-ban"></i>
                    <span>Cancelar</span>
                </label>
                <input id="cancel" type="submit"
                    class="btn" onclick="return confirm('¿Cancelar?')">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap" title="Ver">
                <label class="btn btn-sm btn-primary"
                    for="ver">
                    <i class="fa-regular fa-eye"></i>
                    <span>Ver</span>
                </label>
                <input id="ver" type="submit" class="btn">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap" title="Editar">
                <label class="btn btn-sm btn-primary"
                    for="edit-">
                    <i class="fa-solid fa-pen-to-square"></i>
                    <span>Editar</span>
                </label>
                <input id="edit-" type="submit" class="btn" onclick="">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap" title="Añadir">
                <label class="btn btn-sm btn-primary float-right"
                    for="addpermission">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>Añadir</span>
                </label>
                <input id="addpermission" type="submit"
                class="btn" >
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap col-auto float-right" title="reset">
                <label class="btn btn-sm btn-parhi-primary" for="reset">
                    <i class="fa-solid fa-delete-left"></i>
                    <span>Reset</span>
                </label>
                <input id="reset" type="submit" class="btn" name="send" value="reset">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap float-right" title="volver">
                <label class="btn btn-sm btn-parhi-primary" for="volver">
                    <i class="fa-solid fa-arrow-left"></i>
                    <span>Volver</span>
                </label>
                <input id="volver" class="btn">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap col-auto float-right" title="Buscar">
                <label class="btn btn-sm btn-parhi-primary">
                    <i class="fa-solid fa-arrow-right"></i>
                    <span>siguiente</span>
                </label>
                <input id="volver" class="btn">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap col-auto float-right" title="Buscar">
                <label class="btn btn-sm btn-parhi-primary">
                    <i class="fa-solid fa-filter"></i>
                    <span>Filtrar</span>
                </label>
                <input id="filtrar" class="btn">
            </span>
        </div>
        <div class="col-2">
            <span class="btn-collap col-auto float-right" title="Buscar">
                <label class="btn btn-sm btn-parhi-primary">
                    <i class="fa-solid fa-filter-circle-xmark"></i>
                    <span>Quitar filtros</span>
                </label>
                <input id="filtrar" class="btn">
            </span>
        </div>
    </div>

    <div class="col-12">
        <h5>Fomulario</h5>
        <!-- <input type="search" placeholder="Buscar por nombre" name="search"
            class="form-control" id="search"
            value="" style="padding-right: 30px;"/>
            <div onclick=""
                class="btn btn-link"
                style="
                color: black;
                position: absolute;
                right: 12px;
                top: 0px;
            ">
            <i class="fa-solid fa-delete-left"></i> -->
        <div class="col-12">
                <input type="search" placeholder="Buscar por nombre" name="search" class="form-control" id="search" value="" style="padding-right: 30px;">
                <div onclick="event.preventDefault();$('#search').val('')" class="btn btn-link" style="
                    color: black;
                    position: absolute;
                    right: 12px;
                    top: 0px;
                ">
                <i class="fa-solid fa-delete-left"></i>
            </div>
        </div>
    </div>


    <div class="col-12">
        <h4>
            <div id="ancla" style="
            /* display: none; */
            width:0px;
            heigth:0px;
            position: absolute;
            top: -70px;
            color:red;
        "></div>
            Titulo con ancla:
        </h4>
        <a href="#ancla">Ir a titulo con ancla</a>
        <br><br><br><br><br>
    </div>

    <div class="col-12">
        <h5>Tablas</h5>
        <div style="
            width: 100%;
            height: 180px;
            overflow: auto;
        ">
            <table class="mt-0 table table-striped table-parhi">
                <thead style="
                    position: sticky;
                    top: -1px;
                    z-index:1;
                ">
                    <tr class="table-parhi">
                        <th class="col-1">encabezados</th>
                        <th class="col-1">encabezados</th>
                        <th class="col-3">encabezados</th>
                        <th class="col-3">encabezados</th>
                        <th class="col-1" colspan="2"></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="col-1">datos</td>
                        <td class="col-1">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-1" colspan="2"><button class="btn btn-primary">x</button></td>
                    </tr>
                    <tr>
                        <td class="col-1">datos</td>
                        <td class="col-1">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-1" colspan="2"><button class="btn btn-primary">x</button></td>
                    </tr>
                    <tr>
                        <td class="col-1">datos</td>
                        <td class="col-1">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-1" colspan="2"><button class="btn btn-primary">x</button></td>
                    </tr>
                    <tr>
                        <td class="col-1">datos</td>
                        <td class="col-1">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-3">datos</td>
                        <td class="col-1" colspan="2"><button class="btn btn-primary">x</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="col-12 my-3 mx-0  row">
        <h5>Autocompletar varios input</h5>
        <div class="col-6 my-11">
            <input type="text" class="form-control form-control-sm" placeholder="Busqueda">
        </div>
        <div class="col-12 my-11">
            <input type="text" class="form-control form-control-sm" placeholder="Busqueda">
        </div>
    </div>
</div>
@endsection
