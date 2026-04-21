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
        // 1. Déplacer les données existantes de name vers nom/prenom
        $users = DB::table('users')->whereNotNull('name')->get();

        foreach ($users as $user) {
            if (empty($user->nom) && empty($user->prenom) && !empty($user->name)) {
                // On essaie de séparer le nom et le prénom par l'espace
                $parts = explode(' ', $user->name, 2);
                $prenom = $parts[0];
                $nom = isset($parts[1]) ? $parts[1] : '';

                DB::table('users')->where('id', $user->id)->update([
                    'prenom' => $prenom,
                    'nom' => $nom,
                ]);
            }
        }

        // 2. Supprimer la colonne name
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('name');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('name')->nullable();
        });
    }
};
