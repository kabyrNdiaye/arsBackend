<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MissionResponse extends Model
{
    use HasFactory;

    protected $fillable = [
        'mission_id',
        'professionnel_id',
        'status',
    ];

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }

    public function professionnel()
    {
        return $this->belongsTo(Professionnel::class);
    }
}
