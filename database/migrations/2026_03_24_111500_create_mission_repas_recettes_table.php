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
        Schema::create('mission_repas_recettes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('mission_repas_id')->constrained('mission_repas')->cascadeOnDelete();
            $table->foreignId('recette_id')->constrained('recettes')->cascadeOnDelete();
            $table->string('category'); // entree, plat, accompagnement, dessert, simple
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mission_repas_recettes');
    }
};
