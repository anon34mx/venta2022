// variables
window.asientoAnt = 0;
window.tiempoRestante = 0;
window.tiempoTerminado = false;
window.IntTiempoRestante = null;
// window.nCorrida = null;

//  PARA LA VISTA CREAR TRAMO [INICIO]
// window.cambiarTramoNuevo = function (origen) {
    // input[type="number"]')
    // $("#tramos option[inicio='8']").show()
    // $("#tramos option").hide()
// }
window.agregarTramoNevo=()=>{
    var opc = $('#tramos option:selected');
    if ($(opc).val()==''){
        $('#tramos').addClass('is-invalid');
    }else{
        var origenDestino = $(opc).val().split('_');
        $('#tbl-NvoItinerario tbody').append('<tr>'
            + "<td hidden><input type='' name='origenDestino[]' value='" + $(opc).val() +"'></td>"
            + "<td>" + $(opc).attr("origen") +"</td>"
            + "<td>" + $(opc).attr("destino") +"</td>"
            + '<td><input type="number" name="kilometros[]" value="0" min="1" class="form-control"></td>'
            + '<td><input type="number" name="tiempo[]" value="0" min="1" class="form-control"></td>'
            + '<td><input type="number" name="estancia[]" value="0" min="0" class="form-control"></td>'
            + '<td><button class="btn btn-danger" onclick="cancelarNuevoTramo(event, \"' + opc[0].id +'\", this)">'
            + '<i class="fa-solid fa-circle-minus"></i><span>Eliminar</span></button></td>'
            + '</tr>');
        $('#tramos option[nOrigen="' + origenDestino[1]+'"]').show()
        $(opc).hide();
        $(opc).parent().val('');
        $('#tramos').removeClass('is-invalid');
    }

    if ($('#tbl-NvoItinerario tr').length > 1){
        $('#btnGuardar').fadeIn();
    }else{
        $('#btnGuardar').fadeOut();
    }
}
window.cancelarNuevoTramo=(e, id, row)=>{
    if(confirm('¿Quitar nuevo tramo?')){
        e.preventDefault();
        $('#' + id).show();
        $(row).parent().parent().remove();
    }
    if ($('#tbl-NvoItinerario tr').length > 1){
        $('#btnGuardar').fadeIn();
    }else{
        $('#btnGuardar').fadeOut();
    }
}

window.agregarTramoNevoItinerario = () => {
    var opc = $('#tramos option:selected');
    var data;
    if ($(opc).val() == '') {
        $('#tramos').addClass('is-invalid');
    } else {
        data = JSON.parse($(opc).attr('data'));

        $('#tbl-NvoItinerario tbody').append('<tr>'
            + '<td class="hidden"><input type="" name="tramo[]" value="' + data.nNumero + '"></td>'
            + '<td>' + data.origen + '</td>'
            + '<td>' + data.destino + '</td>'
            + '<td><input type=@@ disabled name="kilometros[]" value="' + data.nkilometros+' km" min="1" class="form-control" required></td>'
            + '<td><input type="number" disabled name="tiempo[]" value="' + data.nTiempo +'" min="1" class="form-control" required></td>'
            + '<td><input type="number" disabled name="estancia[]" value="' + data.nEstancia +'" min="0" class="form-control" required></td>'
            + "<td><button class='btn btn-danger' onclick='cancelarTramoItinerario(event, \"" + opc[0].id + "\", this)'>"
            + '<i class="fa-solid fa-circle-minus"></i><span>Eliminar</span></button></td>'
            + '</tr>');
        $('#tramos option').hide();
        $('#tramos option[origen="' + data.nDestino + '"]').show()
        $(opc).parent().val('');
        $('#tramos').removeClass('is-invalid');
    }

    if ($('#tbl-NvoItinerario tr').length > 1) {
        $('#btnGuardar').fadeIn();
    } else {
        $('#btnGuardar').fadeOut();
    }
}
window.cancelarTramoItinerario = (evento, id, row) => {
    if (confirm('¿Quitar nuevo tramo?')) {
        evento.preventDefault();
        $('#' + id).show();
        $(row).parent().parent().remove();
    }
    if ($('#tbl-NvoItinerario tr').length > 1) {
        $('#btnGuardar').fadeIn();
    } else {
        $('#btnGuardar').fadeOut();
    }
}

