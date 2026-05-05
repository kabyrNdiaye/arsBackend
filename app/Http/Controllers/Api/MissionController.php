<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Mission;
use App\Models\MissionResponse;
use App\Models\User;
use App\Notifications\MissionCreated;
use App\Notifications\MissionValidated;
use App\Http\Resources\MissionResource;
use Carbon\Carbon;


class MissionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $user = $request->user();
        $query = Mission::with(['structure.user', 'incidents', 'professionnel.user', 'recettes', 'repas.entreeRecette', 'repas.platRecette', 'repas.accompagnementRecette', 'repas.dessertRecette', 'repas.simpleRecette', 'repas.recettes']);

        // Si c'est une structure, on ne montre que ses missions
        if ($user->structure) {
            $query->where('structure_id', $user->structure->id);
        } 
        // Si c'est un professionnel, on montre ses missions ET les missions disponibles
        elseif ($user->professionnel) {
            $query->select('missions.*')->where(function($q) use ($user) {
                $q->where('missions.professionnel_id', $user->professionnel->id)
                  ->orWhere(function($subQ) {
                      $subQ->whereNull('missions.professionnel_id')
                           ->where('missions.statut', Mission::STATUS_CONFIRMED);
                  });
            });

            // On récupère la réponse individuelle pour chaque mission
            $query->addSelect(['user_status' => MissionResponse::select('status')
                ->whereColumn('mission_id', 'missions.id')
                ->where('professionnel_id', $user->professionnel->id)
                ->limit(1)
            ]);
        }

        $missions = $query->orderBy('created_at', 'desc')->get();
        return MissionResource::collection($missions);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'structure_id' => 'required|exists:structures,id',
            'est_cree_par_admin' => 'nullable|boolean',
            'nb_residents_jour' => 'nullable|integer',
            'types_repas' => 'nullable|array',
            'regimes_speciaux' => 'nullable|array',
            'nb_chefs' => 'nullable|integer',
            'date_mission' => 'required|date',
            'heure_mission' => 'required|string',
            'date_fin' => 'nullable|date',
            'heure_fin' => 'nullable|string',
            'nb_regimes_haches' => 'nullable|integer',
            'nb_regimes_mixes' => 'nullable|integer',
            'nb_regimes_moulines' => 'nullable|integer',
            'quantite_viande' => 'nullable|numeric',
            'quantite_riz' => 'nullable|numeric',
            'quantite_legumes' => 'nullable|numeric',
            'commentaires' => 'nullable|string',
            'code_entree' => 'nullable|string',
            'code_cuisine' => 'nullable|string',
            'repas' => 'nullable|array',
            'repas.*.type_repas' => 'required|string',
            'repas.*.entree' => 'nullable|string',
            'repas.*.plat' => 'nullable|string',
            'repas.*.accompagnement' => 'nullable|string',
            'repas.*.dessert' => 'nullable|string',
            'repas.*.description_simple' => 'nullable|string',
            'repas.*.entree_recette_id' => 'nullable|exists:recettes,id',
            'repas.*.plat_recette_id' => 'nullable|exists:recettes,id',
            'repas.*.accompagnement_recette_id' => 'nullable|exists:recettes,id',
            'repas.*.dessert_recette_id' => 'nullable|exists:recettes,id',
            'repas.*.simple_recette_id' => 'nullable|exists:recettes,id',
            'repas.*.entree_recette_ids' => 'nullable|array',
            'repas.*.plat_recette_ids' => 'nullable|array',
            'repas.*.accompagnement_recette_ids' => 'nullable|array',
            'repas.*.dessert_recette_ids' => 'nullable|array',
            'repas.*.simple_recette_ids' => 'nullable|array',
        ]);

        $user = $request->user();

        if ($user->role !== 'admin') {
            if (!$user->structure) {
                return response()->json([
                    'success' => false,
                    'message' => 'Seule une structure peut créer une mission.'
                ], 403);
            }
            // Forcer le structure_id de l'utilisateur connecté
            $validated['structure_id'] = $user->structure->id;
        }

        $dateMission = $validated['date_mission'];
        $heureMission = $validated['heure_mission'];
        $validated['horaire_mission'] = Carbon::parse("$dateMission $heureMission");
        $validated['date'] = $dateMission;

        if (isset($validated['date_fin']) && isset($validated['heure_fin'])) {
            $dateFin = $validated['date_fin'];
            $heureFin = $validated['heure_fin'];
            $validated['horaire_fin'] = Carbon::parse("$dateFin $heureFin");
        }

        // Nettoyage avant création de la mission
        $repasData = $validated['repas'] ?? [];
        unset($validated['date_mission'], $validated['heure_mission'], $validated['date_fin'], $validated['heure_fin'], $validated['repas']);

        $mission = Mission::create($validated);

        // Créer les enregistrements MissionRepas et lier les recettes
        foreach ($repasData as $repas) {
            $missionRepas = $mission->repas()->create($repas);

            // Gérer la sélection multiple (pivot)
            $categories = ['entree', 'plat', 'accompagnement', 'dessert', 'simple'];
            foreach ($categories as $cat) {
                $idsField = $cat . '_recette_ids';
                $idField = $cat . '_recette_id';

                // Si liste d'IDs fournie
                if (isset($repas[$idsField]) && is_array($repas[$idsField])) {
                    foreach ($repas[$idsField] as $recetteId) {
                        $missionRepas->recettes()->attach($recetteId, ['category' => $cat]);
                    }
                } 
                // Fallback sur l'ID unique si fourni (compatibilité ancienne version)
                elseif (isset($repas[$idField])) {
                    $missionRepas->recettes()->attach($repas[$idField], ['category' => $cat]);
                }
            }
        }

        // Notifier les administrateurs
        $admins = User::where('role', 'admin')->get();
        foreach ($admins as $admin) {
            $admin->notify(new MissionCreated($mission));
        }

        return response()->json([
            'success' => true,
            'message' => 'Votre demande de mission a bien été envoyée à l’administrateur. Vous ne pouvez plus la modifier.',
            'data' => new MissionResource($mission->load('repas.entreeRecette', 'repas.platRecette', 'repas.accompagnementRecette', 'repas.dessertRecette', 'repas.simpleRecette'))
        ], 201);
    }

    /**
     * Update a mission (blocked if already sent)
     */
    public function update(Request $request, Mission $mission)
    {
        $user = $request->user();

        // Seul l'admin peut modifier une mission
        if ($user->role !== 'admin') {
            abort(403, 'Seul l\'administrateur peut modifier une mission.');
        }

        $validated = $request->validate([
            'structure_id' => 'nullable|exists:structures,id',
            'nb_residents_jour' => 'nullable|integer',
            'types_repas' => 'nullable|array',
            'regimes_speciaux' => 'nullable|array',
            'nb_chefs' => 'nullable|integer',
            'horaire_mission' => 'nullable',
            'horaire_fin' => 'nullable',
            'heure_fin' => 'nullable|string',
            'nb_regimes_haches' => 'nullable|integer',
            'nb_regimes_mixes' => 'nullable|integer',
            'nb_regimes_moulines' => 'nullable|integer',
            'quantite_viande' => 'nullable|numeric',
            'quantite_riz' => 'nullable|numeric',
            'quantite_legumes' => 'nullable|numeric',
            'commentaires' => 'nullable|string',
            'commentaires_admin' => 'nullable|string',
            'code_entree' => 'nullable|string',
            'code_cuisine' => 'nullable|string',
            'repas' => 'nullable|array',
            'repas.*.type_repas' => 'required|string',
            'repas.*.entree' => 'nullable|string',
            'repas.*.plat' => 'nullable|string',
            'repas.*.accompagnement' => 'nullable|string',
            'repas.*.dessert' => 'nullable|string',
            'repas.*.description_simple' => 'nullable|string',
            'repas.*.entree_recette_ids' => 'nullable|array',
            'repas.*.plat_recette_ids' => 'nullable|array',
            'repas.*.accompagnement_recette_ids' => 'nullable|array',
            'repas.*.dessert_recette_ids' => 'nullable|array',
            'repas.*.simple_recette_ids' => 'nullable|array',
        ]);

        $repasData = $validated['repas'] ?? null;
        unset($validated['repas']);
        // Update 'date' if 'horaire_mission' is provided
        if (isset($validated['horaire_mission'])) {
            $validated['date'] = \Carbon\Carbon::parse($validated['horaire_mission'])->toDateString();
        }

        $mission->update($validated);

        // Si des repas sont fournis, on remplace les anciens
        if ($repasData !== null) {
            // Supprimer les anciens repas et leurs liens recettes
            foreach ($mission->repas as $oldRepas) {
                $oldRepas->recettes()->detach();
                $oldRepas->delete();
            }

            // Créer les nouveaux repas
            foreach ($repasData as $repas) {
                $missionRepas = $mission->repas()->create($repas);

                // Gérer la sélection multiple (pivot)
                $categories = ['entree', 'plat', 'accompagnement', 'dessert', 'simple'];
                foreach ($categories as $cat) {
                    $idsField = $cat . '_recette_ids';
                    if (isset($repas[$idsField]) && is_array($repas[$idsField])) {
                        foreach ($repas[$idsField] as $recetteId) {
                            $missionRepas->recettes()->attach($recetteId, ['category' => $cat]);
                        }
                    }
                }
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Mission mise à jour avec succès',
            'data' => new MissionResource($mission->load(['repas.entreeRecette', 'repas.platRecette', 'repas.accompagnementRecette', 'repas.dessertRecette', 'repas.simpleRecette', 'repas.recettes']))
        ]);
    }

    /**
     * Traiter la demande de mission (Côté Admin)
     */
    public function process(Request $request, Mission $mission)
    {
        $validated = $request->validate([
            'professionnel_id' => 'nullable|exists:professionnels,id',
            'statut' => 'required|string',
            'commentaires_admin' => 'nullable|string',
            
            // Allow all other fields during process
            'nb_residents_jour' => 'nullable|integer',
            'types_repas' => 'nullable|array',
            'regimes_speciaux' => 'nullable|array',
            'menu_entree_brut' => 'nullable|array',
            'menu_plat_brut' => 'nullable|array',
            'menu_accompagnement_brut' => 'nullable|array',
            'menu_dessert_brut' => 'nullable|array',
            'nb_regimes_haches' => 'nullable|integer',
            'nb_regimes_mixes' => 'nullable|integer',
            'nb_regimes_moulines' => 'nullable|integer',
            'quantite_viande' => 'nullable|numeric',
            'quantite_riz' => 'nullable|numeric',
            'quantite_legumes' => 'nullable|numeric',
            'commentaires' => 'nullable|string',
            'date' => 'nullable|date',
            'horaire_mission' => 'nullable',
            'horaire_fin' => 'nullable',
            'heure_fin' => 'nullable|string',
            'code_entree' => 'nullable|string',
            'code_cuisine' => 'nullable|string',
            
            'recettes_ids' => 'nullable|array',
        ]);

        // Sync recipes if provided
        if (isset($validated['recettes_ids'])) {
            $mission->recettes()->sync($validated['recettes_ids']);
            unset($validated['recettes_ids']);
        }

        // Update 'date' if 'horaire_mission' is provided
        if (isset($validated['horaire_mission'])) {
            $validated['date'] = \Carbon\Carbon::parse($validated['horaire_mission'])->toDateString();
        }

        // Update the mission with all validated fields
        $oldStatus = $mission->statut;
        $mission->update($validated);

        // Si la mission devient "confirmé", notifier tous les professionnels
        if ($oldStatus !== Mission::STATUS_CONFIRMED && $mission->statut === Mission::STATUS_CONFIRMED) {
            $professionals = User::where('role', 'professionnel')->get();
            foreach ($professionals as $pro) {
                $pro->notify(new MissionValidated($mission));
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Mission traitée avec succès',
            'data' => new MissionResource($mission->load(['structure.user', 'professionnel.user', 'recettes', 'repas.entreeRecette', 'repas.platRecette', 'repas.accompagnementRecette', 'repas.dessertRecette', 'repas.simpleRecette']))
        ]);
    }

    /**
     * Accepter une mission (Côté Professionnel)
     */
    public function accept(Request $request, Mission $mission)
    {
        $user = $request->user();
        if (!$user->professionnel) {
            return response()->json(['success' => false, 'message' => 'Seuls les professionnels peuvent accepter une mission.'], 403);
        }

        if ($mission->professionnel_id !== null && $mission->professionnel_id !== $user->professionnel->id) {
            return response()->json(['success' => false, 'message' => 'Cette mission est déjà assignée à un autre professionnel.'], 403);
        }

        // Si la mission n'est pas encore assignée, on l'assigne à ce professionnel
        if ($mission->professionnel_id === null || $mission->professionnel_id === $user->professionnel->id) {
            $mission->update([
                'professionnel_id' => $user->professionnel->id,
                'statut' => Mission::STATUS_IN_PROGRESS,
            ]);
        }

        // On enregistre la réponse positive individuelle
        \App\Models\MissionResponse::updateOrCreate(
            ['mission_id' => $mission->id, 'professionnel_id' => $user->professionnel->id],
            ['status' => 'confirmé']
        );

        return response()->json([
            'success' => true,
            'message' => 'Mission acceptée avec succès.',
            'data' => new MissionResource($mission->load('professionnel.user'))
        ]);
    }

    /**
     * Refuser une mission (Côté Professionnel)
     */
    public function reject(Request $request, Mission $mission)
    {
        $user = $request->user();
        if (!$user->professionnel) {
            return response()->json(['success' => false, 'message' => 'Seuls les professionnels peuvent refuser une mission.'], 403);
        }

        if ($mission->professionnel_id !== null && $mission->professionnel_id !== $user->professionnel->id) {
            return response()->json(['success' => false, 'message' => 'Vous ne pouvez pas refuser une mission assignée à quelqu\'un d\'autre.'], 403);
        }

        // On enregistre la réponse négative individuelle
        \App\Models\MissionResponse::updateOrCreate(
            ['mission_id' => $mission->id, 'professionnel_id' => $user->professionnel->id],
            ['status' => 'refusé']
        );

        // Si le professionnel était celui assigné, on libère la mission (elle devient "confirmé" = disponible)
        if ($mission->professionnel_id === $user->professionnel->id) {
            $mission->update([
                'professionnel_id' => null,
                'statut' => Mission::STATUS_CONFIRMED,
            ]);
        }

        return response()->json([
            'success' => true,
            'message' => 'Mission refusée avec succès.',
            'data' => new MissionResource($mission)
        ]);
    }

    /**
     * Update the checklist for a mission (Côté Professionnel)
     */
    public function updateChecklist(Request $request, Mission $mission)
    {
        $user = $request->user();
        if (!$user->professionnel) {
            return response()->json(['success' => false, 'message' => 'Seuls les professionnels peuvent mettre à jour la checklist.'], 403);
        }

        if ($mission->professionnel_id !== $user->professionnel->id) {
            return response()->json(['success' => false, 'message' => 'Vous ne pouvez mettre à jour que vos propres missions.'], 403);
        }

        $validated = $request->validate([
            'checklist_journee' => 'nullable|array',
            'checklist_items' => 'nullable|array',
        ]);

        $mission->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Checklist mise à jour.',
            'data' => new MissionResource($mission)
        ]);
    }

    /**
     * Terminer une mission (Côté Professionnel)
     */
    public function finish(Request $request, Mission $mission)
    {
        $user = $request->user();
        if (!$user->professionnel) {
            return response()->json(['success' => false, 'message' => 'Seuls les professionnels peuvent terminer une mission.'], 403);
        }

        if ($mission->professionnel_id !== $user->professionnel->id) {
            return response()->json(['success' => false, 'message' => 'Vous ne pouvez terminer que vos propres missions.'], 403);
        }

        if ($mission->statut === Mission::STATUS_FINISHED) {
            return response()->json([
                'success' => true,
                'message' => 'Mission déjà terminée.',
                'data' => new MissionResource($mission)
            ]);
        }

        if ($mission->statut !== Mission::STATUS_IN_PROGRESS && $mission->statut !== Mission::STATUS_CONFIRMED) {
            return response()->json(['success' => false, 'message' => 'Seule une mission en cours peut être terminée.'], 400);
        }

        $mission->update([
            'statut' => Mission::STATUS_FINISHED,
            'horaire_fin' => now(), // On enregistre l'heure réelle de fin
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Mission terminée avec succès.',
            'data' => new MissionResource($mission)
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Mission $mission)
    {
        return new MissionResource($mission->load(['structure', 'professionnel', 'incidents', 'repas.entreeRecette', 'repas.platRecette', 'repas.accompagnementRecette', 'repas.dessertRecette', 'repas.simpleRecette']));
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, Mission $mission)
    {
        // Sécurité : Seul l'admin ou le propriétaire de la mission peut la supprimer
        if ($request->user()->role !== 'admin' && $mission->structure_id !== $request->user()->structure?->id) {
            abort(403, 'Vous n\'êtes pas autorisé à supprimer cette mission.');
        }

        $mission->delete();
        return response()->json(['success' => true, 'message' => 'Mission supprimée']);
    }
}



