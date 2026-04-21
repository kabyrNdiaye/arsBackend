<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Renommer la table feedbacks en retours.
     */
    public function up(): void
    {
        if (Schema::hasTable('feedbacks') && !Schema::hasTable('retours')) {
            Schema::rename('feedbacks', 'retours');
        }
    }

    public function down(): void
    {
        if (Schema::hasTable('retours') && !Schema::hasTable('feedbacks')) {
            Schema::rename('retours', 'feedbacks');
        }
    }
};
