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
        Schema::create('missions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('structure_id')->constrained('structures')->onDelete('cascade');
            $table->foreignId('professionnel_id')->nullable()->constrained('professionnels')->onDelete('set null');
            $table->date('date');
            $table->string('duree')->nullable();
            $table->string('statut')->default('en attente');

            //Menus

            $table->string('menuEntree')->nullable();
            $table->string('menuPlat')->nullable();
            $table->string('menuDessert')->nullable();
            
            //Quantités et checklists
            $table->text('quantitesCalculees')->nullable();
            $table->text('quantitesViande')->nullable();
            $table->text('quantitesLegumes')->nullable();
            $table->text('quantitesPoissons')->nullable();
            $table->text('quantitesAutre')->nullable();

            $table->text('checklistJournee')->nullable();
            $table->text('checklistItems')->nullable();
            $table->text('commentaires')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('missions');
    }
};
