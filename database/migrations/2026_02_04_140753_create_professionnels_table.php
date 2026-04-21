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
        Schema::create('professionnels', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // Infos personnelles
            $table->date('date_naissance')->nullable();
            $table->string('lieu_naissance')->nullable();
            
            // Infos professionnelles
            $table->string('diplome')->nullable();
            $table->integer('annees_experience')->nullable();
            $table->json('specialites')->nullable(); // Liste des spécialités
            
            // Documents (Chemins)
            $table->string('photo_profil_path')->nullable();
            $table->string('diplome_path')->nullable();
            $table->string('certificat_medical_path')->nullable();
            $table->string('permis_conduire_path')->nullable();
            
            // Statut
            $table->string('statut_validation')->default('en_attente'); // snake_case value too? 'en_attente'
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('professionnels');
    }
};
