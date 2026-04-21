<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Document extends Model
{
    protected $fillable = [
        'documentable_type',
        'documentable_id',
        'nom',
        'type',
        'cheminFichier',
        'statut'
    ];

    public function documentable()
    {
        return $this->morphTo();
    }
}