window.toggleCheckboxesByClass = function(target, clase){
    if ($(target).prop('checked')){
        $('.'+clase).prop('checked', true);
    }else{
        $('.'+clase).prop('checked', false);
    }
}

// LIMBO
window.getProxCorridas = function(corridaOG,origen,destino){
    $.ajax({
        url: route('corrida.getProxCorridas', [corridaOG, origen, destino]),
        success:function(response){
            $('#tbl-corridas tbody').empty();
            response=JSON.parse(response),
            response.forEach(corrida => {
                var inpt = null;
                inpt=$(`<div class="form-check">
                            <input id="sel-${corrida.nNumero}" type="radio"
                            class="nvaCorrida form-check-input"
                            name="nvaCorrida" value="${corrida.nNumero}" required
                            target="#corrida"
                            onchange="mirrorInput(this);cargarDiagrama(`+ corrida.nNumero + `, ` + corrida.nOrigen + `, ` + corrida.nDestino +`);">
                            
                            <label for="sel-${corrida.nNumero}">${corrida.nNumero}</label>
                        </div>
                            `).on("click",()=>{
                                // cargarDiagrama(corrida.nNumero, corrida.nOrigen, corrida.nDestino);
                            });

                $('#tbl-corridas tbody').append(`
                    <tr id="corr-${corrida.nNumero}">
                        <td class="inpt">
                            
                        </td>
                        <td>${corrida.fSalida}</td>
                        <td>${corrida.hSalida}</td>
                        <td>autobus</td>
                        <td>${corrida.servicio}</td>
                        <td>${corrida.libres} de ${corrida.asientos}</td>
                    </tr>
                `);
                $('#tbl-corridas tbody #corr-'+corrida.nNumero+' .inpt').append(inpt);
            });
            $('#tbl-corridas tbody').append(`
                <tr>
                    <td colspan="7">
                        <input id="corrida" name="" type="number" value="0" min="1"required hidden>
                        <div class="invalid-feedback">
                            Selecciona una corrida
                        </div>
                    </td>
                </tr>
            `);
        }
    });
}
window.getFiltrarCorridas = function (corrida = null, origen = null, destino = null, fechaSalida = null, fechaMax = null, pasajeros = null,
    hInicio = "00:00:00", hFin = null, usarPromocion = null, limit = 999, tipoBusqueda = "exacta") {
        var body={
            "corrida" : corrida ,
            "origen" : origen ,
            "destino" : destino ,
            "fechaSalida" : fechaSalida ,
            "fechaMax" : fechaMax ,
            "cantidadPasajeros" : pasajeros ,
            "hInicio" : hInicio ,
            "hFin" : hFin ,
            "usarPromocion" : usarPromocion ,
            "limit" : limit ,
            "tipoBusqueda" : tipoBusqueda,
        };
    const promise = fetch(route("corridas.disponibles.filtradas"),{
        method: "POST",
        credentials: "same-origin",
        body: JSON.stringify(body),
        headers:{
            "Content-type":"application/json; charset=UTF-8",
            "Accept": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "X-CSRF-Token": $('input[name="_token"]').val()
        }
    }).then(response => response.text())
    .then(data=>{
        $("#cordis tbody").empty();
        data=JSON.parse(data);
        var tHeads = $("#cordis thead tr th");

        

        data.forEach(element => {
            console.log(element);
            if (element.edoUwu =="Disponible"){
                var str_html = `<tr onclick="seleccionarCorrida(this,'${element.corrida}','${element.disp}')" class="selectable pb-2">`;

                for (var i = 0; i < tHeads.length; i++) {
                    // console.log( $(tHeads[i]).attr("data") );
                    // break;
                    switch ($(tHeads[i]).attr("data")) {
                        case "claveServicio":
                            str_html += `<td>${element.claveServicio || 'NA'}</td>`;
                            break;
                        case "corrida":
                            str_html += `<td>${element.corrida}</td>`;//_${element.disp}
                            break;
                        case "origen":
                            str_html += `<td>${element.origen}</td>`;
                            break;
                        case "destino":
                            str_html += `<td>${element.destino}</td>`;
                            break;
                        case "fhSalida":
                            str_html += `<td>${element.hSalida.substring(0,5)}h<br><span><sub>${element.fSalida}</sub></span></td>`;
                            break;
                        case "fSalida":
                            str_html += `<td>${element.fSalida.substring(0, 5)}h</td>`;
                            break;
                        case "hSalida":
                            str_html += `<td>${element.hSalida.substring(0, 5) }</td>`;
                            break;
                        case "fhLlegada":
                            str_html += `<td>${element.hLlegada.substring(0,5)}h<br><span><sub>${element.fLlegada}</sub></span></td>`;
                            break;
                        case "hLlegada":
                            str_html += `<td>${element.hLlegada.substring(0,5)}h</td>`;
                            break;
                        case "fLlegada":
                            str_html += `<td>${element.fLlegada}</td>`;
                            break;
                        case "tarifaBase":
                            str_html += `<td>$ ` + parseFloat(element.tarifaBase || 0).toFixed(2) +`</td>`;
                            break;
                        case "tarifaPaq":
                            str_html += `<td>$ ` + parseFloat(element.tarifaPaq || 0).toFixed(2) +`</td>`;
                            break;
                    }
                }
                /*
                if ($("#cordis thead .fLlegada").length > 0){
                    str_html += `<td>${element.fLlegada}</td>`;
                }
                if ($("#cordis thead .hLlegada").length > 0){
                    str_html += `<td>${element.hLlegada}</td>`;
                }
                if ($("#cordis thead .hLlegada").length > 0){
                    str_html += `<td>${element.hLlegada}</td>`;
                }
                if ($("#cordis thead .tarifaPaq").length > 0){
                    str_html += `<td>${element.tarifaPaq}</td>`;
                }
                if ($("#cordis thead .claveServicio").length > 0){
                    
                }
                */
                str_html += `</tr>`;
                // <td>${element.tarifaBase}</td>
                $("#cordis tbody").append(str_html);
            }
        });
    });

}
window.seleccionarAsignarLimbo = function(){
    var boletos=$('.boleto:checked');
    var inpSel=$('#inpSel');
    $(inpSel).val(boletos.length);
}

