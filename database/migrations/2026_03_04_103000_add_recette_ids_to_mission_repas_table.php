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
        Schema::table('mission_repas', function (Blueprint $table) {
            $table->foreignId('entree_recette_id')->nullable()->constrained('recettes')->nullOnDelete();
            $table->foreignId('plat_recette_id')->nullable()->constrained('recettes')->nullOnDelete();
            $table->foreignId('accompagnement_recette_id')->nullable()->constrained('recettes')->nullOnDelete();
            $table->foreignId('dessert_recette_id')->nullable()->constrained('recettes')->nullOnDelete();
            $table->foreignId('simple_recette_id')->nullable()->constrained('recettes')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('mission_repas', function (Blueprint $table) {
            $table->dropForeign(['entree_recette_id']);
            $table->dropForeign(['plat_recette_id']);
            $table->dropForeign(['accompagnement_recette_id']);
            $table->dropForeign(['dessert_recette_id']);
            $table->dropForeign(['simple_recette_id']);
            
            $table->dropColumn([
                'entree_recette_id', 
                'plat_recette_id', 
                'accompagnement_recette_id', 
                'dessert_recette_id', 
                'simple_recette_id'
            ]);
        });
    }
};
