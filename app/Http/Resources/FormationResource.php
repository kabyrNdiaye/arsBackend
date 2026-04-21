<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class FormationResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'titre' => $this->titre,
            'duree' => $this->duree,
            'type' => $this->type,
            'video_url' => $this->video_url,
            'image_url' => $this->image_url,
            'statut' => $this->statutValidation,
        ];
    }
}
