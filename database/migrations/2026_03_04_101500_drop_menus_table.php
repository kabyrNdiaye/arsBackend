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
        // 1. Supprimer la colonne menu_id de la table recettes
        Schema::table('recettes', function (Blueprint $table) {
            $table->dropForeign(['menu_id']);
            $table->dropColumn('menu_id');
        });

        // 2. Supprimer la table menus
        Schema::dropIfExists('menus');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::create('menus', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->string('type_repas');
            $table->string('statut')->default('brouillon');
            $table->json('regimes_compatibles')->nullable();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->text('description')->nullable();
            $table->timestamps();
        });

        Schema::table('recettes', function (Blueprint $table) {
            $table->foreignId('menu_id')->nullable()->constrained('menus')->onDelete('cascade');
        });
    }
};
