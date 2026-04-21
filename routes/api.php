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

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
Route::get('/metadata/registration', [MetadataController::class, 'getRegistrationMetadata']);

Route::get('/cors-test', function () {
    return response()->json(['message' => 'CORS works!']);
});

// Route pour servir les fichiers avec les headers CORS
Route::get('/media/{path}', [FileController::class, 'serve'])->where('path', '.*');

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/stats/admin', [StatsController::class, 'getAdminStats']);
    Route::get('/stats/structure', [StatsController::class, 'getStructureStats']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return new \App\Http\Resources\UserResource($request->user());
    });
    Route::put('/user', [AuthController::class, 'updateProfile']);
    Route::put('/user/password', [AuthController::class, 'changePassword']);
    Route::get('/profile', [AuthController::class, 'profile']);

    Route::get('/professionals', [AuthController::class, 'professionals']);
    Route::get('/structures', [AuthController::class, 'structures']);
    Route::put('/users/{user}/validate', [AuthController::class, 'validateUser']);
    Route::delete('/users/{user}', [AuthController::class, 'deleteUser']);
    Route::put('missions/{mission}/process', [MissionController::class, 'process']);
    Route::put('missions/{mission}/checklist', [MissionController::class, 'updateChecklist']);
    Route::post('missions/{mission}/finish', [MissionController::class, 'finish']);
    Route::post('missions/{mission}/accept', [MissionController::class, 'accept']);
    Route::post('missions/{mission}/reject', [MissionController::class, 'reject']);
    Route::get('missions/{mission}/messages', [ChatController::class, 'index']);
    Route::post('missions/{mission}/messages', [ChatController::class, 'store']);
    Route::put('missions/{mission}/messages/read', [ChatController::class, 'markAsRead']);
    Route::put('messages/{message}/handled', [ChatController::class, 'markAsHandled']);
    Route::get('/notifications', [\App\Http\Controllers\Api\NotificationController::class, 'index']);
    Route::post('/notifications/mark-all-read', [\App\Http\Controllers\Api\NotificationController::class, 'markAllAsRead']);
    Route::post('/notifications/{id}/mark-read', [\App\Http\Controllers\Api\NotificationController::class, 'markAsRead']);
    Route::apiResource('missions', MissionController::class);
    Route::apiResource('formations', FormationController::class);
    Route::apiResource('recettes', RecetteController::class);
    Route::apiResource('documents', DocumentController::class);
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
