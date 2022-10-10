
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