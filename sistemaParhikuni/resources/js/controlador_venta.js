// variables
window.asientoAnt = 0;
window.tiempoRestante = 0;
window.tiempoTerminado = false;
window.IntTiempoRestante = null;

window.cargarDestinos = function (origen, comprimir) {
    $.ajax({
        url: "/oficina/" + origen + "/destinos/" + comprimir,
        method: "get",
        success: function (response) {
            $("#destino").empty();
            $("#destino").append('<option value="">Seleccione Destino</option>');
            response.forEach(element => {
                $("#destino").append('<option value="' + element.nDestino + '">' + element.destino + '</option>');
            });
        }
    });
}
window.seleccionarCorrida = function (fila, corr, disp) {
    $(".selected").removeClass("selected");
    $("#corr").val(corr);
    $("#disp").val(disp);
    $(fila).addClass("selected");
}

window.validarFechaReg = function () {
    $(".fechaRegreso").attr("min", $(".fechaSalida").val());

    if ($(".fechaRegreso").val() < $(".fechaSalida").val()){
        $(".fechaRegreso").val($(".fechaSalida").val())
    }
}
window.validarFechas = function (primera, segunda) {
    $(segunda).attr("min", $(primera).val());

    if ($(segunda).val() < $(primera).val()){
        $(segunda).val($(primera).val())
    }
}

