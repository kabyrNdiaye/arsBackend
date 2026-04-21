<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     * Ajoute les types 'incident' et 'feedback' à la colonne type de mission_messages
     * Compatible PostgreSQL et MySQL
     */
    public function up(): void
    {
        $driver = DB::getDriverName();

        if ($driver === 'pgsql') {
            // PostgreSQL: change the column to varchar with check constraint
            DB::statement("ALTER TABLE mission_messages DROP CONSTRAINT IF EXISTS mission_messages_type_check");
            DB::statement("ALTER TABLE mission_messages ALTER COLUMN type TYPE VARCHAR(255)");
            DB::statement("ALTER TABLE mission_messages ADD CONSTRAINT mission_messages_type_check CHECK (type IN ('text', 'image', 'file', 'location', 'contact', 'audio', 'incident', 'feedback'))");
        } else {
            // MySQL
            DB::statement("ALTER TABLE mission_messages MODIFY COLUMN type ENUM('text', 'image', 'file', 'location', 'contact', 'audio', 'incident', 'feedback') DEFAULT 'text'");
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        $driver = DB::getDriverName();

        if ($driver === 'pgsql') {
            DB::statement("ALTER TABLE mission_messages DROP CONSTRAINT IF EXISTS mission_messages_type_check");
            DB::statement("ALTER TABLE mission_messages ADD CONSTRAINT mission_messages_type_check CHECK (type IN ('text', 'image', 'file', 'location', 'contact', 'audio'))");
        } else {
            DB::statement("ALTER TABLE mission_messages MODIFY COLUMN type ENUM('text', 'image', 'file', 'location', 'contact', 'audio') DEFAULT 'text'");
        }
    }
};
