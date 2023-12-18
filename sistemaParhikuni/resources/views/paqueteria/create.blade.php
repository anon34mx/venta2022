@extends('layouts.parhikuni')


@section('content')
<div class="col-12 col-sm-12 col-md-12 col-lg-12 mx-auto">
    <h3 class="mt-4">Registrar envío</h3>

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

    <form action="" novalidate class="needs-validation">
        <fieldset id="remitente_datos_gen" class="col-12 row mx-0 px-0">
            <Legend id="Remitente">Remitente</Legend>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="id_convenio" class="float-md-right text-md-right">Remitente</label>
                </div>
                <div class="col-12 col-md-8">
                    <input type="text" id="ID_REMITENTE" class="form-control form-control-sm col-12"
                    placeholder="Remitente" name="id_remitente" readonly>
                </div>
            </div>
            
            
            <!-- <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="form-check float-right">
                    <input id="rem_factura" name="facturar" class="form-check-input" type="checkbox" autocomplete="off">
                    <label for="rem_factura" class="form-check-label">Requiere factura*</label>
                </div>
            </div> -->
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="id_convenio" class="float-md-right text-md-right">Convenio</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="id_convenio" name="id_convenio" class="rfc form-control form-control-sm inputmask" autocomplete="off"
                    pattern="[0-9]{1,}"
                    value=""
                    data-inputmask="'regex': '[a-zA-Z0-9]{1,}', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="form-check">
                    <input id="rem_factura" name="facturar" class="form-check-input" type="checkbox" autocomplete="off">
                    <label for="rem_factura" class="form-check-label text-danger"><b>Requiere factura*</b></label>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_curp" class="float-md-right text-md-right">CURP*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_curp" name="rem_CURP" class="curp form-control form-control-sm inputmask" autocomplete="off"
                    pattern="^([A-Z][AEIOUX][A-Z]{2}\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])[HM](?:AS|B[CS]|C[CLMSH]|D[FG]|G[TR]|HG|JC|M[CNS]|N[ETL]|OC|PL|Q[TR]|S[PLR]|T[CSL]|VZ|YN|ZS)[B-DF-HJ-NP-TV-Z]{3}[A-Z\d])(\d)$"
                    value="AUCJ941217HMNGSH06"
                    data-inputmask="'regex': '[a-zA-Z0-9]{1,18}', 'casing':'upper', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_rfc" class="float-md-right text-md-right">RFC*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_rfc" name="rem_RFC" class="rfc form-control form-control-sm inputmask" autocomplete="off"
                    required pattern="^([A-ZÑ&]{3,4}) ?(?:- ?)?(\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])) ?(?:- ?)?([A-Z\d]{2})([A\d])$"
                    value="AUCJ941217S61"
                    data-inputmask="'regex': '[a-zA-Z0-9]{1,13}', 'casing':'upper', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_nombre" class="float-md-right text-md-right">Nombre*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_nombre" name="rem_nombres" class="nombre form-control form-control-sm inputmask" autocomplete="off"
                    required
                    value="Aaron"
                    pattern="^([a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ \.]{2,})((\s[a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]{2,}){1,})?"
                    data-inputmask="'regex': '[a-zA-Z \\.]{3,}', 'casing':'upper', 'placeholder':''"
                    >
                    <!-- [A-ZÄËÏÖÜÁÉÍÓÚÂÊÎÔÛÀÈÌÒÙ][a-zäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]+(?:\s+[a-zäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]+)+ -->
                    <!-- ^([a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]{3,})+((?:\s[a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]{2,}){1,})$ -->
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_apellidos" class="float-md-right text-md-right">Apellidos*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_apellidos" name="rem_apellidos" class="apellidos form-control form-control-sm inputmask" autocomplete="off"
                    required
                    value="Aguilera Castillo"
                    pattern="^([a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ \.]{2,})+((\s[a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]{2,}){1,})$"
                    data-inputmask="'regex': '[a-zA-Z \\.]{2,}', 'casing':'upper', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_correo" class="float-md-right text-md-right">Correo*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_correo" name="rem_correo" class="correo form-control form-control-sm inputmask" type="email" autocomplete="off"
                    required
                    value="aaron.aguilera@parhikuni.mx"
                    data-inputmask="'casing':'lower', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_telefono1" class="float-md-right text-md-right">Telefono 1*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_telefono1" name="rem_telefono1" class="telefono form-control form-control-sm inputmask" autocomplete="off"
                    required
                    pattern="^(?:([0-9]{3})\s)?([0-9]{3})+((\s[0-9]{2}){2})$"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_telefono2" class="float-md-right text-md-right">Telefono 2</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_telefono2" name="rem_telefono2" class="telefono form-control form-control-sm " autocomplete="off"
                    pattern="^(?:([0-9]{3})\s)?([0-9]{3})+((\s[0-9]{2}){2})$" >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_identificacion" class="float-md-right text-md-right">Identificación*</label>
                </div>
                <div class="col-12 col-md-8">
                    <select id="rem_identificacion" name="rem_identificacion" class="form-control form-control-sm">
                        <option value="">Seleccione</option>
                        <option value="INE">Credencial de elector</option>
                        <option value="PAS">Pasaporte</option>
                        <option value="CED">Cédula profesional</option>
                        <option value="IES">Identificación de estudiante</option>
                        <option value="MIG">Documento migratorio</option>
                    </select>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_num_identificacion" class="float-md-right text-md-right">Número*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_num_identificacion" name="rem_num_identificacion" class="form-control form-control-sm" autocomplete="off">
                </div>
            </div>
            <div class="col-12">
                <span class="btn-collap col-auto float-right" title="Buscar">
                <label class="btn btn-sm btn-parhi-primary" for="busc-rem">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <span>Buscar remitente</span>
                </label>
                <!-- <input id="del-" type="submit" class="btn" onclick="event.preventDefault()"> -->
                <!-- data-toggle="modal"  -->
                <button id="busc-rem" type="button" class="btn btn-primary hidden" data-target="#modl-busc-rem" onclick="buscarRemitente(this)">
                Launch demo modal
                </button>
            </span>
            </div>
            <div class="col-12">
                <a href="#Contacto">
                    <span class="btn-collap col-auto float-right" title="Buscar">
                        <label class="btn btn-sm btn-parhi-primary">
                            <i class="fa-solid fa-forward"></i>
                            <span>siguiente</span>
                        </label>
                    </span>
                </a>
            </div>
        </fieldset>

        <fieldset id="contDomicilioRem" class="col-12 row mx-0 px-0">
            <legend>
                <div id="Contacto" style="
                /* display: none; */
                width:0px;
                heigth:0px;
                position: absolute;
                top: -70px;
                color:red;
            "></div>
                Contacto:
            </legend>
            
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_calle" class="float-md-right text-md-right">Calle*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_calle" name="rem_calle" class="calle form-control form-control-sm" autocomplete="off" required>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_num_ext" class="float-md-right text-md-right">Num. Ext.*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_num_ext" name="rem_num_ext" class="num_ext form-control form-control-sm inputmask" autocomplete="off" required
                    data-inputmask="'regex': '[a-zA-Z0-9]{1,}', 'casing':'upper', 'placeholder':''">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_num_int" class="float-md-right text-md-right">Num. Int.*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_num_int" name="rem_num_int" class="num_int form-control form-control-sm inputmask" autocomplete="off"
                    data-inputmask="'regex': '[a-zA-Z0-9]{1,}', 'casing':'upper', 'placeholder':''">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_estado" class="float-md-right text-md-right">Estado*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_estado" name="rem_estado" list="estadosMexico"  name="rem_estado" class="estado form-control form-control-sm"
                    autocomplete="off" required onchange="getMunicipiosEstado('#contDomicilioRem');"
                    value="Michoacán de Ocampo">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_municipio" class="float-md-right text-md-right">Delegación<br>municipio*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_municipio" name="rem_municipio" list="listaMunicipios" class="municipio form-control form-control-sm" autocomplete="off" required
                    value="Morelia">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_asentamiento" class="float-md-right text-md-right">Colonia*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_asentamiento" name="rem_asentamiento" class="asentamiento form-control form-control-sm" autocomplete="off" required
                        onkeyup="domicilio('#contDomicilioRem')" >
                    <div class="autocompleteDomicilio" style="
                        position: absolute;
                        z-index: 1;
                        background: white;
                        cursor: pointer;
                    " class="col-12 row">
                    </div>
                    <span class="hlp-txt"></span>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_cp" class="float-md-right text-md-right">CP*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_cp" name="rem_cp" class="cp form-control form-control-sm" autocomplete="off" required>
                    
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_ciudad" class="float-md-right text-md-right">Ciudad*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_ciudad" name="rem_ciudad" class="ciudad form-control form-control-sm" autocomplete="off" required>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="rem_pais" class="float-md-right text-md-right">País*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="rem_pais" name="rem_pais" class="pais form-control form-control-sm" autocomplete="off" required value="México">
                </div>
            </div>
            <div class="col-12">
                <a href="#Destinatario">
                    <span class="btn-collap col-auto float-right" title="Buscar">
                        <label class="btn btn-sm btn-parhi-primary">
                            <i class="fa-solid fa-forward"></i>
                            <span>siguiente</span>
                        </label>
                    </span>
                </a>
            </div>
        </fieldset>

        <fieldset class="col-12 row mx-0 px-0" id="contDest">
            <!-- <legend id="Destinatario">Destinatario:</legend> -->
            <legend>
                <div id="Destinatario" style="
                /* display: none; */
                width:0px;
                heigth:0px;
                position: absolute;
                top: -70px;
                color:red;
            "></div>
                Destinatario:
            </legend>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_nombre" class="float-md-right text-md-right">Nombre*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_nombre" name="dest_nombre" class="nombre form-control form-control-sm inputmask" autocomplete="off" required
                    value=""
                    pattern="^([a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ \.]{2,})((\s[a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]{2,}){1,})?"
                    data-inputmask="'regex': '[a-zA-Z\\. ]{3,}', 'casing':'upper', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_apellidos" class="float-md-right text-md-right">Apellidos*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_apellidos" name="dest_apellidos" class="apellidos form-control form-control-sm inputmask" autocomplete="off" required
                    value=""
                    pattern="^([a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ \.]{2,})+((\s[a-zA-ZäÄëËïÏöÖüÜáéíóúáéíóúÁÉÍÓÚÂÊÎÔÛâêîôûàèìòùÀÈÌÒÙ]{2,}){1,})$"
                    data-inputmask="'regex': '[a-zA-Z\\. ]{2,}', 'casing':'upper', 'placeholder':''">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="" class="float-md-right text-md-right">Tel1*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="x" name="x" class="telefono form-control form-control-sm" autocomplete="off"
                    pattern="^(?:([0-9]{3})\s)?([0-9]{3})+((\s[0-9]{2}){2})$" required
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="tipoDeServicio" class="float-md-right text-md-right">Tel2*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="tipoDeServicio" name="tipoDeServicio" class="telefono form-control form-control-sm" autocomplete="off"
                    pattern="^(?:([0-9]{3})\s)?([0-9]{3})+((\s[0-9]{2}){2})$"
                    >
                </div>
            </div>
            <div class="col-12 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_entrega_domicilio" class="float-md-right text-md-right">Entrega a domicilio*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_entrega_domicilio" name="dest_entrega_domicilio" type="checkbox" autocomplete="off">
                </div>
            </div>
        </fieldset>
        <fieldset class="col-12 row mx-0 px-0" id="contDomicilioDest">
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_calle" class="float-md-right text-md-right">Calle*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_calle" name="dest_calle" class="calle form-control form-control-sm inputmask" autocomplete="off"
                    required value=""
                    data-inputmask="'regex': '[a-zA-Z \\.]{3,}', 'casing':'upper', 'placeholder':''"
                    >
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_num_ext" class="float-md-right text-md-right">Num. Ext.*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_num_ext" name="dest_num_ext" class="num_ext form-control form-control-sm inputmask" autocomplete="off"
                    required data-inputmask="'regex': '[a-zA-Z0-9]{1,}', 'casing':'upper', 'placeholder':''">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_num_int" class="float-md-right text-md-right">Num. Int.*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_num_int" name="dest_num_int" class="num_int form-control form-control-sm inputmask" autocomplete="off"
                    data-inputmask="'regex': '[a-zA-Z0-9]{1,}', 'casing':'upper', 'placeholder':''">
                </div>
            </div>
            
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_estado" class="float-md-right text-md-right">Estado*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_estado" name="dest_estado" list="estadosMexico" name="estado" class="estado form-control form-control-sm inputmask"
                    autocomplete="off" value="" onchange="getMunicipiosEstado('#contDomicilioDest');" required
                    pattern="[a-zA-Z ]{1,}">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_municipio" class="float-md-right text-md-right">Delegación/municipio*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_municipio" list="listaMunicipios" name="municipio" class="municipio form-control form-control-sm" autocomplete="off">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_asentamiento" class="float-md-right text-md-right">Colonia*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_asentamiento" name="asentamiento" class="asentamiento form-control form-control-sm" autocomplete="off"
                        onkeyup="domicilio('#contDomicilioDest')" >
                    <div class="autocompleteDomicilio" style="
                        position: absolute;
                        z-index: 1;
                        background: white;
                        cursor: pointer;
                    " class="col-12 row">
                    </div>
                    <span class="hlp-txt"></span>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_cp" class="float-md-right text-md-right">CP*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_cp" name="dest_cp" class="cp form-control form-control-sm" onchange="domicilio('contDomicilioDest')" autocomplete="off">
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_ciudad" class="float-md-right text-md-right">Ciudad*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_ciudad" name="ciudad" class="ciudad form-control form-control-sm" autocomplete="off">
                </div>
            </div>
            
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="dest_pais" class="float-md-right text-md-right">País*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="dest_pais" name="dest_pais" class="pais form-control form-control-sm" autocomplete="off" required value="México">
                </div>
            </div>
            <div class="col-12">
                <a href="#CorridaPnl">
                    <span class="btn-collap col-auto float-right" title="Buscar">
                        <label class="btn btn-sm btn-parhi-primary">
                            <i class="fa-solid fa-forward"></i>
                            <span>Siguiente</span>
                        </label>
                    </span>
                </a>
            </div>
        </fieldset>

        <fieldset>
            <legend id="CorridaPnl">
                <div  style="
                /* display: none; */
                width:0px;
                heigth:0px;
                position: absolute;
                top: -70px;
                color:red;
            "></div>
                Corrida:
            </legend>
            <!-- <h3>CORRIDAS</h3> -->
            <input type="hidden" name="_token" value="{{ csrf_token() }}" />
            <div class="col-12 row mx-0 px-0">
                <div class="col-4 col-md-3">
                    <select name="corr_origen" id="corr_origen" class="form-control form-control-sm selector-origen" target="#corr_destino" required>
                        <option value="">Origen</option>
                        @foreach($oficinas as $oficina)
                            <option value="{{ $oficina->nNumero }}">{{ $oficina->aNombre }}</option>
                        @endforeach
                    </select>
                </div>
                <div class="col-4 col-md-3">
                    <select name="corr_destino" id="corr_destino" class="form-control form-control-sm" required>
                        <option value="">Destino</option>
                    </select>
                </div>
                <div class="col-4 col-md-3">
                    <input id="corr_fechaMin" name="corr_fechaMin" type="date" class="form-control form-control-sm" value="<?=date('Y-m-d')?>" min="<?=date('Y-m-d')?>" required>
                </div>
                <div class="col-12 col-md-3 mt-2">
                    <span class="btn-collap col-auto float-right " title="Buscar">
                        <label class="btn btn-sm btn-parhi-primary" for="btn_buscar_corridas">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <span>Buscar</span>
                        </label>
                        <input id="btn_buscar_corridas" class="btn_buscar_corridas" type="button" value="buscar" servicio="PQ">
                    </span>
                </div>
                    
                    <div class="input-group has-validation col-12">
                        <input hidden id="disp" name="disp" type="" value="" required class="form-control form-control-sm">
                        <input hidden id="horaSalida" name="horaSalida" type="time" value="{{  \Carbon\Carbon::now()->setTimezone('-6:00')->format('H:i:s')}}" required class="form-control form-control-sm">
                        <input hidden id="corr" name="cor" type="" value="" required class="form-control form-control-sm">
                         <div class="invalid-feedback">
                            Elije una corrida
                        </div>
                    </div>

                    
                    
            </div>
            <div style="
                width: 100%;
                height: 220px;
                overflow: auto;
            ">
                <table id="cordis" class="mt-0 table table-striped table-parhi">
                    <thead style="position: sticky;top: -1px;z-index:1;">
                        <tr class="table-parhi">
                            <th class="claveServicio" data="claveServicio">Clase</th>
                            <th class="corrida" data="corrida">Corrida</th>
                            <th class="origen" data="origen">Origen</th>
                            <th class="destino" data="destino">Destino</th>
                            <th class="fhSalida" data="fhSalida">Salida</th>
                            <th class="fhLlegada" data="fhLlegada">Llegada</th>
                            <th class="tarifaPaq" data="tarifaPaq">Costo</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </fieldset>
        <fieldset class="col-12 row mx-0 px-0 ">
            <legend id="Paquetes">Agregar paquete:</legend>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="paq_tipo" class="float-md-right text-md-right">Tamaño de paquete*</label>
                </div>
                <div class="col-12 col-md-8">
                    
                    <select  id="paq_tipo" name="paq_tipo" class="form-control form-control-sm">
                        <option value="">Selecciona el tamaño</option>
                        @foreach($factores as $factor)
                            <option value="{{$factor->nNumero}}">{{$factor->nValorMaximo." ".$factor->aTipo}}</option>
                        @endforeach
                    </select>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="paq_tipo" class="float-md-right text-md-right">Contenido del paquete*</label>
                </div>
                <div class="col-12 col-md-8">
                    <div class="col-12 col-md-6 searchInputCont row">
                        <input id="busqPaqProductos" class="form-control searchInput" class="col-6"
                            type="text" list="ccp_productos_list" autocomplete="off" placeholder="¿Cuál es el contenido del paquete?">
                        <input id="idPaqProducto" class="found form-control col-6" type="text" readonly>
                        <label for="" class="searchInputLbl col-12">Buscando...</label>
                        <datalist id="ccp_productos_list">
                        </datalist>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="paq_factor" class="float-md-right text-md-right">Factor*</label>
                </div>
                <div class="col-12 col-md-8">
                    <select id="paq_factor" name="paq_factor" class="form-control form-control-sm">
                        <option value="">Peso</option>
                        <option value="">Volumen</option>
                    </select>
                </div>
            </div>
            <div class="col-12 col-md-6 col-xl-6 row mb-3 mx-0 px-0">
                <div class="col-12 col-md-4">
                    <label for="peso_volumen" class="float-md-right text-md-right">Peso/volumen*</label>
                </div>
                <div class="col-12 col-md-8">
                    <input id="peso_volumen" name="peso_volumen" class="form-control form-control-sm" autocomplete="off">
                </div>
            </div>


            
            <div class="col-12">
                <span class="btn-collap col-auto float-right" title="Buscar">
                    <label class="btn btn-sm btn-parhi-primary" for="btn_agregar_paqu">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <span>Agregar</span>
                    </label>
                    <input id="btn_agregar_paqu" type="submit" class="btn" name="send" value="buscar" autocomplete="off">
                </span>
            </div>
        </fieldset>

        <fieldset class="col-12 row mx-0 px-0">
            <legend id="Pago">Paquetes:</legend>
            <table class="table table-parhi">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Clave</th>
                        <th>Tipo</th>
                        <th>Factor</th>
                        <th>Corrida</th>
                        <th>Origen</th>
                        <th>Destino</th>
                        <th>Salida</th>
                        <th>Llegada</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#</td>
                        <td>Clave</td>
                        <td>tipo</td>
                        <td>5kg</td>
                        <td>123123</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </fieldset>

        <fieldset class="col-12 row mx-0 px-0">
            <legend id="Pago">Pago:</legend>
            <div class="col-12 row mx-0 px-0">
                <div class="col-6">
                    <table class="table table-parhi">
                        <tbody>
                            <tr>
                                <td>Tarifa base</td>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <td>Factor</td>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <td>Monto</td>
                                <td>$00.00</td>
                            </tr>
                            <!-- <tr>
                                <td>Monto c/promo</td>
                                <td>$00.00</td>
                            </tr> -->
                            <!-- <tr>
                                <td>Importe VD</td>
                                <td>$00.00</td>
                            </tr> -->
                            <tr>
                                <td>Factor seguro</td>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <td>Importe base seg.</td>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <td>Importe seg.</td>
                                <td>$00.00</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-6">
                    <table class="table table-parhi col-6">
                        <tbody>
                            <tr>
                                <th>Monto</th>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <th>Descuento</th>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <th>Subtotal</th>
                                <td>$00.00</td>
                            </tr>
                            <tr>
                                <th>IVA</th>
                                <td>$00.00</td>
                            </tr>
                            <!-- <tr>
                                <th>IVA retenido</th>
                                <td>$00.00</td>
                            </tr> -->
                            <tr>
                                <th>Total</th>
                                <th><b>$00.00</b></th>
                            </tr>
                            <!-- <tr>
                                <th>Divisa</th>
                                <td>
                                    <select name="" id="">
                                        <option value="MXN">pesos mexicanos</option>
                                    </select>
                                </td>
                            </tr> -->
                            <tr>
                                <th>Recibido</th>
                                <td><input type="text"></td>
                            </tr>
                            <tr>
                                <th>Cambio</th>
                                <td>$00.00</td>
                            </tr>
                        </tbody>
                    </table>
                    <button>boton confirmar</button>
                </div>
            </div>
        </fieldset>
        @csrf
    </form>
    
    <datalist id="estadosMexico">
        @foreach($estados as $estado)
            <option value="{{$estado->nombre}}"><span class="id">{{$estado->id}}</span> <sub>{{$estado->abrev}}</sub> </option>
        @endforeach
    </datalist>
    <datalist id="listaMunicipios">
    </datalist>

<!-- Modal -->
<div class="modal fade" id="modl-busc-rem" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#modl-busc-rem').modal('hide');">Cerrar</button>
        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
      </div>
    </div>
  </div>
</div>
    <!--  -->
</div>
@endsection