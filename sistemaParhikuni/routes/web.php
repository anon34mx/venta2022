<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\RolesController;

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
// Route::get("/"); // poner enlace para logout por get
Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Parhikuni
Route::get('/test', function(){
    return view('test');
});

// USUARIOS
Route::get('/usuarios', [App\Http\Controllers\UserController::class, 'index'])->name('users.index')
    ->middleware('permission:users.index');
Route::post('/usuarios/guardar', [App\Http\Controllers\UserController::class, 'store'])->name('users.store')
    ->middleware('permission:users.store');
Route::get('/usuarios/{user}', [App\Http\Controllers\UserController::class, 'edit'])->name('users.edit')
    ->middleware('permission:users.edit');
Route::post('/usuarios/update/{user}', [App\Http\Controllers\UserController::class, 'update'])->name('users.update')
    ->middleware('permission:users.update');
Route::delete('/usuarios/{user}', [App\Http\Controllers\UserController::class, 'destroy'])->name('users.destroy')
    ->middleware('permission:users.destroy');
Route::post('/usuarios/{id}/store/addrol', [App\Http\Controllers\UserController::class, 'addrol'])
    ->name("users.addrol")
    ->middleware('permission:users.addrol');
Route::post('/usuarios/{id}/store/removerol/{rol}', [App\Http\Controllers\UserController::class, 'removerol'])
    ->name("users.removerol")
    ->middleware('permission:users.removerol');
Route::post('/usuarios/{id}/store/addPermission', [App\Http\Controllers\UserController::class, 'addPermissions'])
    ->name("users.addPermission")
    ->middleware('permission:users.editPermissions');
Route::post('/usuarios/{id}/store/revokePermission', [App\Http\Controllers\UserController::class, 'revokePermission'])
    ->name("users.revokePermission")
    ->middleware('permission:users.editPermissions');

// CORRIDAS PROGRAMADAS
Route::get('/corridas/programadas', [App\Http\Controllers\corridasProgramadas::class, 'index'])
    ->name("corridas.programadas.index");
    // ->middleware('permission:users.editPermissions');

Route::get('/test', function(){
    return view('test2');
});