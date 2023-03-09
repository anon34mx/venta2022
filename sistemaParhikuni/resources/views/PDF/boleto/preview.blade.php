@extends('layouts.parhikuni')

@section('content')
<div class="col-12 col-sm-10 col-md-8 col-lg-11 mx-auto">
    <h3>Tus boletos</h3>
    <p>Compra #{{$venta->nNumero}}</p>

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

    
    <iframe src="{{route('venta.interna.boletos', $venta)}}"
    width="50%" height="450px"> </iframe>
    asd
    <embed
    src="data:application/pdf;base64,{{@$boleto}}"
    type="application/pdf" width="100%" height="600px"/>
</div>
@endsection