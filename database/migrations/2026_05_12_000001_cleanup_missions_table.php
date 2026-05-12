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
            $colsToDrop = [
                'menu_entree_brut', 
                'menu_plat_brut', 
                'menu_accompagnement_brut', 
                'menu_dessert_brut', 
                'duree', 
                'date'
            ];

            foreach ($colsToDrop as $col) {
                if (Schema::hasColumn('missions', $col)) {
                    $table->dropColumn($col);
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
            $table->text('menu_entree_brut')->nullable();
            $table->text('menu_plat_brut')->nullable();
            $table->text('menu_accompagnement_brut')->nullable();
            $table->text('menu_dessert_brut')->nullable();
            $table->string('duree')->nullable();
            $table->date('date')->nullable();
        });
    }
};
