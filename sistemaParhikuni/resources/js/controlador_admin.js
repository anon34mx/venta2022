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

//  proms
$(document).ready(function(){
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

    // $(".nvaCorrida").click(function(){
    //     console.log(this);
    // });
});