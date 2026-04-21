<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class MissionMessageResource extends JsonResource
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
            'mission_id' => $this->mission_id,
            'type' => $this->type,
            'content' => $this->content,
            'file_path' => $this->file_path ? asset('storage/' . $this->file_path) : null,
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
            'is_read' => $this->is_read,
            'is_handled' => (bool)$this->is_handled,
            'created_at' => $this->created_at,
            'user' => [
                'id' => $this->user->id,
                'name' => trim(($this->user->prenom ?? '') . ' ' . ($this->user->nom ?? '')) ?: $this->user->email,
                'role' => $this->user->role, 
            ]
        ];
    }
}
