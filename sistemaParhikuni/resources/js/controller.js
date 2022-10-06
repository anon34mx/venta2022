$(document).ready(()=>{

    toggler($(".toggler").prop("checked"), $(".toggler").attr("target"));
    $(".toggler").change(function(){
        // console.log($(this).prop("checked"));
        toggler($(this).prop("checked"), $(this).attr("target"));
    });
});

function toggler(in_val, target){
    // console.log(btn.checked);
    in_val == true ? $(target).fadeIn(200) : $(target).fadeOut(200);
}