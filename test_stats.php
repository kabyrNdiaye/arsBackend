<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\User;
use App\Models\Professionnel;
use App\Models\Structure;

echo "--- Debugging Admin Stats ---\n";
// Available Professionals
$validatedProfessionals = User::where('role', 'professionnel')
    ->whereHas('professionnel', function($q) {
        $q->where('statut_validation', 'valide');
    })
    ->whereDoesntHave('professionnel.missions', function($q) {
        $q->whereIn('statut', ['en cours', 'confirmé', 'confirmed']);
    })->count();
echo "Available professionals: $validatedProfessionals\n";

$allPros = User::where('role', 'professionnel')->count();
echo "Total professionals: $allPros\n";

// Active Sites
$activeSites = User::where('role', 'client')
    ->whereHas('structure', function($q) {
        $q->where('statut_validation', 'valide');
    })->count();
echo "Active sites: $activeSites\n";

$allSites = User::where('role', 'client')->count();
echo "Total sites: $allSites\n";

echo "Check validation status in pro:\n";
$prosGroups = Professionnel::select('statut_validation', \DB::raw('count(*) as total'))
                 ->groupBy('statut_validation')
                 ->pluck('total','statut_validation')->toArray();
print_r($prosGroups);

echo "Check validation status in struct:\n";
$structGroups = Structure::select('statut_validation', \DB::raw('count(*) as total'))
                 ->groupBy('statut_validation')
                 ->pluck('total','statut_validation')->toArray();
print_r($structGroups);
