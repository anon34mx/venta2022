
(function () {
    'use strict'
    console.log("validaciones activadas");
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
})()

$(document).ready(()=>{
    toggler($(".toggler"), $(".toggler").attr("target"));

    $(".toggler").change(function(){
        toggler($(this), $(this).attr("target"));
    });
    
});

function toggler(inpt, target){
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


function addMinutes(date, minutes) {
    return new Date(date.getTime() + minutes * 60000);
}
/*
function calcHoraLlegada(){
    var inp = $("#horaDeSalida").val().split(":");;
    var today = new Date("2000-01-01 00:00");
    var sel = $("#itinerario option:selected").val();
    var tiempo = $("#tiempo-"+sel).html();
    today.setMinutes(
        (inp[0] * 60) + (parseInt(inp[1])) + parseInt(tiempo)
        );

    console.log(today);
    $("#horaDeLlegada").val(
        (today.getHours() + "").padStart(2, "0")
        +":"+
        (today.getMinutes() + "").padStart(2, "0")
    );
}
*/