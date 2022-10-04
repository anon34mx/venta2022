<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('persona_has_user', function (Blueprint $table) {
            $table->unsignedBigInteger('user_id');
            $table->foreign('user_id')->references('id')->on('users');
            $table->unsignedInteger('persona');

            $table->charset = 'utf8mb4';
            $table->collation = 'utf8mb4_general_ci';
        });
        /*
        ADD FOREIGN KEY (persona) REFERENCES personas(nNumero) USING BTREE,

        CORRER A MANO
        ALTER TABLE `laravel`.`persona_has_user` 
            ADD INDEX `persona_has_user_persona_foreign` (`persona`) USING BTREE,
            ADD UNIQUE UN_user_id (user_id),
            ADD UNIQUE UN_persona (persona)
        */
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('persona_has_user');
    }
};
