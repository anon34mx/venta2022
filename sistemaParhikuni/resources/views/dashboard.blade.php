@extends('layouts.parhikuni')

@section('content')
    <div class="col-12 col-sm-10 col-md-8 col-lg-10 mx-auto">
        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif
        @if (session('status'))
            <div class="alert alert-success alert-float-br">
                {{ session('status') }}
            </div>
        @endif


        <h3>Bienvenido</h3>
        Poner accesos a los modulos que tiene o a ver qué
    </div>
    
@endsection
