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
        // PERMISOS
        Permission::create(['name' => 'users.index']);
        Permission::create(['name' => 'users.store']);
        Permission::create(['name' => 'users.edit']);
        Permission::create(['name' => 'users.update']);
        Permission::create(['name' => 'users.destroy']);
        Permission::create(['name' => 'users.addrol']);
        Permission::create(['name' => 'users.removerol']);
        Permission::create(['name' => 'users.editPermissions']);


        Permission::create(['name' => 'corridasProgramadas.index']);
        Permission::create(['name' => 'corridasDisponibles.index']);


        //  ROLES
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
            'corridasProgramadas.index',
            'corridasDisponibles.index',
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
        \App\Models\User::factory(25)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
        
        // OficinasSeeder::run();
        $this->call([
            ventaSeeder::class,
        ]);

        
    }
}
