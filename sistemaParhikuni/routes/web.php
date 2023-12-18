<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\RolesController;
use Carbon\Carbon;

use Faker\Generator;


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
    return view('base');
})->middleware(['auth','validBrowser']);
// Login
Auth::routes();
// Route::get("/"); // poner enlace para logout por get
Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');

// Parhikuni
Route::get('/test', function(){

});
Route::get('/testsms', [App\Http\Controllers\SmsController::class, 'corridaBajaOcupacion',]);

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
    ->name('users.addrol')
    ->middleware('permission:users.addrol');
Route::post('/usuarios/{id}/store/removerol/{rol}', [App\Http\Controllers\UserController::class, 'removerol'])
    ->name('users.removerol')
    ->middleware('permission:users.removerol');
Route::post('/usuarios/{id}/store/addPermission', [App\Http\Controllers\UserController::class, 'addPermissions'])
    ->name('users.addPermission')
    ->middleware('permission:users.editPermissions');
Route::post('/usuarios/{id}/store/revokePermission', [App\Http\Controllers\UserController::class, 'revokePermission'])
    ->name('users.revokePermission')
    ->middleware('permission:users.editPermissions');

// ROLES
Route::get('/roles', [App\Http\Controllers\RolesController::class, 'index'])
    ->name('roles.index')->middleware('role:Admin');
Route::get('/roles/{idRole}', [App\Http\Controllers\RolesController::class, 'edit'])
    ->name('roles.edit')->middleware('role:Admin');
Route::post('/roles/addNew', [App\Http\Controllers\RolesController::class, 'store'])
    ->name('roles.store')->middleware('role:Admin');
Route::post('/roles/{role}/quitarPermiso/{permission}', [App\Http\Controllers\RolesController::class, 'revokePermission'])
    ->name('roles.revokePermission')->middleware('role:Admin');
Route::post('/roles/{role}/anadirPermisos', [App\Http\Controllers\RolesController::class, 'addPermissions'])
    ->name('roles.addPermissions')->middleware('role:Admin');
Route::delete('/roles/{role}', [App\Http\Controllers\RolesController::class, 'destroy'])
    ->name('roles.destroy')->middleware('role:Admin');
    
    // PERMISOS
Route::get('/permisos', [App\Http\Controllers\PermissionController::class, 'index'])
    ->name('permissions.index')->middleware('role:Admin');
Route::post('/permisos/add', [App\Http\Controllers\PermissionController::class, 'store'])
    ->name('permission.store')->middleware('role:Admin');
Route::delete('/permisos/{permission}', [App\Http\Controllers\PermissionController::class, 'destroy'])
    ->name('permission.destroy')->middleware('role:Admin');
    
// Tarifas
Route::get('/tarifas', [App\Http\Controllers\TarifasController::class, 'index'])
    ->name('tarifas.index')->middleware('permission:tarifas.index');
    
Route::get('/tarifas/nueva/', [App\Http\Controllers\TarifasController::class, 'create'])
    ->name('tarifas.create')->middleware('permission:tarifas.create');
Route::get('/tarifas/{idTarifa}', [App\Http\Controllers\TarifasController::class, 'show'])
    ->name('tarifas.show')->middleware('permission:tarifas.show');

Route::post('/tarifas/store}', [App\Http\Controllers\TarifasController::class, 'store'])
    ->name('tarifas.store')->middleware('permission:tarifas.store');
Route::get('/tarifas/{idTarifa}/edit', [App\Http\Controllers\TarifasController::class, 'edit'])
    ->name('tarifas.edit')->middleware('permission:tarifas.edit');
Route::post('/tarifas/{idTarifa}/update', [App\Http\Controllers\TarifasController::class, 'update'])
    ->name('tarifas.update')->middleware('permission:tarifas.update');

    // tramos
Route::get('/tramos/', [App\Http\Controllers\TramosController::class, 'index'])
    ->name('tramos.index')->middleware('role:Admin');
Route::get('/tramos/nuevo', [App\Http\Controllers\TramosController::class, 'create'])
    ->name('tramos.create')->middleware('role:Admin');
