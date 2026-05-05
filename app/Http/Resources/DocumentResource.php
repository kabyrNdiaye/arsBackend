<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DocumentResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $baseUrl = url('/');

        return [
            'id'        => $this->id,
            'nom'       => $this->nom,
            'type'      => $this->type,
            'url'       => $baseUrl . '/api/media/' . ltrim($this->cheminFichier, '/'),
            'chemin'    => $this->cheminFichier,
            'statut'    => $this->statut,
            'created_at'=> $this->created_at?->toDateTimeString(),
        ];
    }
}
