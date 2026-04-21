<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MissionRepas extends Model
{
    use HasFactory;

    protected $table = 'mission_repas';

    protected $fillable = [
        'mission_id',
        'type_repas',
        'entree',
        'plat',
        'accompagnement',
        'dessert',
        'description_simple',
        'entree_recette_id',
        'plat_recette_id',
        'accompagnement_recette_id',
        'dessert_recette_id',
        'simple_recette_id'
    ];

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }

    public function entreeRecette() { return $this->belongsTo(Recette::class, 'entree_recette_id'); }
    public function platRecette() { return $this->belongsTo(Recette::class, 'plat_recette_id'); }
    public function accompagnementRecette() { return $this->belongsTo(Recette::class, 'accompagnement_recette_id'); }
    public function dessertRecette() { return $this->belongsTo(Recette::class, 'dessert_recette_id'); }
    public function simpleRecette() { return $this->belongsTo(Recette::class, 'simple_recette_id'); }

    /**
     * Get all recipes associated with this meal, categorized by the pivot 'category' field.
     */
    public function recettes()
    {
        return $this->belongsToMany(Recette::class, 'mission_repas_recettes', 'mission_repas_id', 'recette_id')
                    ->withPivot('category')
                    ->withTimestamps();
    }
}
