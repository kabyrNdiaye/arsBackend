<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Pour PostgreSQL, il faut modifier le type enum ou la contrainte de check
        // Dans Laravel, change() sur un enum peut être délicat selon la version et le driver
        // Une approche sûre pour PostgreSQL est de recréer la colonne ou d'utiliser une requête brute
        
        if (config('database.default') === 'pgsql') {
            // PostgreSQL approach: Drop old check constraint and add new one if it was a check constraint
            // Or if it's a native ENUM type, we need to alter it.
            // However, Laravel's ->enum() usually creates a CHECK constraint for pgsql
            
            DB::statement("ALTER TABLE mission_messages DROP CONSTRAINT IF EXISTS mission_messages_type_check");
            DB::statement("ALTER TABLE mission_messages ADD CONSTRAINT mission_messages_type_check CHECK (type::text = ANY (ARRAY['text'::character varying, 'image'::character varying, 'file'::character varying, 'location'::character varying, 'contact'::character varying, 'audio'::character varying, 'incident'::character varying, 'feedback'::character varying]::text[]))");
        } else {
            // MySQL or other approach
            Schema::table('mission_messages', function (Blueprint $table) {
                $table->enum('type', ['text', 'image', 'file', 'location', 'contact', 'audio', 'incident', 'feedback'])->default('text')->change();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        if (config('database.default') === 'pgsql') {
            DB::statement("ALTER TABLE mission_messages DROP CONSTRAINT IF EXISTS mission_messages_type_check");
            DB::statement("ALTER TABLE mission_messages ADD CONSTRAINT mission_messages_type_check CHECK (type::text = ANY (ARRAY['text'::character varying, 'image'::character varying, 'file'::character varying, 'location'::character varying, 'contact'::character varying, 'audio'::character varying]::text[]))");
        } else {
            Schema::table('mission_messages', function (Blueprint $table) {
                $table->enum('type', ['text', 'image', 'file', 'location', 'contact', 'audio'])->default('text')->change();
            });
        }
    }
};
