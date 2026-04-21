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

    /**
     * The "booted" method of the model.
     *
     * @return void
     */
    protected static function booted()
    {
        parent::booted();

        static::created(function ($message) {
            $content = (string)$message->content;

            \Illuminate\Support\Facades\Log::info("DEBUG: MissionMessage Created", [
                'id' => $message->id,
                'type' => $message->type,
                'content' => $content,
                'mission_id' => $message->mission_id
            ]);

            // Cas d'un incident
            if ($message->type === 'incident' || str_contains($content, '🚨 INCIDENT:')) {
                $incidentType = 'Autre';
                $description = $content;

                if (preg_match('/\[(.*?)\]/', $content, $matches)) {
                    $incidentType = $matches[1];
                    $description = trim(preg_replace('/.*🚨 INCIDENT: \[' . preg_quote($incidentType) . '\]\s*/u', '', $content));
                }

                \Illuminate\Support\Facades\Log::info("DEBUG: Creating Incident", [
                    'mission_id' => $message->mission_id,
                    'type' => $incidentType,
                    'description' => $description
                ]);

                try {
                    \App\Models\Incident::updateOrCreate(
                        ['mission_id' => $message->mission_id, 'description' => $description, 'type' => $incidentType],
                        ['gravite' => 'Moyenne', 'statut' => 'Signalé']
                    );
                    \Illuminate\Support\Facades\Log::info("DEBUG: Incident Created/Updated successfully");
                } catch (\Exception $e) {
                    \Illuminate\Support\Facades\Log::error("DEBUG: Error creating incident: " . $e->getMessage());
                }
            } 
            // Cas d'un retour (feedback)
            elseif ($message->type === 'feedback' || str_contains($content, '⭐ FEEDBACK:')) {
                $note = null;
                $commentaire = $content;

                if (preg_match('/\[Note:\s*(\d+(\.\d+)?)\/5\]/', $content, $matches)) {
                    $note = (float)$matches[1];
                    $commentaire = trim(preg_replace('/.*⭐ FEEDBACK: \[Note: \d+(\.\d+)?\/5\]\s*/u', '', $content));
                }

                \Illuminate\Support\Facades\Log::info("DEBUG: Creating Retour", [
                    'mission_id' => $message->mission_id,
                    'note' => $note,
                    'commentaire' => $commentaire
                ]);

                try {
                    \App\Models\Retour::updateOrCreate(
                        ['mission_id' => $message->mission_id, 'commentaire' => $commentaire],
                        ['note' => $note]
                    );
                    \Illuminate\Support\Facades\Log::info("DEBUG: Retour Created/Updated successfully");
                } catch (\Exception $e) {
                    \Illuminate\Support\Facades\Log::error("DEBUG: Error creating retour: " . $e->getMessage());
                }
            }
        });
    }

    public function mission()
    {
        return $this->belongsTo(Mission::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
