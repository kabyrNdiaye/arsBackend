<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Incident;
use Illuminate\Http\Request;

class IncidentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $user = $request->user();
        $query = Incident::with(['mission.structure.user', 'mission.professionnel.user']);

        // Filtrage par rôle
        if ($user->role === 'client' && $user->structure) {
            $query->whereHas('mission', function($q) use ($user) {
                $q->where('structure_id', $user->structure->id);
            });
        } elseif ($user->role === 'professionnel' && $user->professionnel) {
            $query->whereHas('mission', function($q) use ($user) {
                $q->where('professionnel_id', $user->professionnel->id);
            });
        }
        // Les admins voient tout

        return $query->orderBy('created_at', 'desc')->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'mission_id' => 'required|exists:missions,id',
            'type' => 'required|string',
            'description' => 'required|string',
            'gravite' => 'required|string',
            'statut' => 'required|string',
        ]);

        $user = $request->user();
        $mission = \App\Models\Mission::findOrFail($validated['mission_id']);

        // Vérification d'appartenance
        if ($user->role !== 'admin') {
            $isPro = $user->professionnel && 
                     $mission->professionnel_id === $user->professionnel->id;
            $isClient = $user->structure && 
                        $mission->structure_id === $user->structure->id;
            if (!$isPro && !$isClient) {
                abort(403, 'Vous n\'êtes pas lié à cette mission.');
            }
        }

        $incident = Incident::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Incident créé avec succès',
            'data' => $incident->load('mission')
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, Incident $incident)
    {
        $user = $request->user();
        $incident->load(['mission.structure', 'mission.professionnel']);

        // Vérification des droits d'accès (IDOR protection)
        if ($user->role === 'client' && $user->structure) {
            if ($incident->mission->structure_id !== $user->structure->id) {
                abort(403, 'Cet incident ne concerne pas votre structure.');
            }
        } elseif ($user->role === 'professionnel' && $user->professionnel) {
            if ($incident->mission->professionnel_id !== $user->professionnel->id) {
                abort(403, 'Vous n\'êtes pas autorisé à voir cet incident.');
            }
        }

        return response()->json([
            'success' => true,
            'data' => $incident
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Incident $incident)
    {
        $user = $request->user();
        $incident->load('mission');

        // Seul l'admin ou le professionnel assigné à la mission peut modifier l'incident
        if ($user->role !== 'admin') {
            if (!$user->professionnel || $incident->mission->professionnel_id !== $user->professionnel->id) {
                abort(403, 'Vous n\'êtes pas autorisé à modifier cet incident.');
            }
        }

        $validated = $request->validate([
            'type' => 'nullable|string',
            'description' => 'nullable|string',
            'gravite' => 'nullable|string',
            'statut' => 'nullable|string',
        ]);

        $incident->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Incident mis à jour avec succès',
            'data' => $incident
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, Incident $incident)
    {
        $user = $request->user();
        $incident->load('mission');

        // Seul l'admin ou le professionnel assigné peut supprimer
        if ($user->role !== 'admin') {
            if (!$user->professionnel || $incident->mission->professionnel_id !== $user->professionnel->id) {
                abort(403, 'Vous n\'êtes pas autorisé à supprimer cet incident.');
            }
        }

        $incident->delete();

        return response()->json([
            'success' => true,
            'message' => 'Incident supprimé'
        ]);
    }
}
