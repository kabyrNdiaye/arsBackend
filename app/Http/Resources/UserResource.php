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
            $profileData = (array)$this->structure->toArray();
        } elseif ($this->role === 'professionnel' && $this->professionnel) {
            $profileData = (array)$this->professionnel->toArray();
        }

        // Retirer les ID et timestamps du profil pour éviter les conflits
        unset($profileData['id'], $profileData['user_id'], $profileData['created_at'], $profileData['updated_at']);

        // Extraire les documents de la table polymorphe et les rajouter au profil
        $profile = ($this->role === 'client') ? $this->structure : $this->professionnel;
        
        $baseUrl = rtrim(url('/'), '/');
        if (str_contains($baseUrl, 'onrender.com')) {
            $baseUrl = str_replace('http://', 'https://', $baseUrl);
        }

        // 1. Charger les documents du USER lui-même (ex: pour les admins)
        if ($this->relationLoaded('documents')) {
            foreach ($this->documents as $doc) {
                if ($doc->cheminFichier && $doc->nom) {
                    $profileData[$doc->nom] = $baseUrl . '/api/media/' . ltrim($doc->cheminFichier, '/');
                }
            }
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
            if (empty($profileData['photo_profil_path']) && $this->relationLoaded('documents')) {
                $userDoc = $this->documents->where('nom', 'photo_profil_path')->first();
                if ($userDoc) {
                    $profileData['photo_profil_path'] = $baseUrl . '/api/media/' . ltrim($userDoc->cheminFichier, '/');
                }
            }

            if (!empty($profileData['photo_profil_path'])) {
                $path = $profileData['photo_profil_path'];
                // Éviter de doubler le préfixe si déjà présent
                if (is_string($path) && !str_contains($path, 'api/media')) {
                    $profileData['photo_profil_path'] = $baseUrl . '/api/media/' . ltrim($path, '/');
                }
            }

            // Charger les documents du profil
            if ($profile->relationLoaded('documents') || $profile->documents()->exists()) {
                foreach ($profile->documents as $doc) {
                    if ($doc->cheminFichier && $doc->nom) {
                        $profileData[$doc->nom] = $baseUrl . '/api/media/' . ltrim($doc->cheminFichier, '/');
                    }
                }
            }

            // Exposer TOUS les documents du profil dans un tableau structuré
            $profileData['documents'] = $profile->documents->filter(function ($doc) {
                return !empty($doc->cheminFichier);
            })->map(function ($doc) use ($baseUrl) {
                return [
                    'id'       => $doc->id,
                    'nom'      => $doc->nom,
                    'type'     => $doc->type,
                    'url'      => $baseUrl . '/api/media/' . ltrim($doc->cheminFichier, '/'),
                    'statut'   => $doc->statut,
                ];
            })->values()->toArray();

            // Ajouter la fonction principale
            $fonctionPrincipale = $profile->fonction ?? '';
            if ($this->role === 'professionnel') {
                // Ajouter la mission actuelle
                $lastMission = $profile->missions()->whereNotIn('statut', ['terminé', 'Terminé', 'terminée', 'Terminée', 'Validée', 'Annulée'])->first();
                if ($lastMission) {
                    $structure = $lastMission->structure;
                    $address = '';
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

            $profileData['fonction_principale'] = $fonctionPrincipale;

            // Ajouter les statistiques de missions
            if ($this->role === 'professionnel') {
                $profileData['stats'] = [
                    'total_missions' => $profile->missions()->count(),
                    'completed_missions' => $profile->missions()->whereIn('statut', ['terminé', 'Terminé', 'terminée', 'Terminée', 'Validée', 'Payée'])->count(),
                    'pending_missions' => $profile->missions()->whereIn('statut', ['en cours', 'En cours', 'confirmé', 'Confirmé', 'confirmée', 'Confirmée', 'Demande envoyée', 'En attente', 'Assignée'])->count(),
                ];
            } elseif ($this->role === 'client') {
                $profileData['stats'] = [
                    'total_missions' => $profile->missions()->count(),
                    'active_missions' => $profile->missions()->whereIn('statut', ['Demande envoyée', 'Confirmée', 'En cours', 'En attente'])->count(),
                ];
            }
        }

        // Correction des champs d'adresse
        $overlappingFields = ['adresse', 'code_postal', 'ville', 'telephone'];
        foreach ($overlappingFields as $field) {
            if (array_key_exists($field, $profileData) && is_null($profileData[$field])) {
                unset($profileData[$field]);
            }
        }

        $result = array_merge((array)$userData, (array)$profileData, [
            'prenom' => $this->prenom,
            'nom' => $this->nom,
            'name' => "{$this->prenom} {$this->nom}",
            'debug_https_fix' => 'active_v3_nuclear',
        ]);

        // Forcer le HTTPS pour toutes les URLs Render
        array_walk_recursive($result, function (&$item) {
            if (is_string($item) && str_contains($item, 'onrender.com')) {
                $item = str_replace('http://', 'https://', $item);
            }
        });

        return $result;
    }
}
