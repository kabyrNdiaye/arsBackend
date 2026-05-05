<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Menu;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MenuController extends Controller
{
    public function index(Request $request)
    {
        $query = Menu::with('recettes');

        if ($request->has('search')) {
            $search = $request->query('search');
            $query->where(function($q) use ($search) {
                $q->where('nom', 'ILIKE', "%{$search}%")
                  ->orWhere('description', 'ILIKE', "%{$search}%");
            });
        }

        if ($request->has('type')) {
            $query->where('type', $request->query('type'));
        }

        $perPage = 5;
        $menus = $query->latest()->paginate($perPage);

        return response()->json([
            'success'      => true,
            'data'         => $menus->items(),
            'total'        => $menus->total(),
            'per_page'     => $menus->perPage(),
            'current_page' => $menus->currentPage(),
            'last_page'    => $menus->lastPage(),
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nom' => 'required|string|max:255',
            'type' => 'required|string',
            'description' => 'nullable|string',
            'status' => 'nullable|string',
            'diets' => 'nullable|array',
            'recipe_ids' => 'required|array', // Structure: { "entree": [id1, id2], "plat": [id3], ... }
        ]);

        try {
            return DB::transaction(function () use ($validated) {
                $menu = Menu::create([
                    'nom' => $validated['nom'],
                    'type' => $validated['type'],
                    'description' => $validated['description'] ?? '',
                    'status' => $validated['status'] ?? 'Brouillon',
                    'diets' => $validated['diets'] ?? [],
                    'created_by' => auth()->id(),
                ]);

                $this->syncRecettes($menu, $validated['recipe_ids']);

                return response()->json([
                    'success' => true,
                    'message' => 'Menu créé avec succès',
                    'data' => $menu->load('recettes')
                ], 201);
            });
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la création du menu: ' . $e->getMessage()
            ], 500);
        }
    }

    public function show(Menu $menu)
    {
        return response()->json([
            'success' => true,
            'data' => $menu->load('recettes')
        ]);
    }

    public function update(Request $request, Menu $menu)
    {
        $validated = $request->validate([
            'nom' => 'sometimes|required|string|max:255',
            'type' => 'sometimes|required|string',
            'description' => 'nullable|string',
            'status' => 'nullable|string',
            'diets' => 'nullable|array',
            'recipe_ids' => 'sometimes|required|array',
        ]);

        try {
            return DB::transaction(function () use ($validated, $menu) {
                $menu->update($validated);

                if (isset($validated['recipe_ids'])) {
                    $this->syncRecettes($menu, $validated['recipe_ids']);
                }

                return response()->json([
                    'success' => true,
                    'message' => 'Menu mis à jour',
                    'data' => $menu->load('recettes')
                ]);
            });
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la mise à jour: ' . $e->getMessage()
            ], 500);
        }
    }

    public function destroy(Menu $menu)
    {
        $menu->delete();
        return response()->json([
            'success' => true,
            'message' => 'Menu supprimé'
        ]);
    }

    /**
     * Synchronise les recettes avec le menu selon leurs catégories.
     */
    private function syncRecettes(Menu $menu, array $recipeData)
    {
        $syncData = [];
        $order = 1;

        foreach ($recipeData as $category => $ids) {
            if (!is_array($ids)) continue;
            
            foreach ($ids as $id) {
                $syncData[$id] = [
                    'category' => $category,
                    'order' => $order++
                ];
            }
        }

        $menu->recettes()->sync($syncData);
    }
}
