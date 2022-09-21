@extends('layouts.auth_base')

@section('content')
<div class="container login">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="card login">
                <!-- <div class="card-header">{{ __('Login') }}</div> -->
                <img alt="" style="" width="90"
                    class="logo-color mx-auto my-3" src="{{ Vite::asset('resources/images/logo_SI_color.png') }}">
                <img alt="" style="" width="90"
                    class="logo-bnco mx-auto my-3" src="{{ Vite::asset('resources/images/logo_SI_bnco.png') }}">
                <center><b>Sistema Integral</b></center>
                <div class="card-body">
                    <form method="POST" action="{{ route('login') }}">
                        @csrf

                        <div class="row mb-3">
                            <!-- <label for="email" class="col-md-4 col-form-label text-md-end">{{ __('Email Address') }}</label> -->

                            <div class="col-11 col-sm-8 col-lg-7 mx-auto">
                                <input id="email" type="email" class="form-control @error('email') is-invalid @enderror"
                                    name="email" value="{{ old('email') }}" required autocomplete="email" autofocus
                                    placeholder="{{ __('Email Address') }}">

                                @error('email')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mb-3">
                            <!-- <label for="password" class="col-md-4 col-form-label text-md-end">{{ __('Password') }}</label> -->

                            <div class="col-11 col-sm-8 col-lg-7 mx-auto">
                                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror"
                                name="password" required autocomplete="current-password"
                                placeholder="{{ __('Password') }}">

                                @error('password')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-auto mx-auto">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>

                                    <label class="form-check-label" for="remember">
                                        {{ __('Remember Me') }}
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-0">
                            <div class="col-auto mx-auto">
                                <button type="submit" class="btn btn-parhi-primary mx-auto">
                                    {{ __('Login') }}
                                </button>
                            </div>
                        </div>
                        <div class="row mb-0 justify-content-end">
                            <div class="col-auto">
                                @if (Route::has('password.request'))
                                    <a class="btn btn-link" href="{{ route('password.request') }}">
                                        {{ __('Forgot Your Password?') }}
                                    </a>
                                @endif

                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
