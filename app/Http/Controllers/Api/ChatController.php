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
    private function authorizeForMission(Request $request, Mission $mission): void
    {
        $user = $request->user();
        if ($user->role === 'admin') return;
        
        $isStructure = $user->structure && 
                       $mission->structure_id === $user->structure->id;
        $isPro = $user->professionnel && 
                 $mission->professionnel_id === $user->professionnel->id;
        
        if (!$isStructure && !$isPro) {
            abort(403, 'Accès refusé à cette mission.');
        }
    }

    public function index(Request $request, Mission $mission)
    {
        $this->authorizeForMission($request, $mission);
        $messages = $mission->messages()
            ->with('user')
            ->whereNotIn('type', ['incident', 'feedback'])
            ->orderBy('created_at', 'asc')
            ->get();
        return MissionMessageResource::collection($messages);
    }

    public function store(Request $request, Mission $mission)
    {
        $this->authorizeForMission($request, $mission);
        $request->validate([
            'content'   => 'nullable|string',
            'type'      => 'required|in:text,image,file,location,contact,audio',
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

        return (new MissionMessageResource($message->load('user')))
            ->response()
            ->setStatusCode(201);
    }

    public function markAsRead(Request $request, Mission $mission)
    {
        $this->authorizeForMission($request, $mission);
        
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

    public function structureIndex(Request $request, \App\Models\Structure $structure)
    {
        $user = $request->user();
        if ($user->role !== 'admin' && $user->structure?->id !== $structure->id) {
            abort(403);
        }

        $missionIds = $structure->missions()->pluck('id');
        $messages = MissionMessage::whereIn('mission_id', $missionIds)
            ->with('user')
            ->whereNotIn('type', ['incident', 'feedback'])
            ->orderBy('created_at', 'asc')
            ->get();
        return MissionMessageResource::collection($messages);
    }

    public function structureStore(Request $request, \App\Models\Structure $structure)
    {
        $user = $request->user();
        if ($user->role !== 'admin' && $user->structure?->id !== $structure->id) {
            abort(403, 'Accès refusé à cette structure.');
        }

        $request->validate([
            'content'   => 'nullable|string',
            'type'      => 'required|in:text,image,file,location,contact,audio',
            'file'      => 'nullable|file|max:10240',
            'latitude'  => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
        ]);

        $mission = $structure->missions()->latest('id')->first();
        if (!$mission) {
            return response()->json(['error' => 'Aucune mission trouvée pour cette structure'], 400);
        }

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

        return (new MissionMessageResource($message->load('user')))
            ->response()
            ->setStatusCode(201);
    }

    public function structureMarkAsRead(Request $request, \App\Models\Structure $structure)
    {
        $user = $request->user();
        if ($user->role !== 'admin' && $user->structure?->id !== $structure->id) {
            abort(403, 'Accès refusé à cette structure.');
        }

        $missionIds = $structure->missions()->pluck('id');
        MissionMessage::whereIn('mission_id', $missionIds)
            ->where('user_id', '!=', $request->user()->id)
            ->where('is_read', false)
            ->update(['is_read' => true]);

        return response()->json([
            'success' => true,
            'message' => 'Messages de la structure marqués comme lus',
        ]);
    }
}
