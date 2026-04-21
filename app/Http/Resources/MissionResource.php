<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MissionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'statut' => $this->statut,
            'user_status' => $this->user_status ?? ($this->professionnel_id && $request->user() && $request->user()->professionnel && $this->professionnel_id == $request->user()->professionnel->id ? 'confirmé' : null),
            'professionnel_id' => $this->professionnel_id,
            'nb_residents_jour' => $this->nb_residents_jour,
            'nb_chefs' => $this->nb_chefs,
            'types_repas' => $this->types_repas,
            'regimes_speciaux' => $this->regimes_speciaux,
            
            // Menu à plat (Flat)
            'menu_entree_brut' => $this->menu_entree_brut,
            'menu_plat_brut' => $this->menu_plat_brut,
            'menu_accompagnement_brut' => $this->menu_accompagnement_brut,
            'menu_dessert_brut' => $this->menu_dessert_brut,
            
            'horaire_mission' => $this->horaire_mission ? $this->horaire_mission->format('Y-m-d H:i') : null,
            'date_mission' => $this->horaire_mission ? $this->horaire_mission->format('Y-m-d') : null,
            'heure_mission' => $this->horaire_mission ? $this->horaire_mission->format('H:i') : null,
            
            'horaire_fin' => $this->horaire_fin ? $this->horaire_fin->format('Y-m-d H:i') : null,
            'date_fin' => $this->horaire_fin ? $this->horaire_fin->format('Y-m-d') : null,
            'heure_fin' => $this->horaire_fin ? $this->horaire_fin->format('H:i') : null,
            
            // Régimes spécifiques (Flat)
            'nb_regimes_haches' => $this->nb_regimes_haches,
            'nb_regimes_mixes' => $this->nb_regimes_mixes,
            'nb_regimes_moulines' => $this->nb_regimes_moulines,
            
            // Quantités (Flat)
            'quantite_viande' => $this->quantite_viande,
            'quantite_riz' => $this->quantite_riz,
            'quantite_legumes' => $this->quantite_legumes,
            
            'commentaires' => $this->commentaires,
            'commentaires_admin' => $this->commentaires_admin,
            'code_entree' => $this->code_entree,
            'code_cuisine' => $this->code_cuisine,
            'checklist_journee' => $this->checklist_journee,
            'checklist_items' => $this->checklist_items,
            'last_message' => new MissionMessageResource($this->messages()->latest()->first()),
            'unread_messages_count' => $this->messages()->where('is_read', false)->where('user_id', '!=', $request->user()->id)->count(),
            'est_cree_par_admin' => (bool)$this->est_cree_par_admin,
            'recettes' => $this->recettes, // Simple array of recipes
            'repas' => $this->repas->map(function($r) {
                $groupedRecettes = $r->recettes->groupBy(function($item) {
                    return $item->pivot->category;
                });

                return [
                    'id' => $r->id,
                    'type_repas' => $r->type_repas,
                    'entree' => $r->entree,
                    'plat' => $r->plat,
                    'accompagnement' => $r->accompagnement,
                    'dessert' => $r->dessert,
                    'description_simple' => $r->description_simple,
                    
                    // Multiple recipes collections
                    'entree_recettes' => $groupedRecettes->get('entree', []),
                    'plat_recettes' => $groupedRecettes->get('plat', []),
                    'accompagnement_recettes' => $groupedRecettes->get('accompagnement', []),
                    'dessert_recettes' => $groupedRecettes->get('dessert', []),
                    'simple_recettes' => $groupedRecettes->get('simple', []),

                    // Backward compatibility (singular)
                    'entree_recette' => $r->entreeRecette,
                    'plat_recette' => $r->platRecette,
                    'accompagnement_recette' => $r->accompagnementRecette,
                    'dessert_recette' => $r->dessertRecette,
                    'simple_recette' => $r->simpleRecette,
                ];
            }),
            
            // Relations
            'structure' => new \App\Http\Resources\UserResource($this->whenLoaded('structure', function() {
                return $this->structure->user;
            })),
            'professionnel' => new \App\Http\Resources\UserResource($this->whenLoaded('professionnel', function() {
                return $this->professionnel->user;
            })),
            'incidents' => $this->whenLoaded('incidents'),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