Route::post('/tramos/guardar', [App\Http\Controllers\TramosController::class, 'store'])
    ->name('tramos.store')->middleware('role:Admin');
Route::get('/tramos/{id}/edit', [App\Http\Controllers\TramosController::class, 'edit'])
    ->name('tramos.edit')->middleware('role:Admin');
Route::get('/tramos/{id}', [App\Http\Controllers\TramosController::class, 'update'])
    ->name('tramos.update')->middleware('role:Admin');

    // Itinerarios
Route::get('/itinerarios/', [App\Http\Controllers\ItinerariosController::class, 'index'])
    ->name('itinerarios.index')->middleware('role:Admin');
Route::get('/itinerarios/{id}/edit', [App\Http\Controllers\ItinerariosController::class, 'edit'])
    ->name('itinerarios.edit')->middleware('role:Admin');
Route::post('/itinerarios/{id}/update', [App\Http\Controllers\ItinerariosController::class, 'update'])
    ->name('itinerarios.update')->middleware('role:Admin');
Route::get('/itinerarios/nuevo', [App\Http\Controllers\ItinerariosController::class, 'create'])
    ->name('itinerarios.create')->middleware('role:Admin');
Route::post('/itinerarios/guardar', [App\Http\Controllers\ItinerariosController::class, 'store'])
    ->name('itinerarios.store')->middleware('role:Admin');

// CORRIDAS PROGRAMADAS
Route::get('/corridas/programadas', [App\Http\Controllers\corridasProgramadasController::class, 'index'])
    ->name('corridas.programadas.index')
    ->middleware('permission:corridas.programadas.index');
Route::get('/corridas/programadas/{corridaProgramada}/detalle', [App\Http\Controllers\corridasProgramadasController::class, 'show'])
    ->name('corridas.programadas.show')
    ->middleware('permission:corridas.programadas.show');
Route::delete('/corridas/programadas/{corridaProgramada}/delete', [App\Http\Controllers\corridasProgramadasController::class, 'destroy'])
    ->name('corridas.programadas.destroy')
    ->middleware('permission:corridas.programadas.destroy');
Route::post('/corridas/programadas/store', [App\Http\Controllers\corridasProgramadasController::class, 'store'])
    ->name('corridas.programadas.store')
    ->middleware('permission:corridas.programadas.store');
Route::get('/corridas/programadas/{corridaProgramada}/transfer', [App\Http\Controllers\corridasProgramadasController::class, 'edit'])
    ->name('corridas.programadas.transfer')
    ->middleware('permission:corridas.programadas.transfer');
Route::post('/corridas/programadas/{corridaProgramada}/transfer/store', [App\Http\Controllers\corridasProgramadasController::class, 'update'])
    ->name('corridas.programadas.storeTransfer')
    ->middleware('permission:corridas.programadas.storeTransfer');

// CORRIDAS DISPONIBLES
Route::get('/corridas/disponibles', [App\Http\Controllers\CorridasDisponiblesController::class, 'index'])
    ->name('corridas.disponibles.index')
    ->middleware('permission:corridas.disponibles.index');
Route::get('/corridas/disponibles/{corridaDisponible}', [App\Http\Controllers\CorridasDisponiblesController::class, 'edit'])
    ->name('corridas.disponibles.edit')
    ->middleware('permission:corridas.disponibles.edit');
Route::post('/corridas/disponibles/{corridaDisponible}', [App\Http\Controllers\CorridasDisponiblesController::class, 'update'])
    ->name('corridas.disponibles.update')
    ->middleware('permission:corridas.disponibles.update');
// Registro paso puntos
Route::post('/corridas/disponibles/{corridaDisponible}/despachar', [App\Http\Controllers\CorridasDisponiblesController::class, 'despachar'])
    ->name('corridas.disponibles.despachar')
    ->middleware('permission:corridas.disponibles.despachar');
