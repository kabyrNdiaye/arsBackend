<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Incident extends Model
{
    protected $fillable = [
        'mission_id',
        'type',
        'description',
        'gravite',
        'statut'
    ];

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }
}
