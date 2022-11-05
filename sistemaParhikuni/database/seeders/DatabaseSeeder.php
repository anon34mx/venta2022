<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
// use OficinasSeeder;
use Database\Seeders\tipoServicioSeeder;
use DB;
class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        //======== [    PERMISOS    ] ========
        //      Usuarios
        Permission::create(['name' => 'users.index']);
        Permission::create(['name' => 'users.store']);
        Permission::create(['name' => 'users.edit']);
        Permission::create(['name' => 'users.update']);
        Permission::create(['name' => 'users.destroy']);
        Permission::create(['name' => 'users.addrol']);
        Permission::create(['name' => 'users.removerol']);
        Permission::create(['name' => 'users.editPermissions']);
        
        //      Personas
        Permission::create(['name' => 'personas.update']);

        //      Corridas programadas
        Permission::create(['name' => 'corridas.programadas.index']);
        Permission::create(['name' => 'corridas.programadas.store']);
        Permission::create(['name' => 'corridas.programadas.show']);
        Permission::create(['name' => 'corridas.programadas.destroy']);
        Permission::create(['name' => 'corridas.programadas.transfer']);
        Permission::create(['name' => 'corridas.programadas.storeTransfer']);
        
        //      Corridas disponibles
        Permission::create(['name' => 'corridas.disponibles.index']);
        Permission::create(['name' => 'corridas.disponibles.edit']);
        Permission::create(['name' => 'corridas.disponibles.update']);
        
        //      Boletos
        Permission::create(['name' => 'boletos.limbo.show']);
        
        //      Personal
        Permission::create(['name' => 'personal.conductores.index']);
        Permission::create(['name' => 'personal.conductores.edit']);
        Permission::create(['name' => 'personal.conductores.update']);

        //======== [    ROLES    ] ========
        $admin = Role::create(['name' => 'Admin']); // sistemas
        $publicoGeneral = Role::create(['name' => 'publicoGeneral']);
        $servicios = Role::create(['name' => 'servicios']);
        // gerente de plaza
        // agente de venta
        // reservaciones/turismo

        //  ASIGNAR PERMISOS A ROLES
        $admin->givePermissionTo(Permission::all());

        $publicoGeneral->givePermissionTo([
            'users.edit',
            'users.update'
        ]);

        $servicios->givePermissionTo([
            'users.edit',
            'users.update'
        ]);

        /*
            $publicoGeneral->givePermissionTo([
                'compra.index',
                'compra.corridas',
            ]);
        */

        $servicios->givePermissionTo([
            'corridas.programadas.index',
            'corridas.programadas.store',
            'corridas.programadas.show',
            'corridas.programadas.destroy',
            'corridas.programadas.transfer',
            'corridas.programadas.storeTransfer',

            'corridas.disponibles.index',
            'corridas.disponibles.edit',
            'corridas.disponibles.update',

            'personal.conductores.index',
            'personal.conductores.edit',
            'personal.conductores.update',
        ]);

        $usuarioAdmin = User::create([
            'name' => 'DTI sistemas',
            'email' => 'dti_parhikuni@parhikuni.com.mx',
            'password' => bcrypt('123456'),
            'persona_nNumero' => 1,
            ]);
        $user = User::find(1); 
        $user->assignRole('Admin');
        
        $usuarioSergio = User::create([
            'name' => 'Sergio Medrano',
            'email' => 'sergio.medrano@parhikuni.com.mx',
            'password' => bcrypt('123456'),
            ]);
        $usuarioSergio = User::find(2); 
        $usuarioSergio->assignRole('servicios');
        $usuarioSergio->givePermissionTo('users.index');
        // $usuarioSergio->revokePermissionTo('users.index');
        // $usuarioAdmin->assignRole('Admin');
        \App\Models\User::factory(3)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
        
        // OficinasSeeder::run();
        $this->call([
            ventaSeeder::class,
        ]);

        DB::unprepared('SELECT corridasPorDia("2022-10-01", 60);');
    }
}
