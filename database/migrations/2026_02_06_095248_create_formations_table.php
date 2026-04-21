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
        Schema::create('formations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('professionnel_id')->constrained('professionnels')->onDelete('cascade');
            $table->string('titre');
            $table->string('duree');
            $table->string('video_url')->nullable();
            $table->string('type')->default('Recommandé');
            $table->string('image_url')->nullable(); 
            $table->string('statutValidation')->default('A compléter');
            $table->date('dateLimite')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('formations');
    }
};
