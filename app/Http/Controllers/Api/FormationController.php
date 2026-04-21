<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Formation;
use Illuminate\Http\Request;

class FormationController extends Controller
{
    public function index()
    {
        return response()->json([
            'success' => true,
            'data' => Formation::latest()->get()
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'titre' => 'required|string|max:255',
            'type_formation' => 'required|string', // obligatoire ou recommandée
            'lien_formation' => 'nullable|string',
            'duree' => 'nullable|string',
            'video_url' => 'nullable|string',
            'image_url' => 'nullable|url',
            'professionnel_id' => 'nullable|exists:professionnels,id'
        ]);

        $formation = Formation::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Formation créée avec succès',
            'data' => $formation
        ], 201);
    }

    public function show(Formation $formation)
    {
        return response()->json([
            'success' => true,
            'data' => $formation
        ]);
    }

    public function update(Request $request, Formation $formation)
    {
        $formation->update($request->all());
        return response()->json([
            'success' => true,
            'message' => 'Formation mise à jour',
            'data' => $formation
        ]);
    }

    public function destroy(Formation $formation)
    {
        $formation->delete();
        return response()->json(['success' => true, 'message' => 'Formation supprimée']);
    }
}
