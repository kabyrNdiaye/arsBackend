<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\NotificationResource;

class NotificationController extends Controller
{
    /**
     * Get unread notifications for the user
     */
    public function index(Request $request)
    {
        $notifications = $request->user()->unreadNotifications()->latest()->take(50)->get();
        return NotificationResource::collection($notifications);
    }

    /**
     * Mark all notifications as read
     */
    public function markAllAsRead(Request $request)
    {
        $notifications = $request->user()->unreadNotifications()->get();
        foreach ($notifications as $notification) {
            if (isset($notification->data['type']) && $notification->data['type'] === 'new_user') {
                continue; // On ne permet pas de marquer globalement comme lues les inscriptions en attente
            }
            $notification->markAsRead();
        }
        
        return response()->json(['success' => true, 'message' => 'Notifications marquées comme lues']);
    }

    /**
     * Mark a specific notification as read
     */
    public function markAsRead(Request $request, $id)
    {
        $notification = $request->user()->notifications()->where('id', $id)->first();
        if ($notification) {
            if (isset($notification->data['type']) && $notification->data['type'] === 'new_user') {
                return response()->json(['success' => false, 'message' => 'Cette notification sera masquée automatiquement lors de la validation ou du refus.'], 403);
            }
            $notification->markAsRead();
            return response()->json(['success' => true, 'message' => 'Notification marquée comme lue']);
        }
        return response()->json(['success' => false, 'message' => 'Notification introuvable'], 404);
    }
}