window.cargarDiagrama = function (corrida,origen,destino){
    $.ajax({
        url: route('corrida.diagramaOcupacion', corrida),
        data:{
            'origen':   origen,
            'destino':  destino,
            'corrida':  corrida,
        },
        beforeSend: function(){
            $('#tbl-diagrama').empty();
            $('#tbl-diagrama').html('<tr><td>CARGANDO</td></tr>');
        },
        success:function(response){
            response=JSON.parse(response);
            // response.ocupados=Object.keys(response.ocupados)
            setTimeout(() => {
                $('#tbl-diagrama').html(response.diagrama);

                var listaAsientos ='<option value="">Seleccione</option>';
                response.libres.forEach(asientoLibre => {
                    listaAsientos += '<option value="' + asientoLibre + '" >' + asientoLibre + '</option>';
                });
                listaAsientos += '<option value="0" readonly>Paquetería</option>';
                $("#asientosDisp").html(listaAsientos);
                $("#tbl-datosPasajeros .contAsiento select").html($("#asientosDisp option").clone());

                var sinNumAsiento = $(".selecPTransferencia:checked");
                for (var i = 0; i < sinNumAsiento.length; i++){
                    var fila = $(sinNumAsiento[i]).parent().parent();
                    var asientoAnt = $(fila).find(".nAsiento").val();
                    var tipoPasaj = $(fila).find(".tipoPasajero").html();
                    var asientoNvo=0;
                    var boleto = $(fila).find(".nBoleto").html();
                    var index=0;
                    
                    console.log("asiento", asientoAnt);
                    console.log(tipoPasaj);
                    if (tipoPasaj=="PQ"){ // es paquete
                        $('#tbl-datosPasajeros #pasajero-' + boleto + ' .pasajeroAsiento ').prop("disabled", true);
                    }else{ // es pasajero
                        index = response.libres.indexOf(asientoAnt)
                        if (index > -1){
                            // console.log("asiento " + parseInt(asientoAnt) + " libre");
                        }else{
                            asientoNvo = response.libres[0];
                            response.libres = response.libres.slice(1, response.libres.length)
                            // console.log("Asignar en " + asientoNvo);
                        }

                    }
                    $("#tbl-diagrama").append("<tr></tr><tr></tr>")
                    selectAsientoTransferir(
                        $('#tbl-datosPasajeros #pasajero-' + boleto + ' .pasajeroAsiento ').val(asientoNvo).attr("readonly","readonly")
                    );
                    mirrorInput($('#tbl-datosPasajeros #pasajero-' + boleto + ' .pasajeroAsiento ').val(asientoNvo).attr("readonly", "readonly"));
                }
            }, 1);
        }
    });
}
window.selecPTransferencia = function(){
    if (this.checked){
        agregarTransferencia(this.value);
        
        $('.selecPTransferencia').prop('disabled', true);
        $("input[nOrigen='" + $(this).attr("nOrigen") + "'][nDestino='" + $(this).attr("nDestino") +"']").prop("disabled", false);
        // console.log($(this).attr("nOrigen"), $(this).attr("nDestino"));
        getProxCorridas(nCorrida, $(this).attr("nOrigen"), $(this).attr("nDestino"));
    }else{
        var x=$("#tbl-datosPasajeros").find("#pasajero-"+this.value)
        $(x).remove();
        try {
            var select = $(".selecPTransferencia:checked");
            if (select.length == 0) {
                $(".selecPTransferencia").prop("disabled", false);
                $("#tbl-corridas tbody").empty();
            }
        } catch (error) { }
    }
}
window.agregarTransferencia = function(boleto){
    var tipo = $("#asiento-" + boleto +" .tipoPasajero").html().trim();
    var nombre = $("#asiento-" + boleto +" .pasajero").html().trim();
    
    var row = $.parseHTML(`
            <tr id="pasajero-${boleto}" class="pt-1 pb-1 pasajeroContainer" asiento="${boleto}" pasajero="${boleto}">
                <td class="contAsiento px-2">
                <select type="number" class="pasajeroAsiento px-2 form-control form-control-sm " onchange="selectAsientoTransferir(this);mirrorInput(this)" required target="#pasajero-${boleto} .asiento" readonly>
                    <option value="">Seleccione</option>
                </select>
                <input class="asiento" type="text" name="asiento[]" readonly hidden>
                </td>
                <td colspan="2" class="px-2">
                <input class="form-control form-control-sm pasajeroNombre" type="text" name="pasajero[]" id="pasajero[{{$contAuxPasajeros}}]"
                value="${nombre}" autocomplete="off" readonly>
                </td>
                <td class="tipo px-2">
                    <input class="pasajeroTipo" name="pasajeroTipo[]" value="${tipo}" hidden readonly required tabindex="-1">
                    `+ tipo + `
                </td>
                <td class="px-2">
                    <button id="cancelar-${boleto}" onclick="event.preventDefault();quitarPasajero(this);"
                        class="hidden"></button>
                    <label class="btn btn-sm btn-danger float-right" for="cancelar-${boleto}">
                        <i class="fa-solid fa-xmark"></i>
                    </label>
                </td>
            </tr>`);
    $("#tbl-datosPasajeros tbody").append(row);
}

