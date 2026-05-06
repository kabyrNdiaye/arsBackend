<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use App\Models\Retour;

class NewRetourNotification extends Notification
{
    use Queueable;

    protected $retour;

    public function __construct(Retour $retour)
    {
        $this->retour = $retour;
    }

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toArray(object $notifiable): array
    {
        return [
            'retour_id' => $this->retour->id,
            'mission_id' => $this->retour->mission_id,
            'title' => 'Nouveau retour de mission',
            'body' => "Un retour (Note: {$this->retour->note}/5) a été ajouté pour la mission #{$this->retour->mission_id}.",
            'type' => 'new_retour',
        ];
    }
}
