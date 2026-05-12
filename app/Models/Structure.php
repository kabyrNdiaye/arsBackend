<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Structure extends Model
{
    protected $fillable = [
        'user_id',
        'nom_etablissement',
        'telephone_etablissement',
        'type_etablissement',
        'capacite',
        'fonction',
        'statut_validation',
        'adresse',
        'code_postal',
        'ville',
        'contrat_prestation_path',
        'plan_locaux_path',
        'reglement_interieur_path',
    ];

    protected $casts = [
        //
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function documents()
    {
        return $this->morphMany(Document::class, 'documentable');
    }

    public function missions()
    {
        return $this->hasMany(Mission::class);
    }
}