window.selectAsientoTransferir = function(select){
    var ocupados=$('#tbl-datosPasajeros .contasiento select');
    $('.contasiento option').prop('disabled', false);
    $(".apartado").removeClass("apartado");
    
    for(var i=0; i<ocupados.length; i++){
        $('.contasiento option[value="' + ocupados[i].value + '"]').prop('disabled', true);
        $('#asiento-' + (ocupados[i].value + "").padStart(2, '0')).addClass("apartado");
    }
}

window.removerTransferencia = function(boleto){
}

window.buscarRemitente = function(btn){
    // $('#modl-busc-rem').modal("show")
    let _datos = $("#remitente_datos_gen input").filter(function () { return this.value != ""; }).serialize();
    const promise = fetch(route("paqueteria.buscarRemitente"), {
        method: "POST",
        credentials: "same-origin",
        body: JSON.stringify(_datos),
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "X-CSRF-Token": $('input[name="_token"]').val()
        }
    }).then(response => response.text())
    .then(data => {
        console.log(btn);
        $('#modl-busc-rem').modal("show")
        $($(btn).attr("data-target") + " .modal-body").html(data);
    })
}
window.usarRemitente = function (cont){
    var spans=$(cont).find("span");
    for(var i=0; i< spans.length; i++){
        console.log(spans[i]);
        $($(spans[i]).attr("target")).val($(spans[i]).html());
    }
    $('#modl-busc-rem').modal("hide");
    $("#busqPaqProductos").attr("list", "");
}
window.getListContenidoPaquete = await function(inpt){
    var lblSearch = $(inpt).parent().find(".inputSearchLbl");
    var datalist = $(inpt).attr("list");
    $(lblSearch).css("opacity",100);
    const promise = fetch(route("paqueteria.listaProductosSAT",[
        inpt.value
    ]), {
        method: "GET",
        credentials: "same-origin",
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "X-CSRF-Token": $('input[name="_token"]').val()
        }
    })
    .then(response => response.text())
    .then(data => {
        $("#"+datalist).empty();
        // data = JSON.stringify(data, true);
        data = data.toString();
        data = JSON.parse(data);
        (async function () {
            for await (const producto of data) {
                console.log(producto);
                $("#"+datalist).append(
                    '<option value="' + producto.id + '">' + producto.texto +'</option>'
                );
            }
        })();
        $(lblSearch).css("opacity", 0);
        $("#busqPaqProductos").attr("list", "ccp_productos_list");
    }).then(()=>{
        $("#busqPaqProductos").attr("list", "ccp_productos_list");
    })
}
window.contenidoPaquete = function(inpt){
    var found = $("#ccp_productos_list option[value='" + inpt.value + "']")
    console.log(found);
    if (found.length <= 0){
        console.log("no existe")
    }
    else{
        console.log($(found).val());
        console.log($(found).html());
        $(inpt).val($(found).html());
        $("#idPaqProducto").val($(found).val());
    }
        
}

