<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Transférer les données de la table structures
        if (Schema::hasColumn('structures', 'contrat_prestation_path')) {
            $structures = DB::table('structures')->get();
            foreach ($structures as $structure) {
                $files = [
                    'contrat_prestation_path' => $structure->contrat_prestation_path,
                    'plan_locaux_path' => $structure->plan_locaux_path,
                    'reglement_interieur_path' => $structure->reglement_interieur_path,
                ];

                foreach ($files as $name => $path) {
                    if ($path) {
                        DB::table('documents')->insert([
                            'documentable_type' => 'App\Models\Structure',
                            'documentable_id' => $structure->id,
                            'nom' => $name,
                            'type' => 'document',
                            'cheminFichier' => $path,
                            'statut' => 'actif',
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }
                }
            }

            // Supprimer les colonnes dans structures
            Schema::table('structures', function (Blueprint $table) {
                $table->dropColumn(['contrat_prestation_path', 'plan_locaux_path', 'reglement_interieur_path']);
            });
        }

        // 2. Transférer les données de la table professionnels
        if (Schema::hasColumn('professionnels', 'photo_profil_path')) {
            $professionnels = DB::table('professionnels')->get();
            foreach ($professionnels as $prof) {
                $files = [
                    'photo_profil_path' => $prof->photo_profil_path,
                    'diplome_path' => $prof->diplome_path,
                    'certificat_medical_path' => $prof->certificat_medical_path,
                    'permis_conduire_path' => $prof->permis_conduire_path,
                ];

                foreach ($files as $name => $path) {
                    if ($path) {
                        DB::table('documents')->insert([
                            'documentable_type' => 'App\Models\Professionnel',
                            'documentable_id' => $prof->id,
                            'nom' => $name,
                            'type' => 'document',
                            'cheminFichier' => $path,
                            'statut' => 'actif',
                            'created_at' => now(),
                            'updated_at' => now(),
                        ]);
                    }
                }
            }

            // Supprimer les colonnes dans professionnels
            Schema::table('professionnels', function (Blueprint $table) {
                $table->dropColumn(['photo_profil_path', 'diplome_path', 'certificat_medical_path', 'permis_conduire_path']);
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('structures', function (Blueprint $table) {
            $table->string('contrat_prestation_path')->nullable();
            $table->string('plan_locaux_path')->nullable();
            $table->string('reglement_interieur_path')->nullable();
        });

        Schema::table('professionnels', function (Blueprint $table) {
            $table->string('photo_profil_path')->nullable();
            $table->string('diplome_path')->nullable();
            $table->string('certificat_medical_path')->nullable();
            $table->string('permis_conduire_path')->nullable();
        });
    }
};