Route::get('/corridas/disponibles/{corridaDisponible}/guia', [App\Http\Controllers\CorridasDisponiblesController::class, 'guiaPasajeros'])
    ->name('corridas.disponibles.guiaPasajeros')
    ->middleware('permission:corridas.disponibles.guiaPasajeros');
// Route::post('/corridas/disponibles/{corridaDisponible}/registro', [App\Http\Controllers\CorridasDisponiblesController::class, 'checkpoint'])
//     ->name('corridas.disponibles.checkpoint')
//     ->middleware('permission:corridas.disponibles.checkpoint');
Route::get('/corridas/disponibles/{corridaDisponible}/puntosDeControl', [App\Http\Controllers\CorridasDisponiblesController::class, 'puntosDeControl'])
    ->name('corridas.disponibles.puntosDeControl')
    ->middleware('permission:corridas.disponibles.puntosDeControl');
Route::post('/corridas/disponibles/{corridaDisponible}/puntosDeControl/registrar', [App\Http\Controllers\CorridasDisponiblesController::class, 'registrarPuntoDeControl'])
    ->name('corridas.disponibles.registrarPuntoDeControl');
// informacion sobre la corrida
Route::get('/corridas/disponibles/{corridaDisponible}/itinerario', [App\Http\Controllers\CorridasDisponiblesController::class, 'itinerario'])
    ->name('corridas.disponibles.itinerario');
Route::get('/corridas/disponibles/{corridaDisponible}/recorrido/{origen}/{destino}', [App\Http\Controllers\CorridasDisponiblesController::class, 'recorrido'])
    ->name('corridas.disponibles.recorrido');
    // ->middleware('permission:corridas.disponibles.registrarPuntoDeControl');

    //  PERIODO VACACIONAL
Route::get('/corridas/periodosVacacionales', [App\Http\Controllers\PerodiodosVacacionalesController::class, 'index'])
    ->name('corridas.vacaciones.index')->middleware('permission:corridas.vacaciones');
Route::get('/corridas/periodosVacacionales/store', [App\Http\Controllers\PerodiodosVacacionalesController::class, 'store'])
    ->name('corridas.vacaciones.store')->middleware('permission:corridas.vacaciones');
Route::post('/corridas/periodosVacacionales/{id}/destroy', [App\Http\Controllers\PerodiodosVacacionalesController::class, 'destroy'])
    ->name('corridas.vacaciones.destroy')->middleware('permission:corridas.vacaciones');

    //  PROMOCIONES
Route::get('/promociones', [App\Http\Controllers\PromocionesController::class, 'index'])
    ->name('corridas.promociones.index');//->middleware('permission:corridas.vacaciones');
Route::get('/promociones/create', [App\Http\Controllers\PromocionesController::class, 'create'])
    ->name('promociones.create');//->middleware('permission:corridas.vacaciones');
Route::post('/promociones/store', [App\Http\Controllers\PromocionesController::class, 'store'])
    ->name('promociones.store');//->middleware('permission:corridas.vacaciones');
Route::get('/promociones/{promocion}', [App\Http\Controllers\PromocionesController::class, 'edit'])
    ->name('promociones.edit');//->middleware('permission:corridas.vacaciones');
Route::post('/promociones/{promocion}/update', [App\Http\Controllers\PromocionesController::class, 'update'])
    ->name('promociones.update');//->middleware('permission:corridas.vacaciones');

// BOLETOS VENDIDOS
Route::get('/boletos/transferir/{corridaDisponible}', [App\Http\Controllers\BoletosVendidosController::class, 'showLimbo'])
    ->name('boletos.limbo.show')
    ->middleware('permission:boletos.limbo.show');
Route::post('/boletos/tranferir/{corridaDisponible}/porCorrida', [App\Http\Controllers\BoletosVendidosController::class, 'porCorrida'])
    ->name('boletos.limbo.reasignar')
    ->middleware('permission:boletos.limbo.reasignar');
Route::post('/boletos/transferir/{corridaOriginal}/reasignarAutomatico', [App\Http\Controllers\BoletosVendidosController::class, 'reasignarAutomatico'])
    ->name('boletos.reasignarAutomatico');
    // ->middleware('permission:boletos.limbo.reasignar');
