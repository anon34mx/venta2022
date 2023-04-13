(function () {
    'use strict'

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
    
    // $(".tabGroup input[type='radio']").change(function(){
    //     $(this).parent().parent().find(".views").hide(0);
    //     $(this).parent().parent().parent().find($(this).attr("target")).show(0);
    // });
    pestanas(".tabGroup");
});

window.toggler=function(inpt, target){
    // input para saber el valor, si deben ser requeridos o no
    // target, el contenedor de los elementos
    if($(inpt).prop("checked") == true){
        $(target).show();
        if ($(inpt).attr("targetRequired") == "" || $(inpt).attr("targetRequired") == "required") {
            $(target + " input").attr("required", "required")
            $(target + " select").attr("required", "required")
        } else {
            $(target + " input").removeAttr("required");
            $(target + " select").removeAttr("required");
        }
    }else{
        $(target).hide();
        $(target + " input").removeAttr("required");
        $(target + " select").removeAttr("required");
    }
}
window.quitarFiltros=()=>{
    window.location = window.location.pathname;
}


/***/

window.pestanas=function(group){
    $(group).find("input[type='radio']").change(function () {
        var target = $(group).find("input[type='radio']:checked");
        var views = $(this).parent().parent().parent()

        console.log($(target.attr("target")))
        $(views).find(".views").css("display", "none");
        $(views).find(".views input:not([readonly]), select").prop("disabled",true);
        
        setTimeout(() => {
            $(target.attr("target")).css("display", "block");
            $(target.attr("target")).find("input:not([readonly]), select").prop("disabled", false);
        }, 30);
    });
}