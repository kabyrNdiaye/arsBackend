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
        Schema::create('structures', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // Infos Etablissement
            $table->string('nom_etablissement')->nullable(); // Correspond à Nom Structure
            $table->string('type_etablissement')->nullable();
            $table->integer('capacite')->nullable();
            
            // Le responsable est l'User lié, mais on garde 'fonction' ici si spécifique
            $table->string('fonction')->nullable(); 
            
            // Détails logistiques
            $table->json('repas')->nullable();
            $table->json('regimes')->nullable();
            
            // Documents (Chemins)
            $table->string('contrat_prestation_path')->nullable();
            $table->string('plan_locaux_path')->nullable();
            $table->string('reglement_interieur_path')->nullable();
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('structures');
    }
};
