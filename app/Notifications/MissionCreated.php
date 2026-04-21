<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use App\Models\Mission;

class MissionCreated extends Notification
{
    use Queueable;

    protected $mission;

    /**
     * Create a new notification instance.
     */
    public function __construct(Mission $mission)
    {
        $this->mission = $mission;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['database'];
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            'mission_id' => $this->mission->id,
            'title' => 'Nouvelle mission déposée',
            'body' => "Une nouvelle mission a été créée par {$this->mission->structure->nom_etablissement}.",
            'type' => 'new_mission',
        ];
    }
}
