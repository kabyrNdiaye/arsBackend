<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $userData = parent::toArray($request);
        
        $profileData = [];

        if ($this->role === 'client' && $this->structure) {
            $profileData = $this->structure->toArray();
        } elseif ($this->role === 'professionnel' && $this->professionnel) {
            $profileData = $this->professionnel->toArray();
        }

        // Retirer les ID et timestamps du profil pour éviter les conflits
        unset($profileData['id'], $profileData['user_id'], $profileData['created_at'], $profileData['updated_at']);

        // Extraire les documents de la table polymorphe et les rajouter au profil
        $profile = ($this->role === 'client') ? $this->structure : $this->professionnel;
        
        $baseUrl = url('/');

        // 1. Charger les documents du USER lui-même (ex: pour les admins)
        foreach ($this->documents as $doc) {
            $profileData[$doc->nom] = $baseUrl . '/api/media/' . ltrim($doc->cheminFichier, '/');
        }

        // 2. Charger les documents du profil s'il existe
        if ($profile) {
            // Ajouter l'ID du profil explicitement 
            if ($this->role === 'client') {
                $profileData['structure_id'] = $profile->id;
            } else {
                $profileData['professionnel_id'] = $profile->id;
            }

            // Normaliser la photo de profil si elle existe
            if (isset($profileData['photo_profil_path']) && !empty($profileData['photo_profil_path'])) {
                $path = $profileData['photo_profil_path'];
                // Éviter de doubler le préfixe si déjà présent
                if (!str_contains($path, 'api/media')) {
                    $profileData['photo_profil_path'] = $baseUrl . '/api/media/' . ltrim($path, '/');
                }
            }

            // Charger les documents du profil
            foreach ($profile->documents as $doc) {
                // On utilise des URLs absolues pour éviter toute ambiguïté côté Flutter
                $profileData[$doc->nom] = $baseUrl . '/api/media/' . ltrim($doc->cheminFichier, '/');
            }

            // Ajouter la fonction principale (nouveau champ 'fonction' pour les pros)
            $fonctionPrincipale = '';
            if ($this->role === 'professionnel') {
                $fonctionPrincipale = $profile->fonction ?? '';
                
                // Ajouter la mission actuelle si chargée
                if ($profile->relationLoaded('missions')) {
                    $lastMission = $profile->missions->whereNotIn('statut', ['Terminée', 'Validée', 'Annulée'])->first();
                    if ($lastMission) {
                        $structure = $lastMission->structure;
                        $address = 'Adresse non renseignée';
                        if ($structure) {
                            $structUser = $structure->user;
                            $addr = $structure->adresse ?? ($structUser ? $structUser->adresse : '');
                            $cp = $structure->code_postal ?? ($structUser ? $structUser->code_postal : '');
                            $city = $structure->ville ?? ($structUser ? $structUser->ville : '');
                            $address = trim("$addr $cp $city");
                        }

                        $profileData['current_mission'] = [
                            'mission_id' => $lastMission->id,
                            'statut' => $lastMission->statut,
                            'structure_name' => $structure ? $structure->nom_etablissement : 'ARS',
                            'structure_address' => $address ?: 'Adresse non renseignée',
                        ];
                    }
                }
            } elseif ($this->role === 'client') {
                $fonctionPrincipale = $profile->fonction ?? '';
            }

            $profileData['fonction_principale'] = $fonctionPrincipale;

            // Ajouter les statistiques de missions
            if ($this->role === 'professionnel') {
                $profileData['stats'] = [
                    'total_missions' => $profile->missions()->count(),
                    'completed_missions' => $profile->missions()->whereIn('statut', ['Terminée', 'Validée', 'Payée'])->count(),
                    'pending_missions' => $profile->missions()->whereIn('statut', ['Demande envoyée', 'En attente', 'Assignée'])->count(),
                ];
            } elseif ($this->role === 'client') {
                $profileData['stats'] = [
                    'total_missions' => $profile->missions()->count(),
                    'active_missions' => $profile->missions()->whereIn('statut', ['Demande envoyée', 'Confirmée', 'En cours'])->count(),
                ];
            }
        }

        // Ensure address fields are correctly merged and prioritized
        // If it's a client, the profileData (Structure) might have address fields that should be preferred or merged
        return array_merge([
            'name' => "{$this->prenom} {$this->nom}",
        ], $userData, $profileData);
    }
}
