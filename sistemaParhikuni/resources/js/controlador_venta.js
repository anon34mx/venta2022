window.cargarDestinos = function (origen, comprimir) {
    $.ajax({
        url: "/oficina/" + origen + "/destinos/" + comprimir,
        method: "get",
        success: function (response) {
            $("#destino").empty();
            $("#destino").append('<option value="">Seleccione Destino</option>');
            response.forEach(element => {
                console.log(element);
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
window.validarFiltros=()=>{
    var corrida = $("#corr").val();
    var disponibilidad = $("#disp").val();
    var adultos =       parseInt($("#adultos").val() | 0);
    var niños =         parseInt($("#niños").val() | 0);
    var insen =         parseInt($("#insen").val() | 0);
    var estudiantes =   parseInt($("#insen").val() | 0);
    var profesores =    parseInt($("#profesores").val() | 0);

    var errorMsg="";

    if(adultos+niños+insen+estudiantes+profesores == 0){
        errorMsg+="*Selecciona el número de pasajeros\n";
    }
    if(corrida==0 || disponibilidad==0){
        errorMsg+="*Selecciona una corrida\n";
    }

    if(errorMsg!=""){
        alert(errorMsg);
        return false;
    }else{
        return true;
    }
}
// Etapa 2 asientos
window.seleccionarAsiento=(asientoAnt,asientoNvo)=>{
    var nuevo = $("#asiento-" + asientoNvo.value);
    var anterior = $("#asiento-" + asientoAnt);

    
    if (!$(nuevo).hasClass("apartado") && !$(nuevo).hasClass("ocupado")){
        $("#asiento-" + asientoNvo.value).addClass("apartado");
        anterior.removeClass("apartado")
    }else{
        alert("no se puede");
        $(asientoNvo).val(asientoAnt);
    }
    // if(!$(asiento).hasClass("ocupado")){
    //     $(asiento).addClass("ocupado");
    //     console.log("ocupado");
    // }else{
    //     $(asiento).removeClass("ocupado");
    //     console.log("desocupado");
    // }
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

window.asientoAnt = 0;  // var
window.tiempoRestante =0 ;
window.IntTiempoRestante = null ;

window.calcularTiempoRestante = (tiempo) => {
    var minutos = (Math.floor(tiempo / 60) + "").padStart(2, "0");
    var segundos = (tiempo % 60 + "").padStart(2, "0");
    return (minutos + ":" + segundos);
}
$(document).ready(()=>{
    window.tiempoRestante = $("#tiempoRestante").attr("initial");

    $(".pasajeroAsiento, .pasajeroAsiento input").on("focus", function () {
        window.asientoAnt = this.value;
    })
    .on("change", function(){
        seleccionarAsiento(window.asientoAnt,this);
        window.asientoAnt = this.value;
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
            alert("maximo 10");
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

    $("#tiempoRestante").val(calcularTiempoRestante(window.tiempoRestante));
    window.IntTiempoRestante=setInterval(()=>{
        window.tiempoRestante = window.tiempoRestante-1;
        // console.log(calcularTiempoRestante(window.tiempoRestante));
        $("#tiempoRestante").val(calcularTiempoRestante(window.tiempoRestante));
        if (tiempoRestante<=0){
            clearInterval(window.IntTiempoRestante);
            // window.IntTiempoRestante=null;
            // console.log("redirigir");
            window.location.href = "/ventaInterna/corridas";
        }
    },1000);
});

