<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\MissionController;
use App\Http\Controllers\Api\FormationController;
use App\Http\Controllers\Api\DocumentController;
use App\Http\Controllers\Api\IncidentController;
use App\Http\Controllers\Api\RetourController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\RecetteController;
use App\Http\Controllers\Api\FileController; // Added this line

use App\Http\Controllers\Api\MetadataController;
use App\Http\Controllers\Api\StatsController;
use App\Http\Controllers\Api\ChatController;
use App\Http\Controllers\Api\FeedbackController;
use App\Http\Controllers\Api\MenuController;

Route::middleware('throttle:60,1')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
    Route::post('/login', [AuthController::class, 'login']);
    Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('/reset-password', [AuthController::class, 'resetPassword']);
});
Route::get('/email/verify/{id}/{hash}', [\Illuminate\Auth\Controllers\VerificationController::class, 'verify'])
    ->middleware(['auth:sanctum', 'signed'])
    ->name('verification.verify');
Route::get('/metadata/registration', [MetadataController::class, 'getRegistrationMetadata']);

Route::get('/cors-test', function () {
    return response()->json(['message' => 'CORS works!']);
});

// ROUTE TEMPORAIRE - Reset mot de passe (À SUPPRIMER APRÈS USAGE)
Route::get('/temp-reset-pwd', function (\Illuminate\Http\Request $request) {
    $secret = $request->query('secret');
    if ($secret !== 'ARS_RESET_2024_SECRET') {
        abort(403, 'Accès refusé');
    }
    $email  = $request->query('email');
    $newPwd = $request->query('pwd');
    if (!$email || !$newPwd) {
        return response()->json(['error' => 'Paramètres manquants: email, pwd'], 422);
    }
    $user = \App\Models\User::where('email', $email)->first();
    if (!$user) {
        return response()->json(['error' => 'Utilisateur introuvable'], 404);
    }
    $user->password = \Illuminate\Support\Facades\Hash::make($newPwd);
    // Marquer l'email comme vérifié si ce n'est pas déjà le cas
    if (!$user->email_verified_at) {
        $user->email_verified_at = now();
    }
    $user->save();
    return response()->json(['success' => true, 'message' => "Mot de passe réinitialisé pour {$user->email}"]);
});

// Route pour servir les fichiers avec les headers CORS
// Les noms de fichiers (UUID) sont imprédictibles, la route est publique pour les balises <img>.
Route::get('/media/{path}', [FileController::class, 'serve'])->where('path', '.*');

Route::middleware('auth:sanctum')->group(function () {

    // ==================== ROUTES ADMIN ====================
    Route::middleware('admin')->group(function () {
        Route::get('/stats/admin', [StatsController::class, 'getAdminStats']);
        Route::get('/professionals', [AuthController::class, 'professionals']);
        Route::get('/structures', [AuthController::class, 'structures']);
        Route::put('/users/{user}/validate', [AuthController::class, 'validateUser']);
        Route::delete('/users/{user}', [AuthController::class, 'deleteUser']);
    });

    Route::get('/stats/structure', [StatsController::class, 'getStructureStats']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return new \App\Http\Resources\UserResource($request->user());
    });
    Route::put('/user', [AuthController::class, 'updateProfile']);
    Route::put('/user/password', [AuthController::class, 'changePassword']);
    Route::get('/profile', [AuthController::class, 'profile']);

    Route::put('missions/{mission}/process', [MissionController::class, 'process']);
    Route::put('missions/{mission}/checklist', [MissionController::class, 'updateChecklist']);
    Route::post('missions/{mission}/finish', [MissionController::class, 'finish']);
    Route::post('missions/{mission}/accept', [MissionController::class, 'accept']);
    Route::post('missions/{mission}/reject', [MissionController::class, 'reject']);
    Route::get('missions/{mission}/messages', [ChatController::class, 'index']);
    Route::post('missions/{mission}/messages', [ChatController::class, 'store']);
    Route::put('missions/{mission}/messages/read', [ChatController::class, 'markAsRead']);
    
    // Routes de Chat par structure
    Route::get('structures/{structure}/messages', [ChatController::class, 'structureIndex']);
    Route::post('structures/{structure}/messages', [ChatController::class, 'structureStore']);
    Route::put('structures/{structure}/messages/read', [ChatController::class, 'structureMarkAsRead']);

    Route::put('messages/{message}/handled', [ChatController::class, 'markAsHandled']);
    Route::get('/notifications', [\App\Http\Controllers\Api\NotificationController::class, 'index']);
    Route::post('/notifications/mark-all-read', [\App\Http\Controllers\Api\NotificationController::class, 'markAllAsRead']);
    Route::post('/notifications/{id}/mark-read', [\App\Http\Controllers\Api\NotificationController::class, 'markAsRead']);
    Route::apiResource('missions', MissionController::class);
    Route::apiResource('formations', FormationController::class);
    Route::apiResource('recettes', RecetteController::class);
    Route::apiResource('documents', DocumentController::class);
    Route::get('/my-documents', [DocumentController::class, 'myDocuments']);
    Route::apiResource('incidents', IncidentController::class);
    Route::apiResource('retours', RetourController::class);
    Route::apiResource('menus', MenuController::class);
    
    // ==================== FEEDBACKS (Retours globaux) ====================
    Route::post('/feedbacks', [FeedbackController::class, 'store']);
    Route::get('/feedbacks', [FeedbackController::class, 'index']);
    Route::get('/feedbacks/{feedback}', [FeedbackController::class, 'show']);
    Route::delete('/feedbacks/{feedback}', [FeedbackController::class, 'destroy']);
    Route::get('/feedbacks/stats/summary', [FeedbackController::class, 'getStats']);
});
