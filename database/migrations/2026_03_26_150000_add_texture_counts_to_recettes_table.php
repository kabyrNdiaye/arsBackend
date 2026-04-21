<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('recettes', function (Blueprint $table) {
            $table->integer('nb_regimes_haches')->default(0)->after('textures');
            $table->integer('nb_regimes_mixes')->default(0)->after('nb_regimes_haches');
            $table->integer('nb_regimes_moulines')->default(0)->after('nb_regimes_mixes');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('recettes', function (Blueprint $table) {
            $table->dropColumn(['nb_regimes_haches', 'nb_regimes_mixes', 'nb_regimes_moulines']);
        });
    }
};
