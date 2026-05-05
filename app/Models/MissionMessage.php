<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MissionMessage extends Model
{
    use HasFactory;

    protected $fillable = [
        'mission_id',
        'user_id',
        'type',
        'content',
        'file_path',
        'latitude',
        'longitude',
        'is_read',
        'is_handled',
    ];

    protected $attributes = [
        'is_read' => false,
    ];

    protected $casts = [
        'is_read'    => 'boolean',
        'is_handled' => 'boolean',
    ];

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