window.getRecorrido = function (corridaDisponible, origen, destino) {
    // es el itinerario pero ya con fecha y hora
    $.ajax({
        "url": `/corridas/disponibles/${corridaDisponible}/recorrido/${origen}/${destino}`,
        success: function (response) {
            $("#exampleModalLong .modal-body").html(response);
            $("#exampleModalLong").modal('show');
        }
    });
}
window.cambiarHorario=(horario, ev, elementos)=>{
    ev.preventDefault();
    // $("."+elementos).removeClass("selected");
    $(ev.target).addClass("selected");
    $("#horario"+horario).prop("checked", true);
    var hInicio, hFin;
    console.log(horario);
    switch (horario) {
        case "Madr":
            hInicio = "00:00:00";
            hFin = "06:00:00";
            $("#inptbusH").val("0%");
            $(".horarioTxt").html("madrugada");
            break;
        case "Maña":
            hInicio = "06:00:00";
            hFin = "12:00:00";
            $("#inptbusH").val("25%");
            $(".horarioTxt").html("mañana");
            break;
        case "Tard":
            hInicio = "12:00:00";
            hFin = "18:00:00";
            $("#inptbusH").val("50%");
            $(".horarioTxt").html("tarde");
            break;
        case "Noch":
            hInicio = "18:00:00";
            hFin = "23:59";
            $("#inptbusH").val("75%");
            $(".horarioTxt").html("noche");
            break;
        default:
            hInicio = "00:00:00";
            hFin = "23:59";
            $("#inptbusH").val("100%");
            $(".horarioTxt").html("todo el día");
            break;
    }
    $("#hInicio").val(hInicio);
    $("#hFin").val(hFin);
}
window.validarFiltros=()=>{
    var corrida = $("#corr").val();
    var disponibilidad = $("#disp").val();
    var adultos =       parseInt($("#adultos").val() | 0);
    var niños =         parseInt($("#niños").val() | 0);
    var insen =         parseInt($("#insen").val() | 0);
    var estudiantes =   parseInt($("#estudiantes").val() | 0);
    var profesores =    parseInt($("#profesores").val() | 0);
    var tarifa =        parseFloat($("#disp-" + disponibilidad + " .tarifa span").html() | 0);

    var errorMsg="";

    if(adultos+niños+insen+estudiantes+profesores == 0){
        errorMsg+="*Selecciona el número de pasajeros\n";
    }
    if (adultos + insen + estudiantes + profesores == 0 && niños>0){
        errorMsg+="*Los niños deben viajar acompañados de un adulto\n";
    }
    if(corrida==0 || disponibilidad==0){
        errorMsg+="*Selecciona una corrida\n";
    }
    if (tarifa == 0 && corrida!=0){
        errorMsg+="*La corrida no cuenta con una tarifa.\n";
    }

    if(errorMsg!=""){
        alert(errorMsg);
        return false;
    }else{
        return true;
    }
}
// Etapa 2 asientos
window.selecAsiento=function(){
    if ($(this).hasClass("apartado") == false && $(this).hasClass("ocupado") == false){
        var pasajerosCount = $("#tbl-datosPasajeros tbody tr").length;
        if (pasajerosCount < totalPasajeros){
            $(this).addClass("apartado");
            var select = $("#posiblesPasajeros .listaPasajeroTipo").parent().html();
            var row = $.parseHTML(`<tr id="pasajero-${pasajerosCount}" class="pt-1 pb-1 pasajeroContainer" asiento="` + this.attributes.numero.value + `" pasajero="${pasajerosCount}">
                <td class="tipo px-2">
                    <input class="pasajeroTipo" name="pasajeroTipo[]" value="" hidden readonly required tabindex="-1">
                    `+ "" +`
                </td>
                <td class="px-2">
                    <input type="number" name="asiento[]" id="asiento[{{$contAuxPasajeros}}]"
                        class="px-2 form-control form-control-sm pasajeroAsiento" value="${this.attributes.numero.value}" readonly>
                </td>
                <td class="px-2">
                    <input class="form-control form-control-sm pasajeroNombre" type="text" name="pasajero[]" id="pasajero[{{$contAuxPasajeros}}]"
                        value="" autocomplete="off" list="listaPasajeros">
                </td>
                <td class="px-2">
                    <button id="cancelar-${this.attributes.numero.value}" onclick="event.preventDefault();quitarPasajero(this);"
                        class="hidden"></button>
                    <label class="btn btn-sm btn-danger float-right" for="cancelar-${this.attributes.numero.value}">
                        <i class="fa-solid fa-xmark"></i>
                        </label>
                        </td>
                </tr>`);
            console.log($(row).find(".tipo").append(select));
            $("#tbl-datosPasajeros tbody").append(row);
            $($(row).find(".listaPasajeroTipo")).on("change", function () {
                selecTipoPasajero(this);
            });
        }else{
            alert("Máximo de pasajeros");
        }
    }
}
window.selecTipoPasajero=function(lista){
    var tipoSel = $(lista).val();
    if (tipoSel!=""){
        $(lista).parent().find(".pasajeroTipo").val(tipoSel);
        Object.keys(pasajeros).forEach(function (key){
            var usados = $(`#tbl-datosPasajeros .listaPasajeroTipo option:selected[value='${key}']`);
            pasajeros[key]["usados"] = usados.length;
            if (pasajeros[key]["usados"] >= pasajeros[key]["max"]){
                $(`.listaPasajeroTipo option[value='${key}']`).prop("disabled", true);
            }else{
                $(`.listaPasajeroTipo option[value='${key}']`).prop("disabled", false);
                // $(usados).prop("disabled", false)
            }
        });
    }else{
        var key=$(lista).parent().find("input").val();
        console.log(key);
        pasajeros[key]["usados"]--;
        if(pasajeros[key]["usados"]<pasajeros[key]["max"]){
            $(`.listaPasajeroTipo option[value='${key}']`).prop("disabled", false);
        }
        $(lista).parent().find("input").val("");
    }
}
window.selecAsientoReg=function(){
    if (!$(this).hasClass("apartado") && $("#tipoNombrePasajeroCont").is(":hidden")) { // 
        if ($(".asiento.apartado").length < $("#pasajeros tr").length){
            window.asientoAnt = this.attributes.numero.value;
            $("#tipoNombrePasajero").val("");
            $(this).addClass("apartado");
            $("#tipoNombrePasajeroCont").fadeIn();
            $("#tipoNombrePasajero").focus()
        }else{
            alert("maximo de pasajeros");
        }
    } else if ($(this).hasClass("apartado")){
        quitarPasajeroR(this.attributes.numero.value);
    }
    // event.preventDefault(); 
}
window.cancelSelecAsientoReg = function () {
    $("#tipoNombrePasajeroCont").fadeOut();
    $(`#asiento-${asientoAnt}`).removeClass("apartado");
}
window.selecAsientoPasaReg=function(){
    var id = $(this).find("option:selected");
    if (id[0].value != "" && asientoAnt!=0){
        $(id).remove();
        $("#tipoNombrePasajeroCont").fadeOut();
        $("#tbl-datosPasajeros tbody").append(`
            <tr pasajero="${asientoAnt}">
                <td hidden><input class="form-control form-control-sm id" name="id[]" value="`+ $(`#pasajeros [pasajero=${id[0].value}] .id`).html() +`"></td>
                <td>
                    <input readonly class="form-control form-control-sm tipo" name="tipo[]" value="`+ $(`#pasajeros [pasajero=${id[0].value}] .tipo span`).html() +`">
                    <input hidden readonly class="form-control form-control-sm tipoID" name="tipoID[]" value="`+ $(`#pasajeros [pasajero=${id[0].value}] .tipoID span`).html() +`">
                </td>
                <td><input readonly class="form-control form-control-sm asientoSel" name="asiento[]" value="${asientoAnt}"></td>
                <td><input readonly class="form-control form-control-sm pasajero" name="nombre[]" value="`+ $(`#pasajeros [pasajero=${id[0].value}] .pasajero span`).html() +`"></td>
                <td class="px-2">
                    <button id="cancelar-${id[0].value}" onclick="event.preventDefault();quitarPasajeroR(${asientoAnt});"
                        class="hidden"></button>
                    <label class="btn btn-sm btn-danger float-right" for="cancelar-${id[0].value}">
                        <i class="fa-solid fa-xmark"></i>
                        </label>
                </td>
            </tr>
        `);
    }

}
window.quitarPasajero=function(fila){
    fila = fila.parentElement.parentElement;
    var tipoS = $(fila).find(".pasajeroTipo").first().val();
    $("#asiento-" + fila.attributes.asiento.value).removeClass("apartado");
    $(fila).remove();
    pasajeros[tipoS]["usados"]++;
    if (pasajeros[tipoS]["usados"] > 0) {
        console.log("volver a habilitar " + tipoS);
        console.log(pasajeros);
        $(".listaPasajeroTipo option[value='" + tipoS + "']").prop('disabled', false);
    }
}
window.quitarPasajeroR=function(asiento){
    console.log(asiento);
    var id = $(`#tbl-datosPasajeros tbody tr[pasajero=${asiento}] .id`).val();
    var newId = $(`#tbl-datosPasajeros tbody tr[pasajero=${asiento}] .id`).val();
    var nombre = $(`#tbl-datosPasajeros tbody tr[pasajero=${asiento}] .pasajero`).val();

    $(`#tbl-datosPasajeros tr[pasajero=${asiento}]`).remove();
    $("#asiento-" + asiento).removeClass("apartado");
    $("#tipoNombrePasajero").append(`
        <option value="${id}">`
        + $(`#pasajeros [pasajero=${id}] .tipo span`).html() + " - " + $(`#pasajeros [pasajero=${id}] .pasajero span`).html()
        +`</option>`)
}
window.validarTiposSelec=function(){
    
}

