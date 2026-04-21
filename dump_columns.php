<?php

require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

use Illuminate\Support\Facades\Schema;

$columns = Schema::getColumnListing('structures');
echo "Columns in structures table:\n";
foreach ($columns as $column) {
    echo "- $column\n";
}

$columnsUser = Schema::getColumnListing('users');
echo "\nColumns in users table:\n";
foreach ($columnsUser as $column) {
    echo "- $column\n";
}
