<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class MetadataController extends Controller
{
    /**
     * Retourne les options pour le formulaire d'inscription et de mission.
     */
    public function getRegistrationMetadata()
    {
        return response()->json([
            'success' => true,
            'data' => [
                'types_etablissement' => [
                    'EHPAD',
                    'Clinique',
                    'Hôpital',
                    'Résidence Autonomie',
                    'Autre'
                ],
                'repas_options' => [
                    'Petit-déjeuner',
                    'Déjeuner',
                    'Goûter',
                    'Dîner'
                ],
                'regimes_options' => [
                    'Textures modifiées',
                    'Sans sel',
                    'Diabétique',
                    'Sans gluten',
                    'Végétarien'
                ],
                'specialites_professionnel' => [
                    'Cuisine',
                    'Service',
                    'Plonge',
                    'Entretien'
                ],
                'niveaux_texture' => [
                    'Haché',
                    'Mixé',
                    'Mouliné'
                ]
            ]
        ]);
    }
}
