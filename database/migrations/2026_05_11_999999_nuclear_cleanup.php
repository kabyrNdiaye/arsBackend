<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Document;
use App\Models\Professionnel;
use App\Models\Structure;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        try {
            // Nettoyage de la table documents
            Document::truncate();
            
            // Nettoyage des colonnes héritées
            Professionnel::query()->update([
                'photo_profil_path' => null, 
                'diplome_path' => null, 
                'certificat_medical_path' => null, 
                'permis_conduire_path' => null
            ]);
            
            Structure::query()->update([
                'contrat_prestation_path' => null, 
                'plan_locaux_path' => null, 
                'reglement_interieur_path' => null
            ]);
        } catch (\Exception $e) {
            // On ignore les erreurs si déjà nettoyé
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Rien à faire
    }
};
