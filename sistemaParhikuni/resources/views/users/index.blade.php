@extends('layouts.parhikuni')

@section('content')
    <div class="col-12">
        <h3>Nueva persona</h3>
        @if($errors->any())
            <div class="card-body mt-2 mb-2 ">
                <div class="alert-danger px-3 py-3">
                    @foreach($errors->all() as $error)
                    - {{$error}}<br>
                    @endforeach
                </div>
            </div>
        @endif
        <form action="{{route('users.store')}}" method="POST">
            <div class="row">
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="text" name="name" placeholder="Nombre" class="form-control" value="{{old('name')}}">
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="email" name="email" placeholder="Email" class="form-control" value="{{old('email')}}">
                </div>
                <div class="col-12 mt-1 mb-1 col-md-6 col-lg-6">
                    <input type="password" name="password" placeholder="password" class="form-control" value="{{old('password')}}">
                </div>
                <div class="col-auto justify-content-center">
                    <input type="submit" name="submit" placeholder="" class="btn btn-small btn-parhi-primary mx-auto" value="Guardar">
                    @csrf
                </div>
            </div>
        </form>
    </div>
    <div id="personas" class="mt-4"></div>
    <h3 class="" ><a href="#personas">Personas</a></h3>
    <div>
        <form method="post" action="/usuarios">
            @csrf
            <div class="col-12 row">
                <div class="col-6">
                    <input type="search" placeholder="Search here" name="search"
                    class="form-control" id="search"
                    value="{{$search}}" style="padding-right: 30px;"/>
                    <div onclick="event.preventDefault();$('#search').val('')"
                        class="btn btn-link"
                        style="
                        color: black;
                        position: absolute;
                        right: 12px;
                        top: 0px;
                    ">
                    <i class="fa-solid fa-delete-left"></i>
                </div>
                </div>
                <div class="col-6">
                    <button class="btn btn-small btn-parhi-primary mx-auto"
                        type="submit">Buscar</button>
                </div>
            </div>
        </form>
    </div>
    <div style="overflow-x:auto;overflow-y: hidden;">
        <table class="mt-2 table table-striped table-parhi">
            <thead>
                <tr class="table-parhi">
                    <th class="col-2">ID</th>
                    <th class="col-3">Nombre</th>
                    <th class="col-3">Email</th>
                    <th class="col-auto" colspan="2"></th>
                </tr>
            </thead>
            <tbody>
                @foreach($users as $user)
                    <tr>
                        <td>{{$user->id}}</td>
                        <td>{{$user->name}}</td>
                        <td>{{$user->email}}</td>
                        <td><button class="btn btn-primary">editar</button></td>
                        <td>
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
    <div class="mt-3">
        {!! $users->appends(Request::all())->links() !!}
        <!-- !! $users->appends(['search' => $request->get('search')]); !! -->
        <!-- <br> -->
        <!-- {!! $users->links() !!} -->
    </div>
    <div class="card mt-3 mb-3">
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsa, deserunt. Suscipit eum quam esse minima, quaerat recusandae. Consequuntur recusandae consectetur eum ullam doloremque voluptate, quas, deserunt autem earum a voluptas! 
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsa, deserunt. Suscipit eum quam esse minima, quaerat recusandae. Consequuntur recusandae consectetur eum ullam doloremque voluptate, quas, deserunt autem earum a voluptas!
        <br>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsa, deserunt. Suscipit eum quam esse minima, quaerat recusandae. Consequuntur recusandae consectetur eum ullam doloremque voluptate, quas, deserunt autem earum a voluptas!
    </div>
    <div class="card mt-3 mb-3">
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsa, deserunt. Suscipit eum quam esse minima, quaerat recusandae. Consequuntur recusandae consectetur eum ullam doloremque voluptate, quas, deserunt autem earum a voluptas! 
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsa, deserunt. Suscipit eum quam esse minima, quaerat recusandae. Consequuntur recusandae consectetur eum ullam doloremque voluptate, quas, deserunt autem earum a voluptas!
        <br>
        Lorem ipsum dolor sit amet consectetur adipisicing elit. Ipsa, deserunt. Suscipit eum quam esse minima, quaerat recusandae. Consequuntur recusandae consectetur eum ullam doloremque voluptate, quas, deserunt autem earum a voluptas!
    </div>
@endsection
