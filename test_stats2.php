<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;
use App\Models\Professionnel;
use App\Models\Structure;

echo "--- BEFORE ---\n";
// Available Professionals
$beforePros = User::where('role', 'professionnel')
    ->whereHas('professionnel', function($q) {
        $q->where('statut_validation', 'valide');
    })
    ->whereDoesntHave('professionnel.missions', function($q) {
        $q->whereIn('statut', ['en cours', 'confirmé', 'confirmed']);
    })->count();
echo "Available professionals before: $beforePros\n";

$beforeSites = User::where('role', 'client')
    ->whereHas('structure', function($q) {
        $q->where('statut_validation', 'valide');
    })->count();
echo "Active sites before: $beforeSites\n";

DB::beginTransaction();
try {
    $user = User::create([
        'prenom' => 'Test',
        'nom' => 'User',
        'email' => 'test' . time() . '@test.com',
        'password' => bcrypt('password'),
        'role' => 'professionnel',
    ]);
    
    $pro = Professionnel::create([
        'user_id' => $user->id,
        'statut_validation' => 'en_attente',
    ]);
    
    echo "Created user, now validating...\n";
    $pro->update(['statut_validation' => 'valide']);
    
    $afterPros = User::where('role', 'professionnel')
        ->whereHas('professionnel', function($q) {
            $q->where('statut_validation', 'valide');
        })
        ->whereDoesntHave('professionnel.missions', function($q) {
            $q->whereIn('statut', ['en cours', 'confirmé', 'confirmed']);
        })->count();
    echo "Available professionals after: $afterPros\n";

} catch (\Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
DB::rollBack();