Route::post('/boletos/transferir/{corridaOriginal}/reasignarManual', [App\Http\Controllers\BoletosVendidosController::class, 'reasignarManual'])
    ->name('boletos.reasignarManual');  //GUARDAR
    // ->middleware('permission:boletos.limbo.reasignar');


Route::get('/filtros', [App\Http\Controllers\CorridasDisponiblesController::class, 'filtros'])
    ->name('corridas.disponibles.filtros');//->middleware('permission:corridas.disponibles.index');//pendiente
Route::post('/CorridasDisponibles/filtradas', [App\Http\Controllers\CorridasDisponiblesController::class, 'filtradas'])
    ->name('corridas.disponibles.filtradas');//->middleware('permission:corridas.disponibles.index');//pendiente
    
//  VENTA INTERNA
    //  PASO 0
Route::get('/ventaInterna/', [App\Http\Controllers\VentaInternaController::class, 'corridasFiltradas'])
    ->name('venta.interna.corridas')->middleware(['ventaInterna']);
    //  PASO 0.1
Route::get('/ventaInterna/corridas', [App\Http\Controllers\VentaInternaController::class, 'corridasFiltradas'])
    ->name('venta.interna.corridas')->middleware(['ventaInterna']);
    //  PASO 0.1
Route::post('/ventaInterna/corridas/guardarFiltros', [App\Http\Controllers\VentaInternaController::class, 'guardarFiltros'])
    ->name('venta.interna.guardarFiltros');
    //  PASO 1
Route::get('/ventaInterna/asientos/ida', [App\Http\Controllers\VentaInternaController::class, 'asientosIda'])
    ->name('venta.interna.asientos')->middleware(['ventaInterna']);
    //  PASO 2
Route::post('/ventaInterna/apartarIda', [App\Http\Controllers\VentaInternaController::class, 'apartarIda'])
    ->name('venta.interna.apartar');
Route::get('/ventaInterna/corridas/regreso', [App\Http\Controllers\VentaInternaController::class, 'corridasRegreso'])
    ->name('venta.interna.corridasRegreso')->middleware(['ventaInterna']);
Route::post('/ventaInterna/corridas/regreso/guardar', [App\Http\Controllers\VentaInternaController::class, 'corridasRegresoGuardar'])
    ->name('venta.interna.corridasRegresoGuardar'); //->middleware(['ventaInterna']);
Route::get('/ventaInterna/asientos/regreso', [App\Http\Controllers\VentaInternaController::class, 'asientosRegreso'])
    ->name('venta.interna.asientosRegreso'); //->middleware(['ventaInterna']);
Route::post('/ventaInterna/asientos/regreso/apartar', [App\Http\Controllers\VentaInternaController::class, 'apartarReg'])
    ->name('venta.interna.asientosRegreso.apartar'); //->middleware(['ventaInterna']);
    //  PASO 4
Route::get('/ventaInterna/confirmacion', [App\Http\Controllers\VentaInternaController::class, 'confirmacion'])
    ->name('venta.interna.confirmacion')->middleware(['ventaInterna']);
    //  PASO 4.1
Route::post('/ventaInterna/confirmacion/guardar', [App\Http\Controllers\VentaInternaController::class, 'confirmacionGuardar'])
    ->name('venta.interna.confirmacionGuardar');
    //  PASO 4
Route::get('/ventaInterna/pago', [App\Http\Controllers\VentaInternaController::class, 'pago'])
    ->name('venta.interna.pago')->middleware(['ventaInterna']);
    //  PASO 4.1
Route::post('/ventaInterna/abonar', [App\Http\Controllers\VentaInternaController::class, 'abonar'])
    ->name('venta.interna.abonar');
    //  PASO 5 [FIN]
Route::get('/ventaInterna/{venta}/boletos/{formato}', [App\Http\Controllers\VentaInternaController::class, 'boletos'])
    ->name('venta.interna.boletos');
