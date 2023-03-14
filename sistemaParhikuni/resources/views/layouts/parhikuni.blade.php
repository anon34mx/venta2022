@routes
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>


    <link rel="icon" type="image/x-icon" href="{{ Vite::asset('resources/images/favicon.ico') }}">
    <meta name="theme-color" content="#ccdede" >
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    
	<title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
    <!-- Our Custom CSS -->
    <!-- <link rel="stylesheet" href="sidebar.css"> -->

	<!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    <!-- Font Awesome JS -->
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js" integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ" crossorigin="anonymous"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js" integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY" crossorigin="anonymous"></script>
	<!-- Scripts -->
    <!-- 'resources/js/jquery-3.6.1.min.js', -->
    @vite([
        'resources/sass/app.scss',
        'resources/js/app.js',
        'resources/css/sidebar.css',
        'resources/css/parhikuni.css',
        'resources/js/controller.js',
        'resources/js/controlador_venta.js',
        'resources/js/jquery.dataTables.min.js',
        'resources/css/jquery.dataTables.min.css',
        'resources/js/RobinHerbots-Inputmask-87c76c7/dist/jquery.inputmask.min.js',
        'resources/js/RobinHerbots-Inputmask-87c76c7/dist/inputmask.js',
    ])
</head>

<body>
    <div id="printed" class="float-right">
        {{date("d-m-Y h:i:s")}}
    </div>
    <div class="wrapper">
        <!-- Sidebar  -->
        <nav id="sidebar" class="active">
            <div class="sidebar-header">
				<img
					src="{{ Vite::asset('resources/images/logo.png') }}" alt="" style="
					width: 40px;
					height: 40px;
					display: block;
					margin: auto;
				">
                <h3>Destinos Parhíkuni</h3>
                <center>Sistema Integral</center>
            </div>

            <ul class="list-unstyled components">
                <!-- <p>Dummy Heading</p> -->
                @if(Auth::user()!="")
                    @if(Auth::user()->hasRole('Admin'))
                        <li class="active">
                            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Admin</a>
                            <ul class="collapse list-unstyled" id="homeSubmenu">
                                <li>
                                    <a href="{{route('users.index')}}">Usuarios</a>
                                </li>
                                <li>
                                    <a href="{{route('roles.index')}}">Roles</a>
                                </li>
                                <li>
                                    <a href="{{route('permissions.index')}}">Permisos</a>
                                </li>
                            </ul>
                        </li>
                    @endif
                @endif
                
                    <li class="active">
                        <a href="#corridasSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Corridas</a>
                        <ul class="collapse list-unstyled" id="corridasSubmenu">
                            @if(Auth::user()->hasRole("Admin"))
                                <li>
                                    <a href="{{route('tramos.index')}}">Tramos</a>
                                    <a href="{{route('itinerarios.index')}}">Itinerarios</a>
                                </li>
                            @endif
                            @can("tarifas.index")
                                <li>
                                    <a href="{{route('tarifas.index')}}">Tarifas</a>
                                </li>
                            @endcan
                            @can([
                                "corridas.programadas.index",
                                ])
                                <li>
                                    <a href="{{route('corridas.programadas.index')}}">Programadas</a>
                                </li>
                            @endcan
                            @can([
                                "corridas.disponibles.index"
                                ])
                                <li>
                                    <a href="{{route('corridas.disponibles.index')}}">Disponibles</a>
                                </li>
                            @endcan
                            <li>
                                <a href="{{route('corridas.disponibles.index')}}">Firmas</a>
                            </li>
                            @can([
                                "corridas.vacaciones"
                                ])
                                <li>
                                    <a href="{{route('corridas.vacaciones.index')}}">Periodo vacacional</a>
                                </li>
                            @endcan
                        </ul>
                    </li>
                
                @can([
                    "personal.conductores.index"
                    ])
                <li class="active">
                    <a href="#PersonalSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Personal</a>
                    <ul class="collapse list-unstyled" id="PersonalSubmenu">
                        <li>
                            <a href="{{route('personal.conductores.index')}}">Conductores</a>
                        </li>
                    </ul>
                </li>
                @endcan
                <li>
                    <a href="{{route('venta.interna.corridas')}}">Venta de boletos</a>
                </li>

                <li>
                    <a href="#">About</a>
                </li>
                
            </ul>

			<!--
            <ul class="list-unstyled CTAs">
                <li>
                    <a href="https://bootstrapious.com/tutorial/files/sidebar.zip" class="download">Download source</a>
                </li>
                <li>
                    <a href="https://bootstrapious.com/p/bootstrap-sidebar" class="article">Back to article</a>
                </li>
            </ul> -->
        </nav>

        <!-- Page Content  -->
        <div id="content">
            <nav class="navbar navbar-expand-lg navbar-light ">
                <div class="container-fluid">
                    <button type="button" id="sidebarCollapse" class="btn btn-info">
                        <i class="fas fa-align-left"></i>
                        <span>Menu</span>
                    </button>
					<a href="{{ url('/') }}">
						<img
							src="{{ Vite::asset('resources/images/logo_SI_bnco.png') }}" alt="" style="
							width: 40px;
							height: 40px;
							display: block;
							margin: 0px 10px;
						">
					</a>
                    <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fas fa-align-justify"></i>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        @if(session()->has("asientosID")==true)
                            <a href="{{ route('venta.interna.corridas') }}">
                                <button class="btn btn-primary btn-sm">
                                    <i class="fa-solid fa-cart-shopping"></i>
                                    continuar venta
                                </button>
                            </a>
                        @endif
                        <ul class="nav navbar-nav ml-auto">
						@guest
							@if (Route::has('login'))
								<li class="nav-item active">
									<a class="nav-link" href="{{ route('login') }}">{{ __('Login') }}</a>
								</li>
							@endif
							@if (Route::has('register'))
								<li class="nav-item active">
									<a class="nav-link" href="{{ route('login') }}">{{ __('Register') }}</a>
								</li>
                            @endif
                        @else
							<li class="nav-item dropdown">
                                <a id="navbarDropdown" class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" v-pre>
                                    {{ Auth::user()->name }} - {{ session("oficinaNombre") }}
                                </a>

                                <div class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="{{route('users.edit', Auth::user()->id)}}">
                                        Mi perfil
                                    </a>
                                    <a class="dropdown-item" href="{{route('sesionesventa.usuario', Auth::user())}}">
                                        Sesiones de venta
                                    </a>

                                    <a class="dropdown-item" href="{{ route('logout') }}"
                                       onclick="event.preventDefault();
                                                     document.getElementById('logout-form').submit();">
                                        {{ __('Logout') }}
                                    </a>

                                    <form id="logout-form" action="{{ route('logout') }}" method="POST" class="d-none">
                                        @csrf
                                    </form>
                                </div>
                            </li>

						@endguest
                        </ul>
                    </div>
                </div>
            </nav>

			<!-- <main class="py-1 py-md-2 py-lg-3 px-1 px-md-4"> -->
			<main class="px-1 px-md-2 px-lg-3">
                @yield('content')

	        </main>
            <footer class="mt-4">
                <div>
                    <img alt="" style=""
                        src="{{ Vite::asset('resources/images/logo_parhikuni.png') }}">
                </div>
            </footer>
            <div class="text-center">
                Destinos Parhíkuni ©2022-<?=date("Y")?>
            </div>
        </div>
        <nav id="sidebar" style="display:none;">
            <div class="sidebar-header">
				<img
					src="{{ Vite::asset('resources/images/logo.png') }}" alt="" style="
					width: 40px;
					height: 40px;
					display: block;
					margin: auto;
				">
                <h3>Destinos Parhíkuni</h3>
            </div>

            <ul class="list-unstyled components">
                <p>Dummy Heading</p>
                @can ('usuarios.index')
                <li class="active">
                    <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Home</a>
                    <ul class="collapse list-unstyled" id="homeSubmenu">
                        <li>
                            <a href="#">Home 1</a>
                        </li>
                        <li>
                            <a href="#">Home 2</a>
                        </li>
                    </ul>
                </li>
                @endcan
                <li>
                    <a href="#">Usuarios</a>
                </li>
                <!-- <li>
                    <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Pages</a>
                    <ul class="collapse list-unstyled" id="pageSubmenu">
                        <li>
                            <a href="#">Page 1</a>
                        </li>
                        <li>
                            <a href="#">Page 2</a>
                        </li>
                        <li>
                            <a href="#">Page 3</a>
                        </li>
                    </ul>
                </li> -->
                <!-- <li>
                    <a href="#">Portfolio</a>
                </li>
                <li>
                    <a href="#">Contact</a>
                </li> -->
            </ul>

        </nav>
    </div>

    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <!-- Popper.JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".use-inputmask").inputmask();

            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
        });
    </script>
</body>

</html>