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
    $("."+elementos).removeClass("selected");
    $(ev.target).addClass("selected");

    $("#horario"+horario).prop("checked", true);

    var hInicio, hFin;
    switch (horario) {
        case "Madr":
            hInicio = "00:00:00";
            hFin = "06:00:00";
            break;
        case "Maña":
            hInicio = "06:00:00";
            hFin = "12:00:00";
            break;
        case "Tard":
            hInicio = "12:00:00";
            hFin = "18:00:00";
            break;
        case "Noch":
            hInicio = "18:00:00";
            hFin = "23:59";
            break;
        default:
            hInicio="00:00:00";
            hFin="23:59";
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
    var estudiantes =   parseInt($("#insen").val() | 0);
    var profesores =    parseInt($("#profesores").val() | 0);
    var tarifa = parseFloat($("#disp-" + disponibilidad + " .tarifa span").html() | 0);

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
window.validarPromociones=()=>{
    
}
// Etapa 2 asientos
window.selecAsiento=function(){
    console.log(this)
}
window.seleccionarAsiento=(asientoAnt,asientoNvo)=>{
    var nuevo = $("#asiento-" + asientoNvo.value);
    var anterior = $("#asiento-" + asientoAnt);

    
    if (!$(nuevo).hasClass("apartado") && !$(nuevo).hasClass("ocupado")){
        $("#asiento-" + asientoNvo.value).addClass("apartado");
        anterior.removeClass("apartado")
    }else{
        alert("El asiento ya está ocupado");
        $(asientoNvo).val(asientoAnt);
    }
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
    var recibido = $("#recibido").val();
    var total = $("#total").val();
    var calc = (total - recibido).toFixed(2);
    $("#cambio").val(Math.abs(calc));
    if(calc>0){
        $("#cambio-lbl").html("faltan");
    }else{
        $("#cambio-lbl").html("Cambio");
    }
}
window.mirrorCheck=()=>{

}
$(document).ready(()=>{
    setTimeout(() => {
        $(".alert").hide(666);
    }, 10000);

    window.tiempoRestante = $("#tiempoRestante").attr("initial");

    $(".asiento").click(selecAsiento);
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
    $(".promociones").change((ev)=>{
        var prms = $(".promociones");
        var seleccionadas=0;
        var selectList = ev.target; // donde cambie el valor
        var row = ev.target.attributes.row.value;
        for(var i=0; i<prms.length; i++){
            var list = $("#" + prms[i].id);
            if (list.value!=""){
                seleccionadas++;
            }
        };
        if (seleccionadas > promos.disponibles){
            ev.target.value="";
            alert("No se pueden usar más promociones");
        }else{
            var idsel = $(selectList).children()[selectList.selectedIndex].value; // la fila
            var importe = $("#asiento-"+row+" .tarifa span").html(); //columna importe
            var importeSinDescConIVA=(importe*1.16).toFixed(2);
            if (ev.target.value!=""){
                var descuentoAplicado = $("#promo-" + idsel + " span").html(); // descuento seleccionado de la lista
                var importeConDescuentoConIva = ((importe - (importe * descuentoAplicado)) * 1.16).toFixed(2);
                
                $("#asiento-" + row + " .subtotal").html(
                    '<span class="original textoTachado">$'+importeSinDescConIVA+'</span>'
                    +'$<span class="porPagar">' + importeConDescuentoConIva + '</span>');
            }else{
                $("#asiento-" + row +" .subtotal").html('$<span class="porPagar">'+importeSinDescConIVA+'</span>')
            }
            var x = $(".porPagar");
            var total=0;
            for (let i = 0; i < x.length; i++) {
                total = total + parseFloat($(x[i]).html());
            }
            $("#total").html("$"+total.toFixed(2));
        }
        
    });
    $(".tipoDeViaje").on("change",function(){
        // $("#tipoDeViaje").val(this.value);
        console.log(this.value);
        if (this.value == "redondo"){
            $("#tipoDeViaje").prop("checked", true);
        }else{
            $("#tipoDeViaje").prop("checked", false);
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
        .keyup(calcularCambio);
});

