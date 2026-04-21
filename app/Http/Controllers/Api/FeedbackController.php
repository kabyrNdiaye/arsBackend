<?php

namespace App\Http\Controllers\Api;

use App\Models\Feedback;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class FeedbackController extends Controller
{
    /**
     * GET /api/feedbacks
     * Récupérer tous les retours (admin)
     */
    public function index(Request $request): JsonResponse
    {
        try {
            // Vérifier les permissions (admin ou client)
            if (!auth()->check()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Non authentifié'
                ], 401);
            }

            $query = Feedback::with('user:id,name,email');

            // Filtrer par type si fourni
            if ($request->has('type')) {
                $query->byType($request->type);
            }

            // Filtrer par utilisateur si c'est un client (non-admin)
            $user = auth()->user();
            if ($user && $user->role !== 'admin') {
                $query->where('user_id', $user->id);
            }

            // Paginer et trier
            $feedbacks = $query->recent()->paginate(20);

            return response()->json([
                'success' => true,
                'data' => $feedbacks->items(),
                'pagination' => [
                    'total' => $feedbacks->total(),
                    'per_page' => $feedbacks->perPage(),
                    'current_page' => $feedbacks->currentPage(),
                    'last_page' => $feedbacks->lastPage(),
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * POST /api/feedbacks
     * Soumettre un nouveau retour
     */
    public function store(Request $request): JsonResponse
    {
        try {
            // Vérifier l'authentification
            if (!auth()->check()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Non authentifié'
                ], 401);
            }

            // Validation
            $validator = Validator::make($request->all(), [
                'rating' => 'required|integer|min:1|max:5',
                'comment' => 'nullable|string|max:1000',
                'type' => 'nullable|string|max:50',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation échouée',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Créer le retour
            $feedback = Feedback::create([
                'user_id' => auth()->id(),
                'rating' => $request->rating,
                'comment' => $request->comment ?? '',
                'type' => $request->type ?? 'general',
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Retour envoyé avec succès',
                'data' => $feedback->load('user:id,name,email')
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de l\'envoi: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * GET /api/feedbacks/{id}
     * Récupérer un retour spécifique
     */
    public function show(Feedback $feedback): JsonResponse
    {
        try {
            // Vérifier les permissions
            $user = auth()->user();
            if ($user && $user->role !== 'admin' && $feedback->user_id !== $user->id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Non autorisé'
                ], 403);
            }

            return response()->json([
                'success' => true,
                'data' => $feedback->load('user:id,name,email')
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * DELETE /api/feedbacks/{id}
     * Supprimer un retour (admin ou propre retour)
     */
    public function destroy(Feedback $feedback): JsonResponse
    {
        try {
            // Vérifier les permissions
            $user = auth()->user();
            if ($user && $user->role !== 'admin' && $feedback->user_id !== $user->id) {
                return response()->json([
                    'success' => false,
                    'message' => 'Non autorisé'
                ], 403);
            }

            $feedback->delete();

            return response()->json([
                'success' => true,
                'message' => 'Retour supprimé'
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * GET /api/feedbacks/stats/summary
     * Obtenir les statistiques des retours
     */
    public function getStats(): JsonResponse
    {
        try {
            $totalFeedbacks = Feedback::count();
            $averageRating = Feedback::avg('rating');
            $ratingDistribution = Feedback::selectRaw('rating, count(*) as count')
                ->groupBy('rating')
                ->get()
                ->mapWithKeys(fn($item) => [$item->rating => $item->count]);

            return response()->json([
                'success' => true,
                'data' => [
                    'total_feedbacks' => $totalFeedbacks,
                    'average_rating' => round($averageRating, 2),
                    'rating_distribution' => $ratingDistribution,
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur: ' . $e->getMessage()
            ], 500);
        }
    }
}
