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
    public function getAdminStats()
    {
        $today = Carbon::today();
        $missionsToday = Mission::whereDate('date', $today)->count();
        $totalMissions = Mission::count();
        $avgSatisfaction = Retour::avg('note') ?? 0;
        $satisfactionPercent = $avgSatisfaction > 0 ? round(($avgSatisfaction / 5) * 100) : 100;
        $validatedProfessionals = User::where('role', 'professionnel')->whereHas('professionnel', function ($q) { $q->where('statut_validation', 'valide'); })->count();
        $totalProfessionals = User::where('role', 'professionnel')->count();
        $activeSites = User::where('role', 'client')->whereHas('structure', function ($q) { $q->where('statut_validation', 'valide'); })->count();
        $totalStructures = User::where('role', 'client')->count();
        $totalIncidents = Incident::count();
        $recipesCount = Recette::count();
        $formationsCount = Formation::count();
        $menusCount = MissionRepas::count();
        return response()->json(['success' => true, 'data' => ['missions_today' => $missionsToday, 'total_missions' => $totalMissions, 'satisfaction_percentage' => $satisfactionPercent, 'available_professionals' => $validatedProfessionals, 'total_professionals' => $totalProfessionals, 'active_sites' => $activeSites, 'total_structures' => $totalStructures, 'total_incidents' => $totalIncidents, 'total_recipes' => $recipesCount, 'total_formations' => $formationsCount, 'total_menus' => $menusCount]]);
    }

    public function getStructureStats(Request $request)
    {
        $user = $request->user();
        $structure = $user->structure;
        if (!$structure) { return response()->json(['success' => false, 'message' => 'Unauthorized.'], 403); }
        $structureId = $structure->id;
        $totalMissions = Mission::where('structure_id', $structureId)->count();
        $avgResidents = $structure->capacite ?? 0;
        $totalChefs = Mission::where('structure_id', $structureId)->whereNotNull('professionnel_id')->distinct('professionnel_id')->count('professionnel_id');
        return response()->json(['success' => true, 'data' => ['total_missions' => (int) $totalMissions, 'total_residents' => (int) round($avgResidents), 'total_chefs' => (int) $totalChefs]]);
    }
}
