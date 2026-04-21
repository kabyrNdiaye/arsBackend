<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Professionnel extends Model
{
    protected $fillable = [
        'user_id',
        'date_naissance',
        'code_postal',
        'ville',
        'diplome',
        'fonction',
        'annees_experience',
        'specialites',
        'statut_validation',
    ];

    protected $casts = [
        'specialites' => 'array',
        'date_naissance' => 'date',
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
