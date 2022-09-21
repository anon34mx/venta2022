@extends('layouts.parhikuni')

@section('content')


    <div class="col-8 mx-auto">
        <h3>Editar usuario</h3>
        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif

        <form action="{{route('users.update', $user)}}" method="POST">
            <div class="row">
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="text" name="name" placeholder="Nombre" class="form-control" value="{!! $user->name !!}">
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="email" name="email" placeholder="Email" class="form-control" value="{!! $user->email !!}">
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="password" name="password" placeholder="password" class="form-control" value="">
                </div>
                @csrf
                <div class="col-auto justify-content-center">
                    <!-- <input type="submit" name="submit" placeholder="" class="btn btn-small btn-parhi-primary mx-auto" value="Guardar"> -->
                    <span class="btn-collap" title="Guardar">
                        <label class="btn btn-sm btn-parhi-primary"
                            for="guardar">
                            <i class="fa-solid fa-floppy-disk"></i>
                            <span>Guardar</span>
                        </label>
                        <input id="guardar" type="submit"
                        class="btn">
                    </span>
                </div>
            </div>
        </form>
    </div>
    
@endsection
