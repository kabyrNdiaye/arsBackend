<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
   public function up()
{
    Schema::table('users', function (Blueprint $table) {
        // Rendre 'name' facultatif pour privilégier 'nom' et 'prenom'
        $table->string('name')->nullable()->change();
    });
}

public function down()
{
    Schema::table('users', function (Blueprint $table) {
        $table->string('name')->nullable(false)->change();
    });
}

    /**
     * Reverse the migrations.
     */

};
