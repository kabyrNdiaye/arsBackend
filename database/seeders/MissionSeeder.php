<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class MissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $structure = \App\Models\Structure::first();
        $pro = \App\Models\Professionnel::first();
        
        if ($structure && $pro) {
            \App\Models\Mission::create([
                'structure_id' => $structure->id,
                'professionnel_id' => $pro->id,
                'date' => now()->addDays(2),
                'duree' => '4h',
                'statut' => 'Demande envoyée',
                'nb_residents_jour' => 45,
                'menu_entree_brut' => 'Salade César',
                'menu_plat_brut' => 'Poulet Rôti',
                'menu_accompagnement_brut' => 'Riz Pilaf',
                'menu_dessert_brut' => 'Tarte Tatin',
            ]);
        }
    }
}
