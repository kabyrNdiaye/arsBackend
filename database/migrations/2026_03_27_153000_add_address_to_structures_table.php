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
        Schema::table('structures', function (Blueprint $table) {
            $table->text('adresse')->nullable()->after('type_etablissement');
            $table->string('code_postal', 10)->nullable()->after('adresse');
            $table->string('ville', 100)->nullable()->after('code_postal');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('structures', function (Blueprint $table) {
            $table->dropColumn(['adresse', 'code_postal', 'ville']);
        });
    }
};
