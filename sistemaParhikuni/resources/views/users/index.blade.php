@extends('layouts.parhikuni')

@section('content')
    <div class="col-12">
        <form action="{{route('users.store')}}" method="POST">
            <div class="row">
                <div class="col-3">
                    <input type="text" name="name" placeholder="Nombre" class="form-control">
                </div>
                <div class="col-3">
                    <input type="email" name="email" placeholder="Email" class="form-control">
                </div>
                <div class="col-3">
                    <input type="password" name="password" placeholder="password" class="form-control">
                </div>
                <div class="col-auto">
                    <input type="submit" name="submit" placeholder="" class="btn btn-small btn-parhi-primary" value="Guardar">
                    @csrf
                </div>
            </div>
        </form>
    </div>
    <table class="table">
        <thead>
            <tr>
                <th class="col-2">ID</th>
                <th class="col-3">Nombre</th>
                <th class="col-3">Email</th>
                <th class="col-auto"> </th>
            </tr>
        </thead>
        <tbody>
            @foreach($users as $user)
                <tr>
                    <td >{{$user->id}}</td>
                    <td >{{$user->name}}</td>
                    <td >{{$user->email}}</td>
                    <td >
                        <form action="{{route('users.destroy',$user)}}" method="POST">
                            @csrf
                            @method('DELETE')
                            <input type="submit" value="eliminar" class="btn btn-sm btn-danger"
                            onclick="return confirm('¿Eliminar usuario?')">
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
@endsection
