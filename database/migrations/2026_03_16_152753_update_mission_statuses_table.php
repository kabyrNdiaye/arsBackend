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
        // Mettre à jour le statut par défaut de la colonne
        Schema::table('missions', function (Blueprint $table) {
            $table->string('statut')->default('en cours')->change();
        });

        // Migrer les données existantes
        \DB::table('missions')->where('statut', 'en attente')->update(['statut' => 'en cours']);
        \DB::table('missions')->whereIn('statut', ['Confirmé', 'Confirmée', 'Validée', 'Validé'])->update(['statut' => 'confirmé']);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('missions', function (Blueprint $table) {
            $table->string('statut')->default('en attente')->change();
        });

        \DB::table('missions')->where('statut', 'en cours')->update(['statut' => 'en attente']);
        \DB::table('missions')->where('statut', 'confirmé')->update(['statut' => 'Confirmé']);
    }
};
