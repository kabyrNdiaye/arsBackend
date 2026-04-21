<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class DocumentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return \App\Http\Resources\DocumentResource::collection(\App\Models\Document::all());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'documentable_id' => 'required|integer',
            'documentable_type' => 'required|string',
            'nom' => 'required|string',
            'type' => 'required|string',
            'cheminFichier' => 'required|string',
            'statut' => 'nullable|string',
        ]);

        $document = \App\Models\Document::create($validated);

        return response()->json($document, 201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        return \App\Models\Document::findOrFail($id);
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
