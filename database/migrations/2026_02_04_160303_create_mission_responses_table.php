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
        if (!Schema::hasTable('mission_responses')) {
            Schema::create('mission_responses', function (Blueprint $blueprint) {
                $blueprint->id();
                $blueprint->foreignId('mission_id')->constrained()->onDelete('cascade');
                $blueprint->foreignId('professionnel_id')->constrained()->onDelete('cascade');
                $blueprint->string('status'); // 'accepted', 'rejected'
                $blueprint->timestamps();

                $blueprint->unique(['mission_id', 'professionnel_id']);
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mission_responses');
    }
};
