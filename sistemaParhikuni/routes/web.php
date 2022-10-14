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
Route::post('/usuarios/updateAsUser', [App\Http\Controllers\UserController::class, 'updateAsUser'])->name('users.updateAsUser')
    ->middleware('permission:users.update');
Route::post('/usuarios/updateAsEI', [App\Http\Controllers\UserController::class, 'updateAsEI'])->name('users.updateAsEI')
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

// ROLES
Route::get('/roles', [App\Http\Controllers\RolesController::class, 'index'])
    ->name("roles.index")->middleware('role:Admin');
Route::get('/roles/{idRole}', [App\Http\Controllers\RolesController::class, 'edit'])
    ->name("roles.edit")->middleware('role:Admin');
Route::post('/roles/addNew', [App\Http\Controllers\RolesController::class, 'store'])
    ->name("roles.store")->middleware('role:Admin');
Route::post('/roles/{role}/quitarPermiso/{permission}', [App\Http\Controllers\RolesController::class, 'revokePermission'])
    ->name("roles.revokePermission")->middleware('role:Admin');
Route::post('/roles/{role}/anadirPermisos', [App\Http\Controllers\RolesController::class, 'addPermissions'])
    ->name("roles.addPermissions")->middleware('role:Admin');
Route::delete('/roles/{role}', [App\Http\Controllers\RolesController::class, 'destroy'])
    ->name("roles.destroy")->middleware('role:Admin');
    
    // PERMISOS
Route::get('/permisos', [App\Http\Controllers\PermissionController::class, 'index'])
    ->name("permissions.index")->middleware('role:Admin');
Route::post('/permisos/add', [App\Http\Controllers\PermissionController::class, 'store'])
    ->name("permission.store")->middleware('role:Admin');
Route::delete('/permisos/{permission}', [App\Http\Controllers\PermissionController::class, 'destroy'])
    ->name("permission.destroy")->middleware('role:Admin');

// CORRIDAS PROGRAMADAS
Route::get('/corridas/programadas', [App\Http\Controllers\corridasProgramadasController::class, 'index'])
    ->name("corridas.programadas.index")
    ->middleware('permission:corridasProgramadas.index');
Route::get('/corridas/programadas/{corridaProgramada}', [App\Http\Controllers\corridasProgramadasController::class, 'edit'])
    ->name("corridas.programadas.edit")
    ->middleware('permission:corridasProgramadas.index');
Route::delete('/corridas/programadas/{corridaProgramada}/delete', [App\Http\Controllers\corridasProgramadasController::class, 'destroy'])
    ->name("corridas.programadas.destroy")
    ->middleware('permission:corridasProgramadas.index');
Route::post('/corridas/programadas/store', [App\Http\Controllers\corridasProgramadasController::class, 'store'])
    ->name("corridas.programadas.store")
    ->middleware('permission:corridasProgramadas.index');

// CORRIDAS DISPONIBLES
Route::get('/corridas/disponibles', [App\Http\Controllers\CorridasDisponiblesController::class, 'index'])
    ->name("corridas.disponibles.index")
    ->middleware('permission:corridasDisponibles.index');
Route::get('/corridas/disponibles/{corridaDisponible}', [App\Http\Controllers\CorridasDisponiblesController::class, 'edit'])
    ->name("corridas.disponibles.edit")
    ->middleware('permission:corridasDisponibles.index');

//  VENTA
Route::get('/venta/01', [App\Http\Controllers\CorridasDisponiblesController::class, 'venta'])
    ->name("corridas.disponibles.venta")
    ->middleware('permission:corridasDisponibles.index');

Route::get('/test', function(){
    return view('test2');
})->middleware('permission:test');


Route::get('/logout', function(Request $request){
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();
    return redirect('/');
})->name("logout");