<?php

use App\Models\User;
use App\Models\Structure;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();

$email = 'test_structure_address@example.com';

// Delete if exists
User::where('email', $email)->delete();

DB::beginTransaction();
try {
    $user = User::create([
        'prenom' => 'Test',
        'nom' => 'Structure',
        'email' => $email,
        'password' => Hash::make('password'),
        'role' => 'client',
        'telephone' => '0102030405',
        'adresse' => '123 Rue de la Paix',
        'code_postal' => '75000',
        'ville' => 'Paris',
    ]);

    $structure = Structure::create([
        'user_id' => $user->id,
        'nom_etablissement' => 'Test Establishment',
        'type_etablissement' => 'EHPAD',
        'capacite' => 50,
        'fonction' => 'Directeur',
        'statut_validation' => 'en_attente',
    ]);

    DB::commit();
    echo "User created: " . $user->id . "\n";
} catch (\Exception $e) {
    DB::rollBack();
    echo "Error: " . $e->getMessage() . "\n";
    exit(1);
}

$user = User::where('email', $email)->first();
echo "Stored Address: " . $user->adresse . "\n";
echo "Stored zip: " . $user->code_postal . "\n";
echo "Stored city: " . $user->ville . "\n";

$resource = new \App\Http\Resources\UserResource($user->load('structure'));
$data = $resource->resolve();
echo "Resource Address: " . ($data['adresse'] ?? 'MISSING') . "\n";
echo "Resource Zip: " . ($data['code_postal'] ?? 'MISSING') . "\n";
echo "Resource City: " . ($data['ville'] ?? 'MISSING') . "\n";
