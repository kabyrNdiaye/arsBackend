<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mission extends Model
{
    use HasFactory;

    const STATUS_IN_PROGRESS = 'en cours';
    const STATUS_CONFIRMED = 'confirmé';
    const STATUS_REJECTED = 'refusé';
    const STATUS_FINISHED = 'terminé';

    protected $fillable = [
        'structure_id',
        'professionnel_id',
        'date',
        'duree',
        'statut',
        
        // Aligned fields
        'nb_residents_jour',
        'types_repas',
        'regimes_speciaux',
        'horaire_mission',
        'nb_regimes_haches',
        'nb_regimes_mixes',
        'nb_regimes_moulines',
        'nb_chefs',
        'est_cree_par_admin',
        
        // Quantities
        'quantite_viande',
        'quantite_riz',
        'quantite_legumes',

        // Checklists & Comments
        'checklist_journee',
        'checklist_items',
        'commentaires',
        'commentaires_admin',
        'horaire_fin',
        'code_entree',
        'code_cuisine'
    ];

    protected $casts = [
        'types_repas' => 'array',
        'regimes_speciaux' => 'array',
        'horaire_mission' => 'datetime',
        'horaire_fin' => 'datetime',
        'checklist_journee' => 'array',
        'checklist_items' => 'array',
    ];

    public function repas()
    {
        return $this->hasMany(MissionRepas::class);
    }

    public function messages()
    {
        return $this->hasMany(MissionMessage::class);
    }

    public function structure()
    {
        return $this->belongsTo(Structure::class);
    }

    public function professionnel()
    {
        return $this->belongsTo(Professionnel::class);
    }

    public function incidents()
    {
        return $this->hasMany(Incident::class);
    }

    public function retour()
    {
        return $this->hasOne(Retour::class);
    }

    public function recettes()
    {
        return $this->belongsToMany(Recette::class, 'mission_recette', 'mission_id', 'recette_id');
    }
}
