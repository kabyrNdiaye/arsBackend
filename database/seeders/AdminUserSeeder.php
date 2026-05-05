<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AdminUserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Vérifier si l'admin existe déjà
        $admin = User::firstOrCreate(
            ['email' => 'smknd2002@gmail.com'],
            [
                'prenom' => 'Super',
                'nom' => 'Admin',
                'password' => Hash::make('Passer1234'),
                'role' => 'admin',
                'telephone' => '0000000000',
                'email_verified_at' => now(),
            ]
        );

        // Au cas où le compte existe déjà (créé par erreur via l'appli en client standard), on force le rôle Admin
        $admin->update([
            'role' => 'admin',
            'password' => Hash::make('Passer1234'),
        ]);

        $this->command->info('Compte Admin mis à jour : smknd2002@gmail.com');
    }
}
