<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Retour extends Model
{
    protected $fillable = [
        'mission_id',
        'note',
        'commentaire',
        'heureDebutEffectif',
        'heureFinEffectif'
    ];

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }
}
