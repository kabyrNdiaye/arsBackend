<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$recettes = \DB::table('recettes')->orderBy('id', 'desc')->take(5)->get();
file_put_contents('recent_recipes.json', json_encode($recettes, JSON_PRETTY_PRINT));
echo "Done\n";
