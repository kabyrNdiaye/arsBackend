<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Mission;
use App\Models\MissionMessage;
use Illuminate\Http\Request;
use App\Http\Resources\MissionMessageResource;
use Illuminate\Support\Facades\Log;

class ChatController extends Controller
{
    public function index(Mission $mission)
    {
        $messages = $mission->messages()->with('user')->orderBy('created_at', 'asc')->get();
        return MissionMessageResource::collection($messages);
    }

    public function store(Request $request, Mission $mission)
    {
        $request->validate([
            'content'   => 'nullable|string',
            'type'      => 'required|in:text,image,file,location,contact,audio,incident,feedback',
            'file'      => 'nullable|file|max:10240',
            'latitude'  => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
        ]);

        $filePath = null;
        if ($request->hasFile('file')) {
            $filePath = $request->file('file')->store('mission_attachments/' . $mission->id, 'public');
        }

        $message = $mission->messages()->create([
            'user_id'   => $request->user()->id,
            'type'      => $request->type,
            'content'   => $request->content,
            'file_path' => $filePath,
            'latitude'  => $request->latitude,
            'longitude' => $request->longitude,
        ]);

        // --- Persistance explicite des incidents et retours ---
        $content = (string)($request->content ?? '');
        $type    = $request->type;

        // Cas INCIDENT
        if ($type === 'incident' || str_contains($content, '🚨 INCIDENT:')) {
            $incidentType = 'Autre';
            $description  = $content;

            if (preg_match('/\[([^\]]+)\]/', $content, $matches)) {
                $incidentType = $matches[1];
                $description  = trim(preg_replace(
                    '/.*🚨 INCIDENT: \[' . preg_quote($incidentType, '/') . '\]\s*/u',
                    '',
                    $content
                ));
            }

            try {
                \App\Models\Incident::create([
                    'mission_id'  => $mission->id,
                    'type'        => $incidentType,
                    'description' => $description ?: $content,
                    'gravite'     => 'Moyenne',
                    'statut'      => 'Signalé',
                ]);
                Log::info('ChatController: Incident créé avec succès', [
                    'mission_id' => $mission->id,
                    'type'       => $incidentType,
                ]);
            } catch (\Exception $e) {
                Log::error('ChatController: Erreur lors de la création de l\'incident: ' . $e->getMessage(), [
                    'mission_id' => $mission->id,
                    'content'    => $content,
                ]);
            }

        // Cas FEEDBACK
        } elseif ($type === 'feedback' || str_contains($content, '⭐ FEEDBACK:')) {
            $note        = null;
            $commentaire = $content;

            if (preg_match('/\[Note:\s*(\d+(\.\d+)?)\/5\]/', $content, $matches)) {
                $note        = (float)$matches[1];
                $commentaire = trim(preg_replace(
                    '/.*⭐ FEEDBACK: \[Note: \d+(\.\d+)?\/5\]\s*/u',
                    '',
                    $content
                ));
            }

            try {
                \App\Models\Retour::create([
                    'mission_id'  => $mission->id,
                    'note'        => $note,
                    'commentaire' => $commentaire ?: $content,
                ]);
                Log::info('ChatController: Retour créé avec succès', [
                    'mission_id' => $mission->id,
                    'note'       => $note,
                ]);
            } catch (\Exception $e) {
                Log::error('ChatController: Erreur lors de la création du retour: ' . $e->getMessage(), [
                    'mission_id' => $mission->id,
                    'content'    => $content,
                ]);
            }
        }

        return (new MissionMessageResource($message->load('user')))
            ->response()
            ->setStatusCode(201);
    }

    public function markAsRead(Request $request, Mission $mission)
    {
        $mission->messages()
            ->where('user_id', '!=', $request->user()->id)
            ->where('is_read', false)
            ->update(['is_read' => true]);

        return response()->json([
            'success' => true,
            'message' => 'Messages marqués comme lus',
        ]);
    }

    public function markAsHandled(Request $request, MissionMessage $message)
    {
        $message->update(['is_handled' => true]);

        return response()->json([
            'success' => true,
            'message' => 'Message marqué comme traité',
            'data' => $message
        ]);
    }
}
