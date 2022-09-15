<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
// Login
Auth::routes();
Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Parhikuni
Route::get('/test', function(){
    return view('test');
});
Route::get('/usuarios', [App\Http\Controllers\UserController::class, 'index'])->name('users.index');
Route::post('/usuarios/guardar', [App\Http\Controllers\UserController::class, 'store'])->name('users.store');
Route::delete('/usuarios/{user}', [App\Http\Controllers\UserController::class, 'destroy'])->name('users.destroy');

Route::get('/test', function(){
    return view('test2');
});