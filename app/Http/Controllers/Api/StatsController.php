<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Mission;
use App\Models\User;
use App\Models\Incident;
use App\Models\Recette;
use App\Models\Formation;
use App\Models\Retour;
use App\Models\MissionRepas;
use Illuminate\Http\Request;
use Carbon\Carbon;

class StatsController extends Controller
{
    /**
     * Get global statistics for admin dashboard.
     */
    public function getAdminStats()
    {
        $today = Carbon::today();
        
        // --- Dashboard Main Stats ---
        
        // Count missions created today
        $missionsToday = Mission::whereDate('created_at', $today)->count();
        
        // Total missions ever
        $totalMissions = Mission::count();
        
        // Average satisfaction from Recette Returns (scaled to 100%)
        $avgSatisfaction = Retour::avg('note') ?? 0;
        $satisfactionPercent = $avgSatisfaction > 0 ? round(($avgSatisfaction / 5) * 100) : 100;

        // Count available professionals (validated and not currently on a confirmed/in progress mission)
        $validatedProfessionals = User::where('role', 'professionnel')
            ->whereHas('professionnel', function($q) {
                $q->where('statut_validation', 'valide');
            })
            ->whereDoesntHave('professionnel.missions', function($q) {
                $q->whereIn('statut', ['en cours', 'confirmé', 'confirmed']);
            })->count();
            
        // Count all professionals
        $totalProfessionals = User::where('role', 'professionnel')->count();

        // Count validated structures (active sites)
        $activeSites = User::where('role', 'client')
            ->whereHas('structure', function($q) {
                $q->where('statut_validation', 'valide');
            })->count();
            
        // Count all structures
        $totalStructures = User::where('role', 'client')->count();

        // Count all incidents
        $totalIncidents = Incident::count();

        // --- Resource Counts ---
        $recipesCount = Recette::count();
        $formationsCount = Formation::count();
        $menusCount = MissionRepas::count();

        return response()->json([
            'success' => true,
            'data' => [
                'missions_today' => $missionsToday,
                'total_missions' => $totalMissions,
                'satisfaction_percentage' => $satisfactionPercent,
                'available_professionals' => $validatedProfessionals, // For Home dashboard
                'total_professionals' => $totalProfessionals,
                'active_sites' => $activeSites, // For Home dashboard
                'total_structures' => $totalStructures,
                'total_incidents' => $totalIncidents,
                'total_recipes' => $recipesCount,
                'total_formations' => $formationsCount,
                'total_menus' => $menusCount,
            ]
        ]);
    }

    /**
     * Get statistics for a specific structure (client).
     */
    public function getStructureStats(Request $request)
    {
        $user = $request->user();
        $structure = $user->structure;

        if (!$structure) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized. Only structures can access these stats.'
            ], 403);
        }

        $structureId = $structure->id;

        // Total missions for this structure
        $totalMissions = Mission::where('structure_id', $structureId)->count();

        // Utilisation de la capacité directe de la structure
        $avgResidents = $structure->capacite ?? 0;
        
        // Count unique professionals who worked for this structure
        $totalChefs = Mission::where('structure_id', $structureId)
            ->whereNotNull('professionnel_id')
            ->distinct('professionnel_id')
            ->count('professionnel_id');

        return response()->json([
            'success' => true,
            'data' => [
                'total_missions' => (int) $totalMissions,
                'total_residents' => (int) round($avgResidents),
                'total_chefs' => (int) $totalChefs,
            ]
        ]);
    }
}
