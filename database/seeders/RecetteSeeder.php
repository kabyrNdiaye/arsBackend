<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Recette;

class RecetteSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $recettes = [
            // --- ENTRÉES ---
            [
                'nom' => 'Velouté de Potiron et Châtaignes',
                'type' => 'entree',
                'description' => 'Un classique d\'automne, onctueux et réconfortant.',
                'ingredients' => 'Potiron, Châtaignes, Crème fraîche, Oignon, Bouillon de légumes.',
                'temps_preparation' => '45 min',
                'regimes' => ['Végétarien', 'Sans gluten', 'Diabétique'],
                'textures' => ['Mixé', 'Mouliné'],
            ],
            [
                'nom' => 'Salade de Betteraves au Chèvre Frais',
                'type' => 'entree',
                'description' => 'Fraîcheur des betteraves et douceur du fromage.',
                'ingredients' => 'Betteraves, Fromage de chèvre, Noix, Vinaigrette.',
                'temps_preparation' => '15 min',
                'regimes' => ['Végétarien', 'Sans gluten'],
                'textures' => ['Haché', 'Normal'],
            ],
            [
                'nom' => 'Œufs Cocotte à la Crème',
                'type' => 'entree',
                'description' => 'Œufs cuits au four avec de la crème et de la ciboulette.',
                'ingredients' => 'Œufs, Crème liquide, Ciboulette, Sel, Poivre.',
                'temps_preparation' => '10 min',
                'regimes' => ['Végétarien', 'Sans gluten'],
                'textures' => ['Normal'],
            ],

            // --- PLATS ---
            [
                'nom' => 'Blanquette de Veau à l\'ancienne',
                'type' => 'plat',
                'description' => 'Veau mijoté dans une sauce blanche crémeuse avec carottes et champignons.',
                'ingredients' => 'Épaule de veau, Carottes, Poireaux, Champignons, Crème, Œuf.',
                'temps_preparation' => '1h 30 min',
                'regimes' => ['Standard'],
                'textures' => ['Normal', 'Haché'],
            ],
            [
                'nom' => 'Filet de Cabillaud Vapeur',
                'type' => 'plat',
                'description' => 'Poisson blanc léger cuit à la vapeur.',
                'ingredients' => 'Cabillaud, Citron, Huile d\'olive.',
                'temps_preparation' => '20 min',
                'regimes' => ['Sans sel', 'Léger', 'Diabétique'],
                'textures' => ['Normal', 'Haché', 'Mixé'],
            ],
            [
                'nom' => 'Poulet Rôti aux Herbes de Provence',
                'type' => 'plat',
                'description' => 'Poulet juteux parfumé aux herbes.',
                'ingredients' => 'Poulet, Romarin, Thym, Ail, Huile d\'olive.',
                'temps_preparation' => '1h 15 min',
                'regimes' => ['Standard', 'Sans gluten'],
                'textures' => ['Normal', 'Haché'],
            ],

            // --- ACCOMPAGNEMENTS ---
            [
                'nom' => 'Purée de Pommes de Terre Mousseline',
                'type' => 'accompagnement',
                'description' => 'Purée de pommes de terre onctueuse et sans grumeaux.',
                'ingredients' => 'Pommes de terre, Lait, Beurre, Sel.',
                'temps_preparation' => '30 min',
                'regimes' => ['Végétarien', 'Sans gluten'],
                'textures' => ['Mouliné', 'Mixé'],
            ],
            [
                'nom' => 'Riz de Camargue à la Vapeur',
                'type' => 'accompagnement',
                'description' => 'Riz blanc parfaitement cuit.',
                'ingredients' => 'Riz, Eau, Sel.',
                'temps_preparation' => '15 min',
                'regimes' => ['Végétalien', 'Sans gluten', 'Sans sel'],
                'textures' => ['Normal', 'Mixé'],
            ],
            [
                'nom' => 'Gratin Dauphinois traditionnel',
                'type' => 'accompagnement',
                'description' => 'Pommes de terre fondantes à la crème.',
                'ingredients' => 'Pommes de terre, Crème, Lait, Ail, Muscade.',
                'temps_preparation' => '1h 00 min',
                'regimes' => ['Végétarien', 'Sans gluten'],
                'textures' => ['Normal', 'Mouliné'],
            ],

            // --- DESSERTS ---
            [
                'nom' => 'Mousse au Chocolat Légère',
                'type' => 'dessert',
                'description' => 'Dessert aérien au chocolat noir 70%.',
                'ingredients' => 'Chocolat noir, Œufs, une pincée de sel.',
                'temps_preparation' => '20 min (+ 4h repos)',
                'regimes' => ['Standard', 'Végétarien'],
                'textures' => ['Mixé'],
            ],
            [
                'nom' => 'Compote de Pommes et Vanille',
                'type' => 'dessert',
                'description' => 'Pommes fondantes parfumées à la vanille Bourbon.',
                'ingredients' => 'Pommes, Sucre vanillé, Bâton de vanille.',
                'temps_preparation' => '25 min',
                'regimes' => ['Sans sel', 'Végétalien', 'Sans gluten'],
                'textures' => ['Mixé', 'Mouliné'],
            ],
            [
                'nom' => 'Île Flottante Onctueuse',
                'type' => 'dessert',
                'description' => 'Blancs d\'œufs en neige sur crème anglaise.',
                'ingredients' => 'Œufs, Lait, Sucre, Vanille.',
                'temps_preparation' => '30 min',
                'regimes' => ['Végétarien', 'Sans gluten'],
                'textures' => ['Normal', 'Mixé'],
            ],
        ];

        foreach ($recettes as $recette) {
            Recette::create($recette);
        }
    }
}
