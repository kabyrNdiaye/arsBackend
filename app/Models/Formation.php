<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Formation extends Model
{
    protected $fillable = [
        'professionnel_id',
        'titre',
        'duree',
        'type', // Mapping pour type_formation
        'type_formation', // Pour compatibilité directe avec la demande
        'video_url',
        'image_url',
        'lien_formation',
        'statutValidation',
        'dateLimite'
    ];
}
