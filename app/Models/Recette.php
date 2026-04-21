<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recette extends Model
{
    use HasFactory;

    protected $fillable = [
        'nom',
        'type',
        'description',
        'ingredients',
        'temps_preparation',
        'regimes',
        'textures',
        'meal_types',
        'nb_regimes_haches',
        'nb_regimes_mixes',
        'nb_regimes_moulines'
    ];

    protected $casts = [
        'regimes' => 'array',
        'textures' => 'array',
        'meal_types' => 'array',
        'ingredients' => 'array'
    ];
}
