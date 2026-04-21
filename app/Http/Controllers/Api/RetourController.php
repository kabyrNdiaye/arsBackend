<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Retour;
use Illuminate\Http\Request;

class RetourController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Retour::with('mission')->get();
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'mission_id' => 'required|exists:missions,id',
            'note' => 'required|integer|min:1|max:5',
            'commentaire' => 'required|string',
            'heureDebutEffectif' => 'required',
            'heureFinEffectif' => 'required',
        ]);

        $retour = Retour::create($validated);

        return response()->json([
            'message' => 'Retour créé avec succès',
            'data' => $retour
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
