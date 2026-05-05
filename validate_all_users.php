<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

// 1. Vérifier tous les emails
$count = \App\Models\User::whereNull('email_verified_at')
    ->update(['email_verified_at' => now()]);
echo "Emails verifies : {$count} comptes mis a jour.\n";

// 2. Valider tous les professionnels
$countPro = \App\Models\Professionnel::where('statut_validation', '!=', 'valide')
    ->update(['statut_validation' => 'valide']);
echo "Professionnels valides : {$countPro} profils mis a jour.\n";

// 3. Valider toutes les structures (clients)
$countStruct = \App\Models\Structure::where('statut_validation', '!=', 'valide')
    ->update(['statut_validation' => 'valide']);
echo "Structures validees : {$countStruct} profils mis a jour.\n";

// 4. Afficher le résultat final
echo "\n--- LISTE FINALE ---\n";
$users = \App\Models\User::select('id', 'email', 'role', 'email_verified_at')->get();
foreach ($users as $u) {
    $profile = $u->role === 'professionnel' ? $u->professionnel : $u->structure;
    $statut = $profile ? $profile->statut_validation : 'N/A';
    echo "ID:{$u->id} | {$u->email} | {$u->role} | statut:{$statut}\n";
}
