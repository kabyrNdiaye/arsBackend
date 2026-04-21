<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     * Ajoute latitude et longitude si elles n'existent pas encore
     */
    public function up(): void
    {
        Schema::table('mission_messages', function (Blueprint $table) {
            if (!Schema::hasColumn('mission_messages', 'latitude')) {
                $table->decimal('latitude', 10, 8)->nullable();
            }
            if (!Schema::hasColumn('mission_messages', 'longitude')) {
                $table->decimal('longitude', 11, 8)->nullable();
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('mission_messages', function (Blueprint $table) {
            $table->dropColumnIfExists('latitude');
            $table->dropColumnIfExists('longitude');
        });
    }
};
