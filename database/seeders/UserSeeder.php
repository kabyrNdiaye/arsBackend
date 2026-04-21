<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Création d'un professionnel de test
        $user = \App\Models\User::updateOrCreate(
            ['email' => 'kabyr@itea.fr'],
            [
                'nom' => 'ITEA',
                'prenom' => 'Kabyr',
                'telephone' => '771234567',
                'password' => bcrypt('password'),
                'role' => 'professionnel',
            ]
        );

        $user->professionnel()->updateOrCreate(
            ['user_id' => $user->id],
            [
                'specialites' => ['Cuisine', 'Pâtisserie'],
                'annees_experience' => 5,
            ]
        );
    }
}
