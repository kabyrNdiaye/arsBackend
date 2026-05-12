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
Route::get('/email/verify/{id}/{hash}', function (\Illuminate\Http\Request $request, $id, $hash) {
    $user = \App\Models\User::findOrFail($id);
    if (!hash_equals((string) $hash, sha1($user->getEmailForVerification()))) {
        return response()->json(['success' => false, 'message' => 'Lien de vérification invalide.'], 403);
    }
    if ($user->hasVerifiedEmail()) {
        return response()->json(['success' => true, 'message' => 'Email déjà vérifié.']);
    }
    $user->markEmailAsVerified();
    return response()->json(['success' => true, 'message' => 'Email vérifié avec succès.']);
})->middleware(['auth:sanctum', 'signed'])->name('verification.verify');
Route::get('/metadata/registration', [MetadataController::class, 'getRegistrationMetadata']);

Route::get('/cors-test', function () {
    return response()->json(['message' => 'CORS works!']);
});

// Routes temporaires supprimées pour raisons de sécurité

// Route pour servir les fichiers avec les headers CORS
// Les noms de fichiers (UUID) sont imprédictibles, la route est publique pour les balises <img>.
Route::get('/media/{path}', [FileController::class, 'serve'])->where('path', '.*');

Route::middleware('auth:sanctum')->group(function () {

    // ==================== ROUTES ADMIN ====================
    Route::middleware('admin')->group(function () {
        Route::get('/stats/admin', [StatsController::class, 'getAdminStats']);
        Route::get('/professionals', [AuthController::class, 'professionals']);
        Route::get('/structures', [AuthController::class, 'structures']);
        Route::get('/structures/{user}', [AuthController::class, 'showStructure']);
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
    Route::post('missions/{mission}/cancel', [MissionController::class, 'cancel']);
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
