@extends('layouts.parhikuni')

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
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
                            <input type="submit" name="submit" placeholder="" class="btn btn-small btn-primary" value="Guardar">
                            @csrf
                        </div>
                    </div>
                </form>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Email</th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($users as $user)
                        <tr>
                            <td class="col-2">{{$user->id}}</td>
                            <td class="col-3">{{$user->name}}</td>
                            <td class="col-3">{{$user->email}}</td>
                            <td class="col-auto">
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
        </div>
    </div>
</div>
@endsection
