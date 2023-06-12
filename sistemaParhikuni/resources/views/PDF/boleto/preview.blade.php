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
                <img class="bg" src="{{ Vite::asset('resources/images/Banners/Fondo.png') }}">
                <!-- <img class="qr" src="{{ Vite::asset('resources/images/logo_parhikuni.png') }}" alt=""> -->
                <div class="qr">
                    {!! QrCode::generate($venta->nNumero) !!}
                </div>
                <div class="resumen">
                    Folio {{$venta->nNumero}}
                    <br>
                    <img src="{{ Vite::asset('resources/images/venta/Autobusito.png') }}" width="18" style="filter: invert(1);">
                        {{sizeof($boletos)}} Boletos - {{$corridaIda->servicio->aDescripcion}}
                    <br>
                    <b><img src="{{ Vite::asset('resources/images/Calendario.png') }}" width="18"> Ida</b>
                    
                    @php
                        $ida=\Carbon\Carbon::parse($corridaIda->fSalida." ".$corridaIda->hSalida);
                        $regreso=null;
                        if($corridaReg != null){
                            $regreso=\Carbon\Carbon::parse(@$corridaReg->fSalida." ".$corridaReg->hSalida);

                        }
                        $format1 = 'l, j \\de F \\de Y';
                        echo $ida->translatedFormat($format1);
                    @endphp

                    @if($corridaReg != null)
                        <br>
                        <b><img src="{{ Vite::asset('resources/images/Calendario.png') }}" width="18"> Regreso</b>
                        {{$regreso->translatedFormat($format1)}}
                    @endif
                </div>
            </div>
        </div>
    </div>
    <div class="col-12 text-center mb-4">
        <button id="reimprimir" class="btn btn-primary ">Reimprimir</button>
    </div>
    <embed id="embededTicket"
    src="data:application/pdf;base64,"
    type="application/pdf" width="100%" height="600px" />
</div>
<script>
    document.addEventListener("DOMContentLoaded",function(){
        @php
        if( session("imprimirBoletos")!=null ){
            @endphp
            consultarBoletos({!!$venta->nNumero!!});
            @php
            }
            session()->forget("imprimirBoletos");
        @endphp

        $("#reimprimir").click(()=>{
            consultarBoletos({!!$venta->nNumero!!});
        });
    });
</script>
@endsection