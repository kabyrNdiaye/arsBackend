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
        Schema::table('missions', function (Blueprint $table) {
            // Nombre de résidents (Obligatoire)
            $table->integer('nb_residents_jour')->nullable();
            
            // Types de repas et Régimes (JSON - Obligatoire)
            $table->json('types_repas')->nullable(); 
            $table->json('regimes_speciaux')->nullable(); 
            
            // Menu (Texte libre)
            $table->text('menu_entree_brut')->nullable();
            $table->text('menu_plat_brut')->nullable();
            $table->text('menu_accompagnement_brut')->nullable();
            $table->text('menu_dessert_brut')->nullable();
            
            // Horaires et approximations
            $table->datetime('horaire_mission')->nullable();
            $table->integer('nb_regimes_haches')->default(0);
            $table->integer('nb_regimes_mixes')->default(0);
            $table->integer('nb_regimes_moulines')->default(0);
            
            // Quantités estimées
            $table->float('quantite_viande')->nullable();
            $table->float('quantite_riz')->nullable();
            $table->float('quantite_legumes')->nullable();
            
            // Meta
            $table->boolean('est_cree_par_admin')->default(false);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('missions', function (Blueprint $table) {
            $table->dropColumn([
                'nb_residents_jour',
                'types_repas',
                'regimes_speciaux',
                'menu_entree_brut',
                'menu_plat_brut',
                'menu_accompagnement_brut',
                'menu_dessert_brut',
                'horaire_mission',
                'nb_regimes_haches',
                'nb_regimes_mixes',
                'nb_regimes_moulines',
                'quantite_viande',
                'quantite_riz',
                'quantite_legumes',
                'est_cree_par_admin'
            ]);
        });
    }
};