Route::get('/ventaInterna/{venta}/boletos/preview/{formato}', [App\Http\Controllers\VentaInternaController::class, 'boletosPreview'])
    ->name('venta.interna.boletosPreview');

    //  CANCELAR
Route::post('/ventaInterna/cancelarCompra', [App\Http\Controllers\VentaInternaController::class, 'cancelarCompra'])
    ->name('venta.interna.cancelarCompra');
Route::get('/ventaInterna/cancelarCompra', [App\Http\Controllers\VentaInternaController::class, 'cancelarCompra'])
    ->name('venta.interna.cancelarCompra');

// SESIONES DE VENTA
Route::get('/sesionesVenta', [App\Http\Controllers\sesionesVentaController::class, 'index'])
    ->name('sesionesventa.index'); //admin
Route::get('/sesionesVenta/usuario/{user}', [App\Http\Controllers\sesionesVentaController::class, 'porUsuario'])
    ->name('sesionesventa.usuario');
Route::get('/sesionesVenta/store', [App\Http\Controllers\sesionesVentaController::class, 'store'])
    ->name('sesionesventa.store');
    //cierre de sesion
Route::get('/sesionesVenta/{sesion}/edit', [App\Http\Controllers\sesionesVentaController::class, 'edit'])
    ->name('sesionesventa.edit');
Route::post('/sesionesVenta/{sesion}/update', [App\Http\Controllers\sesionesVentaController::class, 'update'])
    ->name('sesionesventa.update');

Route::post('/sesionesVenta/abrir', [App\Http\Controllers\sesionesVentaController::class, 'store'])
    ->name('sesionesventa.abrir');
    
Route::get('/ventaInterna/tiempoRestanteCompra', function(){
    return session()->has('cmpra_tiempoCompra') ? session('cmpra_tiempoCompra')-time() : 0;
})->name('tiempoRestanteCompra');
Route::get('/deleteCookies', function(){
    setcookie('tiempoCompra', null, -1);
    session()->forget('corrida');
    session()->forget('disponibilidad');
    session()->forget('pasajeros');
    session()->forget('asientosID');
    session()->forget('cmpra_tiempoCompra');
    session()->forget('origen');
    session()->forget('destino');
    session()->forget('IDventa');
    session()->forget('pasoVenta');
});
Route::get('/oficina/{origen}/destinos/{comp}', [App\Http\Controllers\OficinasController::class, 'destinos'])
    ->name('corridas.disponibles.destinos');

//  Personal
//      CONDUCTORES
Route::get('/personal/conductores', [App\Http\Controllers\ConductoresController::class, 'index'])
    ->name('personal.conductores.index');
Route::get('/personal/conductores/{conductor}/edit', [App\Http\Controllers\ConductoresController::class, 'edit'])
    ->name('personal.conductores.edit');
Route::post('/personal/conductores/{conductor}/update', [App\Http\Controllers\ConductoresController::class, 'update'])
    ->name('personal.conductores.update');
    // ->middleware('permission:corridasDisponibles.index');

// PAQUETERIA
Route::get('/paqueteria/', [App\Http\Controllers\PaqueteriaController::class, 'index'])
    ->name('paqueteria.index');
Route::get('/paqueteria/registrar', [App\Http\Controllers\PaqueteriaController::class, 'create'])
    ->name('paqueteria.create');






// ---  OTROS  ---
Route::get('/logout', function(Request $request){
    try {
        //code...
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/');
    } catch (\Throwable $th) {
        //throw $th;
        return redirect('/');
    }
})->name('logout');
    
// API
Route::get('/estados', [App\Http\Controllers\geoController::class, 'estados']);
Route::get('/estado/{estado_id}', [App\Http\Controllers\geoController::class, 'estado']);
Route::get('/estado/{estado_id}/municipios', [App\Http\Controllers\geoController::class, 'estadoMunicipios']);

