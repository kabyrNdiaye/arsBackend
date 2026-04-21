
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
        Schema::create('documents', function (Blueprint $table) {
            $table->id();
            $table->morphs('documentable'); 
            $table->string('nom'); // Ex: CV_Jean_Dupont.pdf
            $table->string('type'); // Ex: CV, Diplôme, Assurance
            $table->string('cheminFichier'); // Le chemin de stockage local ou S3
            $table->string('statut')->default('en attente'); // en attente, validé, rejeté
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('documents');
    }
};
