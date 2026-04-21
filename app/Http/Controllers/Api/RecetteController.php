<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Recette;
use Illuminate\Http\Request;

class RecetteController extends Controller
{
    public function index(Request $request)
    {
        $query = Recette::query();

        if ($request->has('search')) {
            $search = $request->query('search');
            $keywords = explode(' ', $search);
            
            $query->where(function($q) use ($keywords) {
                foreach ($keywords as $keyword) {
                    if (trim($keyword) === '') continue;
                    $q->where(function($inner) use ($keyword) {
                        $inner->whereRaw("unaccent(nom) ILIKE unaccent(?)", ["%{$keyword}%"])
                              ->orWhereRaw("unaccent(description) ILIKE unaccent(?)", ["%{$keyword}%"])
                              ->orWhereRaw("unaccent(ingredients) ILIKE unaccent(?)", ["%{$keyword}%"]);
                    });
                }
            });

            // Tri par pertinence : le nom correspond en premier
            $query->orderByRaw("CASE 
                WHEN nom ILIKE ? THEN 1 
                WHEN description ILIKE ? THEN 2 
                ELSE 3 
            END", ["%{$search}%", "%{$search}%"]);
        } else {
            $query->latest();
        }

        if ($request->has('type') && !empty($request->query('type'))) {
            $query->where('type', $request->query('type'));
        }

        if ($request->has('meal_type') && !empty($request->query('meal_type'))) {
            $mealType = $request->query('meal_type');
            $query->whereJsonContains('meal_types', $mealType);
        }

        return response()->json([
            'success' => true,
            'data' => $query->get()
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nom' => 'required|string|max:255',
            'type' => 'nullable|string|in:entree,plat,accompagnement,dessert',
            'description' => 'nullable|string',
            'ingredients' => 'nullable|array',
            'temps_preparation' => 'nullable|string',
            'menu_id' => 'nullable|exists:menus,id',
            'regimes' => 'nullable|array',
            'textures' => 'nullable|array',
            'meal_types' => 'nullable|array',
            'nb_regimes_haches' => 'nullable|integer',
            'nb_regimes_mixes' => 'nullable|integer',
            'nb_regimes_moulines' => 'nullable|integer'
        ]);

        $validated['created_by'] = auth()->id();

        $recette = Recette::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Recette créée avec succès',
            'data' => $recette
        ], 201);
    }

    public function show(Recette $recette)
    {
        return response()->json([
            'success' => true,
            'data' => $recette
        ]);
    }

    public function update(Request $request, Recette $recette)
    {
        $recette->update($request->all());
        return response()->json([
            'success' => true,
            'message' => 'Recette mise à jour',
            'data' => $recette
        ]);
    }

    public function destroy(Recette $recette)
    {
        $recette->delete();
        return response()->json(['success' => true, 'message' => 'Recette supprimée']);
    }
}