Route::group(['prefix' => 'v1'], function(){
    Route::post('GEO/MunicipiosEstado', [App\Http\Controllers\GeoController::class, 'getMunicipiosEstado'])
        ->name('geo.MunicipiosEstado')
        ->middleware(['auth']);

    // Route::post('GEO/Asentamientos', [App\Http\Controllers\GeoController::class, 'getAsentamientos'])
    //     ->name('geo.Asentamientos')
    //     ->middleware(['auth']);
    
    Route::post('paqueteria/buscarRemitente', [App\Http\Controllers\PaqueteriaController::class, 'buscarRemitente'])
        ->name('paqueteria.buscarRemitente')
        ->middleware(['auth']);
    Route::get('paqueteria/listaProductosSAT/{buscar}', [App\Http\Controllers\PaqueteriaController::class, 'listaProductosSAT'])
        ->name('paqueteria.listaProductosSAT')
        ->middleware(['auth']);

    Route::post('GEO/asentamientos', [App\Http\Controllers\PaqueteriaController::class, 'asentamientos'])
        ->name('paqueteria.asentamientos')
        ->middleware(['auth']);



    Route::post('paqueteria/asentamientos', [App\Http\Controllers\PaqueteriaController::class, 'asentamientos'])
        ->name('paqueteria.asentamientos')
        ->middleware(['auth']);

    Route::get('paqueteria/corridas/{nOrigen}/{nDestino}', [App\Http\Controllers\PaqueteriaController::class, 'getCorridas'])
        ->name('paqueteria.corridas.filtrar')
        ->middleware(['auth']);

    Route::get('/corrida/{corrida}/proximas/{nOrigen}/{nDestino}', [App\Http\Controllers\CorridasDisponiblesController::class, 'getProxCorridas'])
        ->name('corrida.getProxCorridas')
        ->middleware(['auth','validBrowser']);

    Route::get('/corrida/{corrida}/diagramaConOcupacion', [App\Http\Controllers\DistribucionAsientosController::class, 'getDiagramaOcupacion'])
        ->name('corrida.diagramaOcupacion')
        ->middleware(['auth','validBrowser']);
});


// DEBUG
Route::get('/browser', function(){
    echo '<h5><center>Debug</center></h5><br>';
    echo '<pre>';

    var_dump($_SERVER);
    /**
     * REMOTE_ADDR
     * 
     */

    // no sé si sirva :v 
    // print_r(get_browser(null, true));
        
    echo '</pre>';
})->name('debug.browser');

Route::get('/cookies', function(){
    // dd(App\Http\Controllers\Disponibilidad::find(session('ida_disponibilidad')));
    dd(session()->all(), Auth()->user()); //, Auth::user()->personas
});
// Route::get('/phpinfo', function() {
//     return phpinfo();
// });
Route::get('/oneTab', function(Request $request) {
    return view('oneTab',[
        'reason' => @$_GET['reason']
    ]);
})->name('oneTab');
Route::get('/base', function(Request $request) {
    return view('base');
})->name('base');

