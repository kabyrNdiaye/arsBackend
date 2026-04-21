<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Menu extends Model
{
    use HasFactory;

    protected $fillable = [
        'nom',
        'type',
        'description',
        'status',
        'diets',
        'created_by'
    ];

    protected $casts = [
        'diets' => 'array',
    ];

    /**
     * Les recettes associées à ce menu template.
     */
    public function recettes(): BelongsToMany
    {
        return $this->belongsToMany(Recette::class, 'menu_recettes')
            ->withPivot('category', 'order')
            ->withTimestamps();
    }

    /**
     * Le créateur du menu.
     */
    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
