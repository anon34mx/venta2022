<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use Database\Seeders\OficinasSeeder;
use Database\Seeders\distribucionAsientosSeeder;
use Database\Seeders\tipoServicioSeeder;
use DB;

class ventaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     * @return void
     */

    // php artisan make:seeder OficinasSeeder
    // php artisan db:seed --class=ventaSeeder
    //      --force
    public function run()
    {
        exec('cmd /c "C:/xampp/htdocs/venta2022/[BD]/respaldos/RESTAURAR_en_laravel.bat"');
        $path_poblar = ('C:\\xampp\\htdocs\\venta2022\\[BD]\\inserts\\poblar.sql');
        $sql_poblar = file_get_contents($path_poblar);
        DB::unprepared($sql_poblar);

        // sobre la tabla de usuarios
        DB::unprepared("ALTER TABLE users ADD FOREIGN KEY (persona_nNumero) REFERENCES personas(nNumeroPersona)
            ON UPDATE CASCADE ON DELETE RESTRICT, ADD UNIQUE (persona_nNumero);
        ");
        DB::unprepared("ALTER TABLE `corridas_versiones`
            ADD FOREIGN KEY (user_id)
            REFERENCES users(id)
            ON UPDATE CASCADE ON DELETE RESTRICT;
        ");
        DB::unprepared("ALTER TABLE corridas_disponibles_historial
            ADD FOREIGN KEY(user)
            REFERENCES users(id)
            ON UPDATE CASCADE ON DELETE RESTRICT
        ");
        //SELECT corridasPorDia(current_date,365);

    }
}
