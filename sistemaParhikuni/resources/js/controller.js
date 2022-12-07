// const { forEach } = require("lodash")

(function () {
    'use strict'

    $(".cantidadPasajeros").on("click",(event)=>{
        event.preventDefault();
        var inp = $(event.target.parentElement.parentElement).find("input");
        var step = parseInt($(inp).attr("step"));
        var min = parseInt($(inp).attr("min"));
        var max = parseInt($(inp).attr("max"));
        console.log(inp);

        switch (event.target.value) {
            case "+":
                console.log("+");
                $(inp).val(parseInt($(inp).val()) + step);
                if (parseInt($(inp).val()) > max) {
                    $(inp).val(max);
                }
                break;
            case "-":
                console.log("-");
                $(inp).val(parseInt($(inp).val()) - step);
                if (parseInt($(inp).val()) < min){
                    $(inp).val(min);
                }
                break;
        
            default:
                break;
        }
    });
    // console.log("validaciones activadas");
    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    var forms = document.querySelectorAll('.needs-validation')

    // Loop over them and prevent submission
    Array.prototype.slice.call(forms)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })

    function calcHoraLlegada() {
        var inp = $("#horaDeSalida").val().split(":");;
        var today = new Date("2000-01-01 00:00");
        var sel = $("#itinerario option:selected").val();
        var tiempo = $("#tiempo-" + sel).html();
        today.setMinutes(
            (inp[0] * 60) + (parseInt(inp[1])) + parseInt(tiempo)
        );

        console.log(today);
        $("#horaDeLlegada").val(
            (today.getHours() + "").padStart(2, "0")
            + ":" +
            (today.getMinutes() + "").padStart(2, "0")
        );
    }

    /*
        document.getElementById('xyz').printMe();
        document.getElementsByClassName('xyz')[0].printMe();
    */
    HTMLElement.prototype.printMe = printMe;
    function printMe(query) {
        var myframe = document.createElement('IFRAME');
        myframe.domain = document.domain;
        myframe.style.position = "absolute";
        myframe.style.top = "-10000px";
        document.body.appendChild(myframe);
        myframe.contentDocument.write(this.innerHTML);
        setTimeout(function () {
            myframe.focus();
            myframe.contentWindow.print();
            myframe.parentNode.removeChild(myframe);// remove frame
        }, 3000); // wait for images to load inside iframe
        window.focus();
    }

    function addMinutes(date, minutes) {
        return new Date(date.getTime() + minutes * 60000);
    }
})()

$(document).ready(()=>{
    toggler($(".toggler"), $(".toggler").attr("target"));

    $(".toggler").change(function(){
        toggler($(this), $(this).attr("target"));
    });
    
});

window.toggler=function(inpt, target){
    if($(inpt).prop("checked") == true){
        $(target).show();
        if ($(inpt).attr("targetRequired") == "" || $(inpt).attr("targetRequired") == "required") {
            $(target + " input").attr("required", "required")
        } else {
            $(target + " input").removeAttr("required");
        }
    }else{
        $(target).hide();
        $(target + " input").removeAttr("required");
    }
}

window.cargarDestinos=function(origen,comprimir){
    $.ajax({
        url: "/oficina/"+origen+"/destinos/"+comprimir,
        method: "get",
        success: function (response) {
            $("#destino").empty();
            $("#destino").append('<option value="">Seleccione Destino</option>');
            response.forEach(element => {
                console.log(element);
                $("#destino").append('<option value="' + element.nDestino +'">' + element.destino +'</option>');
            });
        }
    });
}
window.seleccionarCorrida = function (fila, corr, disp) {
    $(".selected").removeClass("selected");
    $("#corr").val(corr);
    $("#disp").val(disp);
    // (fila)=>{
        $(fila).addClass("selected");
        // }
}
window.getRecorrido = function (corridaDisponible, origen, destino) {
    // http://localhost:8000/corridas/disponibles/63/itinerario
    $.ajax({
        "url": `/corridas/disponibles/${corridaDisponible}/recorrido/${origen}/${destino}`,
        success:function(response){
            $("#exampleModalLong .modal-body").html(response);
            $("#exampleModalLong").modal('show');
            console.log(response);
            // let htmlR="";
            // let long=0;
            // let cont=0;
            // response=JSON.parse(response);
            // long = response.length;

            // response.forEach(tramo => {
            //     if (cont==0){
            //         htmlR = htmlR + "" + tramo.origenNombre + "_" + tramo.hSalida + "";
            //         htmlR = htmlR + "" + tramo.destinoNombre +"_"+tramo.hLlegada + "<br>";
            //     } else {
            //         htmlR = htmlR + "" + tramo.destinoNombre + "_" + tramo.hLlegada + "<br>";
            //     }
            //     cont++;
            // });

            // $("#exampleModalLong .modal-body").html(htmlR);
            // $("#exampleModalLong").modal('show');
        }
    });
}
/*
 * cuando va en la plantilla
 *         
 *
    window.cargarDestinos=function(origen){
        $.ajax({
            url: "{{route('corridas.disponibles.destinos')}}",
            method: "post",
            data:{
                "_token" : "{{csrf_token()}}",
                "origen": origen
            },
            success: function (response) {
                $("#destino").empty();
                $("#destino").append('<option value="">Seleccione Destino</option>');
                response.forEach(element => {
                    $("#destino").append('<option value="' + element.nDestino +'">' + element.destino +'</option>');
                });
            }
        });
 */