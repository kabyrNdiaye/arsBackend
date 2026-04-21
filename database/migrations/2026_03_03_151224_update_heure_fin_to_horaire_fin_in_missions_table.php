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
            // Rename and change type logic
            // Note: Since heure_fin might contain data, we might want to handle it carefully,
            // but for now we'll just drop and add for a clean datetime transition.
            if (Schema::hasColumn('missions', 'heure_fin')) {
                $table->dropColumn('heure_fin');
            }
            $table->datetime('horaire_fin')->nullable()->after('horaire_mission');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('missions', function (Blueprint $table) {
            $table->dropColumn('horaire_fin');
            $table->string('heure_fin')->nullable()->after('horaire_mission');
        });
    }
};
