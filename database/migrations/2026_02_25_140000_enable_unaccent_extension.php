<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Activer l'extension unaccent dans PostgreSQL
        DB::statement('CREATE EXTENSION IF NOT EXISTS unaccent');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // On ne désactive pas forcément l'extension car elle peut être utilisée par d'autres tables
        // Mais si on veut être strict :
        // DB::statement('DROP EXTENSION IF EXISTS unaccent');
    }
};
