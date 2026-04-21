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
            // Renommages sécurisés pour alignement (seulement si les anciennes colonnes existent)
            $renames = [
                'nombre_residents' => 'nb_residents_jour',
                'type_repas_prevus' => 'types_repas',
                'entree_texte' => 'menu_entree_brut',
                'plat_texte' => 'menu_plat_brut',
                'accompagnement_texte' => 'menu_accompagnement_brut',
                'dessert_texte' => 'menu_dessert_brut',
                'nombre_regimes_haches' => 'nb_regimes_haches',
                'nombre_regimes_mixes' => 'nb_regimes_mixes',
                'nombre_regimes_moulines' => 'nb_regimes_moulines',
            ];

            foreach ($renames as $old => $new) {
                if (Schema::hasColumn('missions', $old) && !Schema::hasColumn('missions', $new)) {
                    $table->renameColumn($old, $new);
                }
            }
            
            // Suppression sécurisée des anciennes colonnes redondantes
            $colsToDrop = [
                'menuEntree', 'menuPlat', 'menuDessert', 
                'quantitesCalculees', 'quantitesViande', 'quantitesLegumes', 
                'quantitesPoissons', 'quantitesAutre', 'checklistJournee', 
                'checklistItems', 'quantitesRiz'
            ];
            
            foreach ($colsToDrop as $col) {
                if (Schema::hasColumn('missions', $col)) {
                    $table->dropColumn($col);
                }
            }
        });

        Schema::table('missions', function (Blueprint $table) {
            $colsToAdd = ['quantite_viande', 'quantite_riz', 'quantite_legumes'];
            foreach ($colsToAdd as $col) {
                if (!Schema::hasColumn('missions', $col)) {
                    $table->float($col)->nullable();
                }
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('missions', function (Blueprint $table) {
            // Inverse non implémenté car destruction destructive, 
            // mais on pourrait recréer les colonnes si besoin.
        });
    }
};
