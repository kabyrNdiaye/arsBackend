<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

$user = \App\Models\User::where('role', 'admin')->first();
if ($user) {
    $user->email = 'smknd2002@gmail.com';
    $user->save();
    echo "Email admin mis a jour : " . $user->email . "\n";
} else {
    echo "Aucun admin trouve.\n";
}
