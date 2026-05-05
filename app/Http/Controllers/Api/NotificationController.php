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
        $notifications = $request->user()->notifications()->latest()->take(50)->get();
        return NotificationResource::collection($notifications);
    }

    /**
     * Mark all notifications as read
     */
    public function markAllAsRead(Request $request)
    {
        $request->user()->unreadNotifications->markAsRead();
        return response()->json(['success' => true, 'message' => 'Notifications marquées comme lues']);
    }

    /**
     * Mark a specific notification as read
     */
    public function markAsRead(Request $request, $id)
    {
        $notification = $request->user()->notifications()->where('id', $id)->first();
        if ($notification) {
            $notification->markAsRead();
            return response()->json(['success' => true, 'message' => 'Notification marquée comme lue']);
        }
        return response()->json(['success' => false, 'message' => 'Notification introuvable'], 404);
    }
}
