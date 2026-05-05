<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Fix the retours table to support both Feedback and Retour models.
     */
    public function up(): void
    {
        Schema::table('retours', function (Blueprint $table) {
            // Make mission_id nullable to support global feedback
            $table->unsignedBigInteger('mission_id')->nullable()->change();

            // Add missing columns if they don't exist
            if (!Schema::hasColumn('retours', 'user_id')) {
                $table->foreignId('user_id')->nullable()->constrained('users')->onDelete('cascade');
            }
            if (!Schema::hasColumn('retours', 'rating')) {
                $table->integer('rating')->nullable();
            }
            if (!Schema::hasColumn('retours', 'comment')) {
                $table->text('comment')->nullable();
            }
            if (!Schema::hasColumn('retours', 'type')) {
                $table->string('type')->nullable()->default('general');
            }
        });
    }

    public function down(): void
    {
        Schema::table('retours', function (Blueprint $table) {
            $table->unsignedBigInteger('mission_id')->nullable(false)->change();
            $table->dropColumn(['user_id', 'rating', 'comment', 'type']);
        });
    }
};
