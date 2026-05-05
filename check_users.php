<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

$users = \App\Models\User::select('id', 'email', 'role', 'email_verified_at')->get();
foreach ($users as $u) {
    $profile = $u->role === 'professionnel' ? $u->professionnel : $u->structure;
    $statut = $profile ? $profile->statut_validation : 'N/A';
    $verified = $u->email_verified_at ? 'OUI' : 'NON';
    echo "ID:{$u->id} | {$u->email} | role:{$u->role} | email_verifie:{$verified} | statut:{$statut}\n";
}
