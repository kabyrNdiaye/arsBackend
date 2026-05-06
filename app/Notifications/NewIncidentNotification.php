<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use App\Models\Incident;

class NewIncidentNotification extends Notification
{
    use Queueable;

    protected $incident;

    public function __construct(Incident $incident)
    {
        $this->incident = $incident;
    }

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        return [
            'incident_id' => $this->incident->id,
            'mission_id' => $this->incident->mission_id,
            'title' => 'Nouvel incident signalé',
            'body' => "Un incident de priorité {$this->incident->gravite} a été signalé sur la mission #{$this->incident->mission_id}.",
            'type' => 'new_incident',
        ];
    }
}
