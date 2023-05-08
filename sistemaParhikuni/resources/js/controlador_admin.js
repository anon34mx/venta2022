// variables
window.asientoAnt = 0;
window.tiempoRestante = 0;
window.tiempoTerminado = false;
window.IntTiempoRestante = null;

//  PARA LA VISTA CREAR TRAMO [INICIO]
// window.cambiarTramoNuevo = function (origen) {
    // input[type="number"]')
    // $("#tramos option[inicio='8']").show()
    // $("#tramos option").hide()
// }
window.agregarTramoNevo=()=>{
    var opc = $("#tramos option:selected");
    if ($(opc).val()==""){
        // alert("selecciona un tramo");
        $("#tramos").addClass("is-invalid");
    }else{
        var origenDestino = $(opc).val().split("_");
        $("#tbl-NvoItinerario tbody").append("<tr>"
            + "<td hidden><input type='' name='origenDestino[]' value='" + $(opc).val() +"'></td>"
            + "<td>" + $(opc).attr("origen") +"</td>"
            + "<td>" + $(opc).attr("destino") +"</td>"
            + "<td><input type='number' name='kilometros[]' value='0' min='1' class='form-control'></td>"
            + "<td><input type='number' name='tiempo[]' value='0' min='1' class='form-control'></td>"
            + "<td><input type='number' name='estancia[]' value='0' min='0' class='form-control'></td>"
            + "<td><button class='btn btn-danger' onclick='cancelarNuevoTramo(event, \"" + opc[0].id +"\", this)'><i class='fa-solid fa-circle-minus'></i><span>Eliminar</span></button></td>"
            + "</tr>");
        $("#tramos option[nOrigen='" + origenDestino[1]+"']").show()
        $(opc).hide();
        $(opc).parent().val("");
        $("#tramos").removeClass("is-invalid");
    }

    if ($("#tbl-NvoItinerario tr").length > 1){
        $("#btnGuardar").fadeIn();
    }else{
        $("#btnGuardar").fadeOut();
    }
}
window.cancelarNuevoTramo=(e, id, row)=>{
    if(confirm("¿Quitar nuevo tramo?")){
        e.preventDefault();
        $("#" + id).show();
        $(row).parent().parent().remove();
    }
    if ($("#tbl-NvoItinerario tr").length > 1){
        $("#btnGuardar").fadeIn();
    }else{
        $("#btnGuardar").fadeOut();
    }
}

window.agregarTramoNevoItinerario = () => {
    var opc = $("#tramos option:selected");
    var data;
    if ($(opc).val() == "") {
        // alert("selecciona un tramo");
        $("#tramos").addClass("is-invalid");
    } else {
        data = JSON.parse($(opc).attr("data"));

        $("#tbl-NvoItinerario tbody").append("<tr>"
            + "<td class='hidden'><input type='' name='tramo[]' value='" + data.nNumero + "'></td>"
            + "<td>" + data.origen + "</td>"
            + "<td>" + data.destino + "</td>"
            + "<td><input type='' disabled name='kilometros[]' value='" + data.nkilometros+" km' min='1' class='form-control' required></td>"
            + "<td><input type='number' disabled name='tiempo[]' value='" + data.nTiempo +"' min='1' class='form-control' required></td>"
            + "<td><input type='number' disabled name='estancia[]' value='" + data.nEstancia +"' min='0' class='form-control' required></td>"
            + "<td><button class='btn btn-danger' onclick='cancelarTramoItinerario(event, \"" + opc[0].id + "\", this)'><i class='fa-solid fa-circle-minus'></i><span>Eliminar</span></button></td>"
            + "</tr>");
        $("#tramos option").hide();
        $("#tramos option[origen='" + data.nDestino + "']").show()
        $(opc).parent().val("");
        $("#tramos").removeClass("is-invalid");
    }

    if ($("#tbl-NvoItinerario tr").length > 1) {
        $("#btnGuardar").fadeIn();
    } else {
        $("#btnGuardar").fadeOut();
    }
}
window.cancelarTramoItinerario = (evento, id, row) => {
    if (confirm("¿Quitar nuevo tramo?")) {
        evento.preventDefault();
        $("#" + id).show();
        $(row).parent().parent().remove();
    }
    if ($("#tbl-NvoItinerario tr").length > 1) {
        $("#btnGuardar").fadeIn();
    } else {
        $("#btnGuardar").fadeOut();
    }
}

window.toggleCheckboxesByClass = function(target, clase){
    if ($(target).prop("checked")){
        $("."+clase).prop("checked", true);
    }else{
        $("."+clase).prop("checked", false);
    }
}
window.seleccionarAsignarLimbo = function(){
    var boletos=$(".boleto:checked");
    var inpSel=$("#inpSel");
    $(inpSel).val(boletos.length);
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
});