window.validarNombre=(txt)=>{
    var regex = /([a-zA-ZñÑ]{3,})+((\x20)+([a-zA-z]{2,})){1,}/;
    return txt.match(regex)!=null ? true : false;
}
window.validarPasajerosAsientos=()=>{
    var pasajeros = $(".pasajeroContainer");
    var msgError = "";
    var errorNombres=false, errorAsientos=false;
   for(var i=0; i<pasajeros.length; i++){
       if (!validarNombre($(pasajeros[i]).find(".pasajeroNombre").val()) && errorNombres==false){
           msgError+="* Escriba un nombre y un apellido para cada pasajero.\n"
           errorNombres=true;
       }
       if ($(pasajeros[i]).find(".pasajeroAsiento").val() == "" && errorAsientos==false){
           msgError += "* Seleccione un asiento para cada pasajero";
           errorAsientos=true;
       }
    };
    if(msgError != ""){
        alert(msgError);
        return false;
    }else{
        return true;
    }
}
// recibe segundos
window.convertirSegundosaTiempo = (tiempo) => {
    var horas = Math.floor(tiempo / 3600);
    var minutos = Math.floor((tiempo / 60)-horas*60);
    var segundos = (tiempo % 60 );
    var milisegundos =0;// = ((segundos - Math.floor(segundos))*100).toFixed(0);

    var retorno="";
    if(horas>0)
        retorno += (horas+"").padStart(2, "0")+":";
    // if(minutos>0)
        retorno += (minutos+"").padStart(2, "0")+":";
    // if(segundos>0)
        retorno += (Math.floor(segundos) + "").padStart(2, "0");
    // if(milisegundos>0)
        // retorno += ("." + milisegundos).padStart(2, "0");
    return retorno;
    // return (horas + ":" + minutos + "." + segundos);
}
window.calcularCambio = ()=>{

    var recibidotxt = $("#recibido").val().replace(/[,|_]/g, "");
    var recibido = recibidotxt == "" ? 0 : parseFloat(recibidotxt);
    var total = parseFloat($("#total").val().replace(/[,]/, ""));
    var calc = parseFloat(total - recibido);
    $("#cambio").val(Math.abs(calc).toFixed(2));
    if(calc>0){
        $("#cambio-lbl").html("faltan");
    }else{
        $("#cambio-lbl").html("Cambio");
    }
}
window.calcularDescuento= async function(row){
    // console.log(row);
    var pBaseSinIva = parseFloat($(row).find(".siniva").html());
    var pIva = parseFloat($(row).find(".iva").html());

    var pOriginal = $(row).find(".original ");
    var pPorpagar = $(row).find(".porPagar ");
    var promo = $(row).find(".promociones option:selected");

    var pagar = (pBaseSinIva + pIva) - ((pBaseSinIva + pIva) * $(promo).attr("porcentaje"));
    $(pPorpagar).html(pagar.toFixed(2));

    if ($(promo).attr("porcentaje") > 0){
        $(row).find(".original.textoTachado").fadeIn(200)
    }else{
        $(row).find(".original.textoTachado").fadeOut(200)
    }

    var sb = $(row).parent().find(".porPagar");
    var totalApagar=0;
    for (let index = 0; index < sb.length; index++) {
        totalApagar += parseFloat(sb[index].innerHTML)
    }
    var ttl = $(row).parent().parent().find("tfoot tr th .total").html("$"+totalApagar.toFixed(2));
}

