@if($errors->any())
    <div class="card-body mt-2 mb-2 ">
        <div class="alert-danger px-3 py-3">
            @foreach($errors->all() as $error)
            - {{$error}}<br>
            @endforeach
        </div>
    </div>
@endif
@if(session()->has('status'))
    <div>
        <p class="alert alert-success">{{session('status')}}</p>
    </div>
@endif

@if(session()->has("cmpra_tiempoCompra"))
<div class="tiempoRestanteCont row col-12 mx-0 px-1 linea-inf-bnco">
    <div class="col-12 col-md-6 mx-0 px-0 text-center float-right">
        Tiempo para la compra
    </div>
    <div class="col-12 col-md-6 mx-0 px-0 px-0 float-right">
        <input id="tiempoRestante"
            readonly class="text-center input-trans-osc"
            step="3600000" initial="{{session("cmpra_tiempoCompra")-time()}}">
    </div>
</div>
@endif
<script id="oneTab">
async function oneTab(pagina){
    // Broadcast that you're opening a page.
    localStorage.openpages = await Date.now();
    var onLocalStorageEvent = await function(e){
        if(e.key == "openpages"){
            // otras pestañas
            localStorage.page_available = Date.now();
        }
        if(e.key == "page_available"){
            //esta pestaña
            window.location.replace( route('oneTab', {reason: "Sólo puedes abrir una instancia de la venta"}) );
        }
        if(e.url.match(window.location.origin+pagina)){
        }
    };
    var urlbase=window.location.origin+"/ventaInterna/";
    await window.addEventListener('storage', onLocalStorageEvent, false);
    setTimeout(function(){
        $("#oneTab").remove();
    }, 100);
}
setInterval(() => {
    $.ajax({
        url: route("tiempoRestanteCompra"),
        success: function (response) {
            window.tiempoRestante=parseInt(response);
        },
        error: function (e) {
            console.log(e);
        }
    });
}, 1000);

// oneTab("/ventaInterna");
oneTab("{{$rest}}");
</script>