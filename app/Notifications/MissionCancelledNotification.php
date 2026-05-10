<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use App\Models\Mission;

class MissionCancelledNotification extends Notification
{
    use Queueable;

    protected $mission;
    protected $motif;
    protected $professionnelName;
    protected $isLate; // Annulation < 24h avant la mission

    public function __construct(Mission $mission, string $motif, string $professionnelName, bool $isLate)
    {
        $this->mission          = $mission;
        $this->motif            = $motif;
        $this->professionnelName = $professionnelName;
        $this->isLate           = $isLate;
    }

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        $urgenceTag = $this->isLate ? ' ⚠️ ANNULATION TARDIVE' : '';

        return [
            'mission_id'         => $this->mission->id,
            'mission_date'       => $this->mission->horaire_mission,
            'professionnel_name' => $this->professionnelName,
            'motif'              => $this->motif,
            'is_late'            => $this->isLate,
            'title'              => "Mission annulée{$urgenceTag}",
            'body'               => "{$this->professionnelName} a annulé la mission #{$this->mission->id}. Motif : {$this->motif}",
            'type'               => 'mission_cancelled',
        ];
    }
}