Route::get('/t2', function(){
    $tramos = DB::select(
        DB::raw("SELECT tr.nNumero tramo, tr.nOrigen, tr.nDestino,
        ts.nNumero tser
        FROM tramos tr
        JOIN tiposervicio ts")
    );

    foreach ($tramos as $tramo) {
        var_dump($tramo);
        echo "<br><br>";

        $tarifa=rand(300,550);
        $nva=App\Models\TarifasTramo::create([
            'nTipoServicio' => $tramo->tser.'',
            'nOrigen' => $tramo->nOrigen,
            'nDestino' => $tramo->nDestino,
            'nMontoBaseRuta' => $tarifa,
            'nMontoBasePaqueteria' => $tarifa+30,
            'fAplicacion' => date('Y-m-d h:i'),
        ]);
    }
});
Route::get('/test', function(){
    // dd(App\Models\Oficinas::whereRaw('aClave="MORE"')->first()->nNumero);
    // $tramoscls = new \App\Models\Tramos;
    // $tramos = App\Models\Tramos::all();
    /*
        $tramos = DB::select(
            DB::raw("SELECT tr.nNumero tramo, tr.nOrigen, tr.nDestino, ts.nNumero tser
            FROM tramos tr
            JOIN tiposervicio ts")
        );

        foreach ($tramos as $tramo) {
            $tarifa=rand(300,550);
            $nva=App\Models\TarifasTramo::create([
                'nTipoServicio' => $tramo->tser.'',
                'nOrigen' => $tramo->nOrigen,
                'nDestino' => $tramo->nDestino,
                'nMontoBaseRuta' => $tarifa,
                'nMontoBasePaqueteria' => $tarifa+30,
                'fAplicacion' => date('Y-m-d h:i'),
            ]);
        }
    */

    // /////////////////////////////////////////////////////////////////////////////////
    /*
        $corridas=DB::select(
            DB::raw('SELECT
                cordis.nNumero, cordis.nProgramada, cordis.nItinerario, cordis.nTipoServicio, cordis.fSalida, cordis.hSalida, cordis.nNumeroAutobus,
                cordis.nItinerario, iti.nConsecutivo, min(iti.nConsecutivo), max(iti.nConsecutivo),
                disp.nOrigen, disp.nDestino
                FROM corridasDisponibles cordis
                INNER JOIN disponibilidad as disp
                    on disp.nCorridaDisponible=cordis.nNumero
                INNER JOIN itinerario as iti	
                    ON iti.nItinerario=cordis.nItinerario
                INNER JOIN tramos tr 
                    ON tr.nNumero=iti.nTramo
                where cordis.deleted_at is null
                GROUP BY cordis.nNumero
                ORDER BY cordis.fSalida asc, cordis.hSalida ASC
                LIMIT 99')
        );
    */

    $faker = Faker\Factory::create();
    $TiposPasajeros=[
        0 => "AD",
        1 => "ES",
        2 => "IN",
        3 => "MA",
        4 => "NI",
    ];
    $asientosOcupados=[];
    $asientosDisp=array();
    $insertados=array();

    $corridas=DB::select(
        DB::raw('SELECT
            disp.*, "___" as "___",
            COUNT(disa.id) as asientosOcupados,
            dist.nAsientos as asientosTotal,
            dist.nAsientos - COUNT(disa.id) as asientosDisponibles

            FROM disponibilidad disp
            LEFT JOIN disponibilidadasientos disa
                on disa.nDisponibilidad = disp.nNumero
                and (disa.aEstadoAsiento="V" or disa.aEstadoAsiento="A")
            INNER JOIN corridasdisponibles cordis
                ON cordis.nNumero=disp.nCorridaDisponible
            INNER JOIN autobuses aut
                ON aut.nNumeroAutobus=cordis.nNumeroAutobus
            INNER JOIN tiposervicio tser
            	ON tser.nNumero=cordis.nTipoServicio
            INNER JOIN distribucionasientos dist
                ON dist.nNumero=aut.nDistribucionAsientos
            WHERE cordis.fSalida>= "2053-05-29" -- CURRENT_DATE
            AND cordis.fSalida<= "2053-05-29" -- CURRENT_DATE
            
            GROUP by disp.nCorridaDisponible, disp.nNumero
            HAVING asientosDisponibles > 7
            ORDER BY cordis.fSalida, cordis.hSalida
            ')
        );
    // dd($corridas);
    // SESION DE VENTA
    #
    $sesionVenta = App\Models\Sesiones::create([
        'user_id' => 1,
        'nOficina' => 12,
        'fContable' => date("Y-m-d"),
        'fCerrada' => date("Y-m-d"),
        'nMontoRecibido' => 0,
    ]);
        
    foreach ($corridas as $corrida) {
        // dd($corrida);
        $asientosOcupados=DB::select(
            DB::raw('SELECT
            disa.nAsiento
            FROM `disponibilidadasientos` disa
            INNER JOIN disponibilidad disp
                ON disp.nNumero=disa.nDisponibilidad
            WHERE disp.nCorridaDisponible=:nCorrida
            AND disp.nOrigen=:nOrigen and disp.nDestino=:nDestino
            GROUP BY disa.nAsiento
            ORDER BY disa.nAsiento'),[
                'nCorrida' => $corrida->nCorridaDisponible,
                'nOrigen' => $corrida->nOrigen,
                'nDestino' => $corrida->nDestino,
            ]
        );
        // Encontrar asientos disponibles
        
        for ($i=1; $i <= $corrida->asientosTotal; $i++) { 
            $found=false;
            for($c=0;$c<sizeof($asientosOcupados);$c++){
                if($asientosOcupados[$c]->nAsiento === $i){
                    $found=true;
                    break;
                }
            }
            if(!$found){
                //meter solo los que no se encuentran
                $asientosDisp[$i]=$i;
            }
        }
        if($corrida->asientosDisponibles > 5){
            do {
                // dd(sizeof($asientosDisp));
                if(sizeof($asientosDisp) < 7){
                    break;
                }

                $cantAsientos=rand(1,3);
                // VENTA
                $ventaID=App\Models\Venta::create([
                    'nSesion' => $sesionVenta->nNumero,
                    'nCorridaIda' => $corrida->nCorridaDisponible,
                    'nCorridaRegreso' => null,
                ]);
                $ventaID->setCodbarAttribute($ventaID->nNumero);
                

                $asiento=array_values($asientosDisp)[0];
                $asientosDisp=array_splice( $asientosDisp,1,sizeof($asientosDisp));
                for ($i=0; $i < $cantAsientos; $i++) {
                    //BOLETOS
                    $boleto=App\Models\BoletosVendidos::create([
                        'nVenta' => $ventaID->nNumero,
                        'nCorrida' => $corrida->nCorridaDisponible,
                        'lRegreso' => 0,
                        'fSalida' => $corrida->fSalida,
                        'hSalida' => $corrida->hSalida,
                        'nOrigen' => $corrida->nOrigen,
                        'nDestino' => $corrida->nDestino,
                        'aTipoPasajero' => $TiposPasajeros[rand(0,4)],
                        'aPasajero' => $faker->name,
                        'nAsiento' => $asiento,
                        'aTipoVenta' => 'CO',
                        'nMontoBase' => 99.99,
                        'nMontoDescuento' => 0.01,
                        'nIva' => 10.01,
                        'aEstado' => 'VE',
                        'nTerminal' => 3,
                    ]);
                    //Apartar
                    try{
                        $apartados=collect(
                            DB::SELECT('SELECT apartar_asiento(?,?,?,?,?,?,?) as asientos',[
                                $corrida->nCorridaDisponible, $corrida->nOrigen, $corrida->nDestino,
                                $asiento, 1, 'VE', $boleto->nNumero
                                ])
                                )->first()->asientos;
                    }catch(\Exception $e){
                        // DB::rollback();
                        throw $e;
                    }
                }
                $corrida->asientosOcupados = $corrida->asientosOcupados + $cantAsientos;
            } while ($corrida->asientosOcupados < $corrida->asientosDisponibles - 8);
        }
    }
});


Route::get('/comm', function(Request $request){
    echo '<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>';
    echo "leer archivo
        <br>
        <button onclick='leerTarjetaBancaria()' >exec c#</button>
        ";
    echo "
    <script>
        function saludar(nombre){
            alert('hola '+nombre)
        }

        // llenarTarjeta({tarjeta:0, expiracion:'10/23', ccv:'123'})
        function llenarTarjeta(datos){
            document.getElementById('tarjeta').value=datos.tarjeta;
            document.getElementById('expiracion').value=datos.expiracion;
            document.getElementById('ccv').value=datos.ccv;
        }

        window.leerTarjetaBancaria = function(){
            window.chrome.webview.postMessage(\"{leerTarjetaBancaria:true}\");
        }

        function retorno(){
            return 'retorno';
        }
    </script>
    <br>
    <input id='tarjeta' placeholder='tarjeta'>
    <input id='expiracion' placeholder='expiracion'>
    <input id='ccv' placeholder='ccv'>
    ";
});