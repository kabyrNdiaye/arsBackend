<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class UpdateIngredientsColumnInRecettesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        // On convertit les anciennes données (chaîne de texte simple) vers le nouveau format JSON array.
        // Chaque ancienne chaîne deviendra: [{"nom": "L'ancien texte", "quantite": 1, "prix": 0}]
        
        $recettes = DB::table('recettes')->get();

        foreach ($recettes as $recette) {
            $oldIngredients = $recette->ingredients;
            
            // Si $oldIngredients n'est pas déjà un JSON valide et n'est pas vide
            if (!empty($oldIngredients) && !is_array(json_decode($oldIngredients, true))) {
                
                $newIngredients = json_encode([
                    [
                        'nom' => $oldIngredients,
                        'quantite' => 1,
                        'prix' => 0
                    ]
                ]);

                DB::table('recettes')
                    ->where('id', $recette->id)
                    ->update(['ingredients' => $newIngredients]);
            } else if (empty($oldIngredients)) {
                DB::table('recettes')
                    ->where('id', $recette->id)
                    ->update(['ingredients' => json_encode([])]);
            }
        }
        
        // Optionnel : s'il s'agissait d'un type TEXT non json, on le force en JSON (spécifique aux configs).
        // Dans SQLite (qui est faible, le JSON est du TEXT). Postgres accepte JSON.
        // Pour être sûr on s'assure juste que ce que contient la colonne est du JSON (fait au dessus).
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Revert n'est pas strict, car si on rollback, string() ne causera pas de crash en tant que JSON.
        // Mais on convertit le JSON vers la string de base si possible.
        $recettes = DB::table('recettes')->get();

        foreach ($recettes as $recette) {
            $ingredients = json_decode($recette->ingredients, true);
            if (is_array($ingredients)) {
                $noms = array_map(function($ing) { return $ing['nom'] ?? ''; }, $ingredients);
                $oldString = implode(', ', $noms);
                DB::table('recettes')
                    ->where('id', $recette->id)
                    ->update(['ingredients' => $oldString]);
            }
        }
    }
}
