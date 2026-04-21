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
        if (!User::where('email', 'admin@ars.com')->exists()) {
            User::create([
                'prenom' => 'Super',
                'nom' => 'Admin',
                'email' => 'admin@ars.com',
                'password' => Hash::make('Ars@1234'),
                'role' => 'admin',
                'telephone' => '0000000000',
                'email_verified_at' => now(),
            ]);
            $this->command->info('Compte Admin créé : admin@ars.com');
        } else {
            $this->command->info('Le compte Admin existe déjà.');
        }
    }
}
