<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MissionCancellation extends Model
{
    protected $fillable = ['mission_id', 'professionnel_nom', 'motif', 'is_late', 'mission_nom'];

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }
}
