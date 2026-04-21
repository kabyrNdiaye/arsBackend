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
        Schema::create('mission_repas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('mission_id')->constrained()->onDelete('cascade');
            $table->string('type_repas'); // breakfast, lunch, snack, dinner
            
            // Pour Déjeuner & Dîner (Complet)
            $table->string('entree')->nullable();
            $table->string('plat')->nullable();
            $table->string('accompagnement')->nullable();
            $table->string('dessert')->nullable();
            
            // Pour Petit-Déjeuner & Goûter (Simple)
            $table->text('description_simple')->nullable();
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mission_repas');
    }
};
