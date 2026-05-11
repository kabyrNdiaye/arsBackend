<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class DocumentController extends Controller
{
    /**
     * Retourne tous les documents du profil connecté,
     * en distinguant les documents fixes (diplome, certificat, permis)
     * des documents supplémentaires ajoutés par l'utilisateur.
     */
    public function myDocuments(Request $request)
    {
        $user    = $request->user();
        $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;

        if (!$profile) {
            return response()->json(['success' => false, 'message' => 'Profil non trouvé'], 404);
        }

        $baseUrl  = url('/');
        $fixedKeys   = ['diplome_path', 'certificat_medical_path', 'permis_conduire_path'];
        $excludeKeys = ['photo_profil_path']; // jamais dans la liste des documents
        $allDocs     = $profile->documents()->orderBy('created_at', 'asc')->get();

        $fixed = [];
        $extra = [];

        foreach ($allDocs as $doc) {
            $item = [
                'id'         => $doc->id,
                'nom'        => $doc->nom,
                'type'       => $doc->type,
                'url'        => $baseUrl . '/api/media/' . ltrim($doc->cheminFichier, '/'),
                'statut'     => $doc->statut,
                'created_at' => $doc->created_at?->toDateTimeString(),
            ];

            if (in_array($doc->nom, $fixedKeys)) {
                $fixed[$doc->nom] = $item;
            } else {
                $extra[] = $item;
            }
        }

        return response()->json([
            'success' => true,
            'fixed'   => $fixed,  // diplome_path, certificat_medical_path, permis_conduire_path
            'extra'   => $extra,  // documents ajoutés après l'inscription
            'all'     => array_values(array_merge(array_values($fixed), $extra)),
        ]);
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $user = $request->user();

        if ($user->role === 'admin') {
            return \App\Http\Resources\DocumentResource::collection(\App\Models\Document::orderBy('created_at', 'desc')->get());
        }

        $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;
        
        if (!$profile) {
            return \App\Http\Resources\DocumentResource::collection(collect());
        }

        return \App\Http\Resources\DocumentResource::collection($profile->documents()->orderBy('created_at', 'desc')->get());
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'nom' => 'required|string',
            'document' => 'required|file|mimes:pdf,doc,docx,jpg,jpeg,png|max:10240',
            'type' => 'nullable|string',
        ]);

        $user = $request->user();
        $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;

        if (!$profile) {
            return response()->json(['message' => 'Profil non trouvé'], 404);
        }

        $file = $request->file('document');
        $originalName = $file->getClientOriginalName();
        $folder = $user->role === 'professionnel' ? 'documents/professionnels' : 'documents/clients';
        $ext = $file->getClientOriginalExtension();
        $filename = Str::uuid() . '.' . $ext;
        $path = $file->storeAs($folder, $filename, 'public');

        $document = $profile->documents()->create([
            'nom' => $originalName, // Utiliser le nom original du fichier
            'type' => $validated['type'] ?? 'document',
            'cheminFichier' => $path,
            'statut' => 'actif'
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Document ajouté avec succès',
            'document' => new \App\Http\Resources\DocumentResource($document)
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, \App\Models\Document $document)
    {
        $user = $request->user();

        // Autorisatiion : Admin ou Propriétaire
        if ($user->role !== 'admin') {
            $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;
            if (!$profile || $document->documentable_id !== $profile->id || $document->documentable_type !== get_class($profile)) {
                abort(403, 'Vous n\'êtes pas autorisé à accéder à ce document.');
            }
        }

        return new \App\Http\Resources\DocumentResource($document);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, \App\Models\Document $document)
    {
        $user = $request->user();

        // Autorisation : Admin ou Propriétaire
        if ($user->role !== 'admin') {
            $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;
            if (!$profile || $document->documentable_id !== $profile->id || $document->documentable_type !== get_class($profile)) {
                abort(403, 'Vous n\'êtes pas autorisé à modifier ce document.');
            }
        }

        $validated = $request->validate([
            'nom'      => 'nullable|string',
            'type'     => 'nullable|string',
            'statut'   => 'nullable|string',
            'document' => 'nullable|file|mimes:pdf,doc,docx,jpg,jpeg,png|max:10240',
        ]);

        // Remplacement du fichier si un nouveau est envoyé
        if ($request->hasFile('document') && $request->file('document')->isValid()) {
            // Supprimer l'ancien fichier physique
            Storage::disk('public')->delete($document->cheminFichier);
            Storage::disk('local')->delete($document->cheminFichier);

            $file     = $request->file('document');
            $ext      = $file->getClientOriginalExtension();
            $filename = Str::uuid() . '.' . $ext;
            $folder   = $user->role === 'professionnel' ? 'documents/professionnels' : 'documents/clients';
            $path     = $file->storeAs($folder, $filename, 'public');

            $document->cheminFichier = $path;
        }

        // Mise à jour des champs texte
        if (!empty($validated['nom']))    $document->nom    = $validated['nom'];
        if (!empty($validated['type']))   $document->type   = $validated['type'];
        if (!empty($validated['statut'])) $document->statut = $validated['statut'];

        $document->save();

        return response()->json([
            'success'  => true,
            'message'  => 'Document mis à jour',
            'document' => new \App\Http\Resources\DocumentResource($document)
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, \App\Models\Document $document)
    {
        $user = $request->user();

        // Autorisation : Admin ou Propriétaire
        if ($user->role !== 'admin') {
            $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;
            if (!$profile || $document->documentable_id !== $profile->id || $document->documentable_type !== get_class($profile)) {
                abort(403, 'Vous n\'êtes pas autorisé à supprimer ce document.');
            }
        }

        // Supprimer le fichier physiquement
        Storage::disk('public')->delete($document->cheminFichier);
        Storage::disk('local')->delete($document->cheminFichier);

        $document->delete();

        return response()->json([
            'success' => true,
            'message' => 'Document supprimé'
        ]);
    }
}
