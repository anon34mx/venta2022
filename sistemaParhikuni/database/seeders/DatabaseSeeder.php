<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use App\Models\User;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

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

        Permission::create(['name' => 'corridasPermanentes.index']);
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
            'corridasPermanentes.index',
            'corridasDisponibles.index',
        ]);

        $usuarioAdmin = User::create([
            'name' => 'DTI sistemas',
            'email' => 'dti_parhikuni@parhikuni.com.mx',
            'password' => bcrypt('123456'),
            ]);
        $user = User::find(1); 
        $user->assignRole('Admin');
        
        $usuarioServicios = User::create([
            'name' => 'servicios',
            'email' => 'servicios@parhikuni.mx',
            'password' => bcrypt('123456'),
            ]);
        $usuarioServicios = User::find(2); 
        $usuarioServicios->assignRole('servicios');
        // $usuarioAdmin->assignRole('Admin');
        \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
