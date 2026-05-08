<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use App\Models\User;

class NewUserRegistered extends Notification
{
    use Queueable;

    protected $newUser;

    /**
     * Create a new notification instance.
     */
    public function __construct(User $newUser)
    {
        $this->newUser = $newUser;
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
        $typeLabel = $this->newUser->role === 'professionnel' ? 'professionnel' : 'établissement';
        
        $nom = $this->newUser->prenom . ' ' . $this->newUser->nom;
        if ($this->newUser->role === 'client' && $this->newUser->structure) {
            $nom = $this->newUser->structure->nom_etablissement ?: $nom;
        }

        return [
            'user_id' => $this->newUser->id,
            'title' => 'Nouvelle inscription',
            'body' => "Un nouveau {$typeLabel} ({$nom}) a rejoint la plateforme.",
            'type' => 'new_user',
        ];
    }
}