window.getMunicipiosEstado= function (contenedor){
    // var estado = $("#estadosMexico option[value='" + $(contenedor + " .estado").val() + "'] .id").text();
    let _datos = {
        "estado": $("#estadosMexico option[value='" + $(contenedor + " .estado").val() + "'] .id").text(),
        "municipio": $(contenedor + " .municipio").val(),
    }
    const promise = fetch(route("geo.MunicipiosEstado"), {
        method: "POST",
        credentials: "same-origin",
        body: JSON.stringify(_datos),
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "X-CSRF-Token": $('input[name="_token"]').val()
        }
    }).then(response => response.text())
    .then(data => {
        data=JSON.parse(data);
        console.log(data)
        $("#listaMunicipios").empty();
        data.forEach(element => {
            // #listaMunicipios
            $("#listaMunicipios").append(`<option value="${element.nombre}"><span class="id">${element.clave}</span></option>`);
        });
    });
}

window.domicilio = function(contenedor) {
    var html = "";

    $(contenedor + " .hlp-txt").html("Cargando opciones...");
    $(contenedor + " .autocompletes").fadeIn();
    $(contenedor + " .autocompleteDomicilio").empty();
    html += `<span><span class="btn btn-sm float-right" onclick="$('` + contenedor + ` .autocompleteDomicilio').empty();"> x</span></span>`;
    
    let _datos ={
        "asentamiento": $(contenedor + " .asentamiento").val(),
        "estado": $(contenedor+" .estado").val(),
        "municipio": $(contenedor +" .municipio").val(),
    }
    console.log(_datos);
    const promise = fetch(route("paqueteria.asentamientos"), {
        method: "POST",
        credentials: "same-origin",
        body: JSON.stringify(_datos),
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "X-CSRF-Token": $('input[name="_token"]').val()
        }
    })
        .then(response => response.text())
        .then(data => {
            $(contenedor + " .hlp-txt").html("");
            $(contenedor + " .autocompleteDomicilio").html("")
            data = JSON.parse(data, true);
            for (var i = 0; i < data.length; i++) {
                // console.log(data[i]);
                html += `<div id='${i}' class="autocompletes py-2">
                        <span target="tipoAsentamiento">${data[i].tipoAsentamiento}</span>:
                        <span target="asentamiento">${data[i].asentamiento}</span><br>
                        CP:
                        <span target="cp">${data[i].cp}</span><br>
                        Ciudad:
                        <span target="ciudad">${data[i].ciudad}</span><br>
                        Municipio:
                        <span target="municipio">${data[i].municipio}</span><br>
                        Estado:
                        <span target="estado">${data[i].estado}</span><br>
                    </div>`;
            }
            $(contenedor + " .autocompletes").fadeIn();
            $(contenedor + " .autocompleteDomicilio").html(html);
            $(".autocompletes").on("click", function () {
                applyAutocomplete(contenedor, this)
            });
        });
}
window.fillSelectDestinos=function(select, origen,  comp){
    const promise = fetch(route('corridas.disponibles.destinos', { origen, comp }),{
        method: "GET",
        credentials: "same-origin",
        // body: JSON.stringify(_datos),
        headers: {
            "Content-type": "application/json; charset=UTF-8",
            "Accept": "application/json",
            "X-Requested-With": "XMLHttpRequest",
            "X-CSRF-Token": $('input[name="_token"]').val()
        }
    })
    .then(response => response.text())
    .then(data => {
        data = JSON.parse(data);
        $(select).empty();
        $(select).append(`<option value="">Destino</option>`);
        data.forEach(element => {
            $(select).append(`<option value="${element.nDestino}">${element.destino}</option>`);
        });
    })
}
window.applyAutocomplete = function (contenedor, row) {
    // console.log(row);
    var spans = $(row).find("span");
    for (let i = 0; i < spans.length; i++) {
        var target = spans[i].attributes.target.value;
        $(contenedor + ` .${target}`).val(spans[i].innerHTML);
    }

    $(".autocompleteDomicilio").empty()
}

