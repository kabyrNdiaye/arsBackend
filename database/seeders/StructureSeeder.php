<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class StructureSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Création d'un compte Structure (Client)
        $user = \App\Models\User::updateOrCreate(
            ['email' => 'contact@clinique.fr'],
            [
                'prenom' => 'Jean',
                'nom' => 'Dupont',
                'telephone' => '771234567',
                'adresse' => 'Golf Sud',
                'ville' => 'Dakar',
                'password' => bcrypt('password'),
                'role' => 'client',
            ]
        );

        $user->structure()->updateOrCreate(
            ['user_id' => $user->id],
            [
                'nom_etablissement' => 'Clinique du Golf',
                'type_etablissement' => 'Clinique',
                'capacite' => 50,
                'fonction' => 'Directeur',
            ]
        );
    }
}
