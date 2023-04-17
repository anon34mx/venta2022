@extends('layouts.parhikuni')
@section('content')
<div class="col-12 mx-0 px-0">
    @if(session()->has('status'))
        <div>
            <p class="alert alert-success">{{session('status')}}</p>
        </div>
    @endif
    @if($errors->any())
        <div class="card-body mt-2 mb-2 ">
            <div class="alert-danger px-3 py-3">
                @foreach($errors->all() as $error)
                - {{$error}}<br>
                @endforeach
            </div>
        </div>
    @endif
    
    <!--
        <iframe src="{{route('venta.interna.boletos', ['venta'=>$venta, 'formato'=>$formato])}}"
            width="100%" height="450px"> </iframe>
    -->
    <div id="msgCompraRealizada" class="col-12 mx-0 px-0 msgCompraRealizada" style="">
        <div class="rojo">
            <h4>
                <center>
                    <b>Compra realizada</b>
                </center>
            </h4>
            <center>
                Imprimiendo boletos
            </center>
        </div>
        <div class="naranja">
            <div class="qrCont">
                <img class="bg" src="{{ Vite::asset('resources/images/logo_parhikuni.png') }}" alt="">
                <img class="qr" src="{{ Vite::asset('resources/images/logo_parhikuni.png') }}" alt="">
                <div class="resumen">
                    SERVICIO PLATINUM X ADULTOS X MENORES X INSEN 
                    <BR>
                    XX/XX/ 00:00 XX/XX/ 00:00
                    ORIGEN - DESTINO | ORIGEN - DESTINO
                </div>
            </div>
        </div>
    </div>
    <embed id="embededTicket"
    src="data:application/pdf;base64,"
    type="application/pdf" width="80%" height="600px" hidden/>
</div>
<script>
    document.addEventListener("DOMContentLoaded",function(){
        consultarBoletos({!!$venta->nNumero!!});
    });
</script>
@endsection