//  proms
$(document).ready(function(){
    $(".autocompletes").on("click", function () {
        applyAutocomplete(this)
    });
    $(".btn_buscar_corridas").on("click", function () {
        // console.log($(this).attr("servicio"));
        /*
        (corrida = null, origen = null, destino = null, fechaSalida = null, fechaMax = null, pasajeros = null,
        hInicio = "00:00:00", hFin = null, usarPromocion = null, limit = 999, tipoBusqueda = "exacta", claseServ=null) 
        */
        getFiltrarCorridas(null, $("#corr_origen").val() || null, $("#corr_destino").val() || null, $("#corr_fechaMin").val() || null, $("#corr_fechaMax").val() || null, $("#corr_cantPasajeros").val() || null, $("#horaSalida").val() || null, $("#horaSalidaMax").val() || "23:59:59", $("#usarPromocionF").val() || null, $("#limitCorridas").val() || 10, $("#tipoFiltro").val() || "proximas", $(this).attr("servicio") || null)
    });
    $(".inputmask").inputmask();
    $(".telefono").inputmask({
        mask: ['999 99 99', '999 999 99 99']
    });
    $("#fechaDeFin, #fechaDeInicio").on("change", function(event){
        validarFechas($("#fechaDeInicio"), $("#fechaDeFin"));
    });
    $("#aplicarPromoA").on("change", function(){
        $(".aplicarPor").fadeOut(1);
        $(".aplicarPor input, .aplicarPor select").removeAttr("required").val("")
        $(`.${this.value}`).fadeIn(1);
        $(`.${this.value} input, .${this.value} select`).attr("required","required");
    });
    $(".selecPTransferencia").click(selecPTransferencia);
    $(".selector-origen").on("change", function(){
        fillSelectDestinos($("#corr_destino"), $("#corr_origen option:selected").val(), false)
    });
    $("#busqPaqProductos").on("change", function () {
        contenidoPaquete(this);
    });
    $("#busqPaqProductos").on("keyup", function () {
        if(this.value.length > 3){
            getListContenidoPaquete(this);
        }
    });
    // $(".nvaCorrida").click(function(){
    //     console.log(this);
    // });
});