window.mirrorInput=function(inp){
    console.log(inp);
    $($(inp).attr("target")).val($(inp).val());
}

window.autobusHora=function(pos){
    $("#busH").css("left", pos+"%")
}
window.leerTarjetaBancaria = function(){
    try {
        window.chrome.webview.postMessage('{Metodo:"leerTarjetaBancaria"}');
    } catch (error) {
        
    }
}
window.llenarTarjeta = function(datos) {
    document.getElementById('tarjeta').value = datos.tarjeta;
    document.getElementById('expiracion').value = datos.expiracion;
    document.getElementById('ccv').value = datos.ccv;
}
window.consultarBoletos=function(IDventa){
    $.ajax({
        url: route('venta.interna.boletos', { 'venta': IDventa, 'formato': 'B64'}),
        success: function(response) {
            $("#embededTicket").attr("src", "data:application/pdf;base64," + response);
            try {
                window.chrome.webview.postMessage('{Metodo:"descargarBoletos", Datos:"'+response+'"}');
            } catch (error) {
                
            }
        }
    });
}
// INICIO
$(document).ready(()=>{
    $(".mirrorInput").on("change", function(event){
        mirrorInput(this);
    });

    $(".fechaSalida").on("change", validarFechaReg);

    setTimeout(() => {
        $(".alert").hide(666);
    }, 10000);

    window.tiempoRestante = $("#tiempoRestante").attr("initial");

    $("#asientos-ida .asiento").click(selecAsiento);
    // $("#asientos-reg .asiento").click(selecAsientoReg);
    $(".asiento.regreso").on("click", selecAsientoReg);
    $("#tipoNombrePasajero").on("change", selecAsientoPasaReg);

    $(".pasajeroAsiento, .pasajeroAsiento input").on("focus", function () {
        window.asientoAnt = this.value;
    })
    .on("change", function(){
        seleccionarAsiento(window.asientoAnt,this);
        window.asientoAnt = this.value;
    });

    $("#usarPromocionF").on("change", function(){
        // console.log($(this).prop("checked"));
        $("#" + $(this).attr("target")).prop("checked", $(this).prop("checked"));
    });

    $("#pasajerosAsientos").on("submit", ()=>{
        return validarPasajerosAsientos();
    });


    $(".cantidadPasajeros").on("click", (event) => {
        event.preventDefault();
        var inputs = $(".contadorPasajeros");
        var totalPasajeros=0;

        var inputActual = $(event.target.parentElement.parentElement).find("input");
        var nxtVal=0;
        var step = parseInt($(inputActual).attr("step"));
        var min = parseInt($(inputActual).attr("min"));
        var max = parseInt($(inputActual).attr("max"));

        //contar el total
        for (var i = 0; i < inputs.length; i++){
            totalPasajeros += parseInt(inputs[i].value);
        }

        if (event.target.value == "+"){
            totalPasajeros+=1;
            nxtVal=parseInt($(inputActual).val())+1;
        } else if (event.target.value == "-"){
            totalPasajeros-=1;
            nxtVal=parseInt($(inputActual).val())-1;
        }

        if(totalPasajeros>10){
            alert("Máximo 10 pasajeros");
        }else{
            if(nxtVal<min){
                $(inputActual).val(min);
            }else{
                $(inputActual).val(nxtVal);
            }
        }

        
        $("#adultos").val($("#inpt-adultos").val());
        $("#niños").val($("#inpt-niños").val());
        $("#insen").val($("#inpt-insen").val());
    });
    $(".promociones").change(function(){
        calcularDescuento(this.parentElement.parentElement);
    });

    $(".tipoDeViaje").on("change",function(){
        if (this.value == "redondo"){
            $("#tipoDeViaje").prop("checked", true);
            $(".selectReg").fadeIn();
        }else{
            $("#tipoDeViaje").prop("checked", false);
            $(".selectReg").fadeOut();
        }
    });

    $("#tiempoRestante").val(convertirSegundosaTiempo(window.tiempoRestante));

    window.IntTiempoRestante=setInterval(()=>{
        window.tiempoRestante = window.tiempoRestante-1;
        $("#tiempoRestante").val(convertirSegundosaTiempo(window.tiempoRestante));
        if (tiempoRestante <= 0 && window.tiempoTerminado==false){
            $("input").prop("disabled", true);
            $("buton").prop("disabled", true);
            $("a").prop("disabled", true);
            $("#cancelarCompra").prop("disabled", false);
            window.location.href = "/ventaInterna/cancelarCompra";
            window.tiempoTerminado = true;
        }
    },1000);

    $("#recibido")
        .change(calcularCambio)
        .keydown(calcularCambio)
        .keyup(calcularCambio)
        .focus(calcularCambio);
        
    // $("#borrarRecibido").click(function(event){
    //     event.preventDefault();
    //     calcularCambio();
    // });
    $("#borrarRecibido").on("click", function(event){
        event.preventDefault();
        $('#recibido').val('')
        $("#recibido").focus();
    });
});

