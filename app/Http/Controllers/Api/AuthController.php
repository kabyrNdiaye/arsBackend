<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Professionnel;
use App\Models\Structure;
use App\Models\Document;
use App\Http\Resources\UserResource;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\Rules\Password;

class AuthController extends Controller
{
    /**
     * Inscription d'un nouvel utilisateur
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            // Champs obligatoires
            'prenom' => 'required|string|max:255',
            'nom' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => ['required', 'confirmed', Password::min(8)->letters()->mixedCase()->numbers()],
            'role' => ['required', Rule::in(['client', 'professionnel'])],
            
            // Champs optionnels communs
            'telephone' => 'nullable|string|max:20',
            'adresse' => 'nullable|string',
            'code_postal' => 'nullable|string|max:10',
            'ville' => 'nullable|string|max:100',
            
            // Champs CLIENT
            'nom_etablissement' => 'nullable|string|max:255',
            'telephone_etablissement' => 'nullable|string|max:20',
            'type_etablissement' => 'nullable|string|max:100',
            'capacite' => 'nullable|integer',
            'fonction' => 'nullable|string|max:100',
            // Validation des fichiers (accepte fichier ou string pour compatibilité)
            'contrat_prestation_path' => 'nullable|file|mimes:pdf,jpg,png|max:5120', 
            'plan_locaux_path' => 'nullable|file|mimes:pdf,jpg,png|max:5120',
            'reglement_interieur_path' => 'nullable|file|mimes:pdf,jpg,png|max:5120',
            
            // Champs PROFESSIONNEL
            'date_naissance' => 'nullable|date',
            'diplome' => 'nullable|string|max:255',
            'annees_experience' => 'nullable|integer',
            'specialites' => 'nullable|array',
            'photo_profil_path' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
            'diplome_path' => 'nullable|array',
            'diplome_path.*' => 'file|mimes:pdf,jpg,png|max:5120',
            'certificat_medical_path' => 'nullable|file|mimes:pdf,jpg,png|max:5120',
            'permis_conduire_path' => 'nullable|file|mimes:pdf,jpg,png|max:5120',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        try {
        \Illuminate\Support\Facades\Log::info('Tentative d\'inscription', [
            'role' => $request->role,
            'email' => $request->email,
            'files' => array_keys($request->allFiles()),
            'data' => $request->except(['password', 'password_confirmation'])
        ]);
        DB::beginTransaction();

            // Gestion de l'upload des fichiers
            $filePaths = [];
            $filesToUpload = [
                'contrat_prestation_path' => 'documents/clients',
                'plan_locaux_path' => 'documents/clients',
                'reglement_interieur_path' => 'documents/clients',
                'photo_profil_path' => 'images/profils',
                'diplome_path' => 'documents/professionnels',
                'certificat_medical_path' => 'documents/professionnels',
                'permis_conduire_path' => 'documents/professionnels',
            ];

            foreach ($filesToUpload as $field => $path) {
                if ($request->hasFile($field)) {
                    $files = $request->file($field);
                    if (is_array($files)) {
                        // Si c'est un tableau de fichiers (ex: diplome_path[$i])
                        $paths = [];
                        foreach ($files as $index => $file) {
                            $ext = $file->getClientOriginalExtension();
                            $filename = Str::uuid() . '.' . $ext;
                            $storedPath = $file->storeAs($path, $filename, 'public');
                            $paths[] = $storedPath;
                        }
                        $filePaths[$field] = $paths;
                    } else {
                        // Si c'est un fichier unique
                        $ext = $files->getClientOriginalExtension();
                        $filename = Str::uuid() . '.' . $ext;
                        $storedPath = $files->storeAs($path, $filename, 'public');
                        $filePaths[$field] = $storedPath;
                    }
                } elseif ($request->filled($field)) {
                    // Si c'est déjà un chemin (cas test ou legacy)
                    $filePaths[$field] = $request->input($field);
                } else {
                    $filePaths[$field] = null;
                }
            }

            // 1. Création de l'utilisateur (Compte commun)
            $user = User::create([
                'prenom' => $request->prenom,
                'nom' => $request->nom,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'role' => $request->role,
                'telephone' => $request->telephone,
                'adresse' => $request->adresse,
                'code_postal' => $request->code_postal,
                'ville' => $request->ville,
            ]);

            $user->sendEmailVerificationNotification();

            // 2. Création du profil spécifique et enregistrement des documents
            if ($request->role === 'client') {
                $profile = Structure::create([
                    'user_id' => $user->id,
                    'nom_etablissement' => $request->nom_etablissement,
                    'telephone_etablissement' => $request->telephone_etablissement,
                    'type_etablissement' => $request->type_etablissement,
                    'capacite' => $request->capacite,
                    'fonction' => $request->fonction,
                    'statut_validation' => 'en_attente',
                    'adresse' => $request->adresse,
                    'code_postal' => $request->code_postal,
                    'ville' => $request->ville,
                ]);
            } elseif ($request->role === 'professionnel') {
                $profile = Professionnel::create([
                    'user_id' => $user->id,
                    'date_naissance' => $request->date_naissance,
                    'diplome' => $request->diplome,
                    'fonction' => $request->fonction,
                    'annees_experience' => $request->annees_experience,
                    'specialites' => $request->specialites,
                    'statut_validation' => 'en_attente',
                ]);
            }

            // 3. Enregistrement des documents dans la table polymorphe
            if (isset($profile)) {
                    // Mappage des noms pour un affichage propre
                    $namingMap = [
                        'photo_profil_path'       => 'Photo de profil',
                        'diplome_path'            => 'Diplôme',
                        'certificat_medical_path' => 'Certificat médical',
                        'permis_conduire_path'    => 'Permis de conduire',
                        'contrat_prestation_path' => 'Contrat de prestation',
                        'plan_locaux_path'        => 'Plan des locaux',
                        'reglement_interieur_path'=> 'Règlement intérieur',
                    ];

                    foreach ($filePaths as $field => $path) {
                        if ($path) {
                            $displayName = $namingMap[$field] ?? $field;
                            
                            if (is_array($path)) {
                                foreach ($path as $p) {
                                    $profile->documents()->create([
                                        'nom' => $displayName,
                                        'type' => 'document',
                                        'cheminFichier' => $p,
                                        'statut' => 'actif'
                                    ]);
                                }
                            } else {
                                $profile->documents()->create([
                                    'nom' => $displayName,
                                    'type' => 'document',
                                    'cheminFichier' => $path,
                                    'statut' => 'actif'
                                ]);
                            }

                            // Aussi enregistrer la photo sur le User lui-même pour une meilleure visibilité globale
                            if ($field === 'photo_profil_path') {
                                $user->documents()->create([
                                    'nom' => $displayName,
                                    'type' => 'document',
                                    'cheminFichier' => is_array($path) ? $path[0] : $path,
                                    'statut' => 'actif'
                                ]);
                            }
                        }
                    }
            }

            DB::commit();

            // Notifier les administrateurs
            $admins = User::where('role', 'admin')->get();
            foreach ($admins as $admin) {
                $admin->notify(new \App\Notifications\NewUserRegistered($user));
            }

            $token = $user->createToken('auth_token')->plainTextToken;

            // Recharger l'utilisateur avec ses relations pour la réponse
            $user->load(['structure.documents', 'professionnel.documents', 'documents']);

            return response()->json([
                'success' => true,
                'access_token' => $token,
                'token_type' => 'Bearer',
                'user' => new UserResource($user),
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Erreur inscription', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
                'user' => $request->email ?? 'inconnu',
            ]);
            return response()->json([
                'success' => false,
                'message' => 'Une erreur est survenue. Veuillez réessayer.'
            ], 500);
        }
    }

    /**
     * Connexion d'un utilisateur
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $throttleKey = Str::lower($request->input('email')) . '|' . $request->ip();

        if (\Illuminate\Support\Facades\RateLimiter::tooManyAttempts($throttleKey, 5)) {
            $seconds = \Illuminate\Support\Facades\RateLimiter::availableIn($throttleKey);
            return response()->json([
                'success' => false,
                'code' => 'too_many_attempts',
                'message' => "Trop de tentatives de connexion. Veuillez réessayer dans {$seconds} secondes.",
                'seconds' => $seconds
            ], 429);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            \Illuminate\Support\Facades\RateLimiter::hit($throttleKey, 60); // Bloque pendant 60s après 5 hits
            return response()->json([
                'success' => false,
                'message' => 'Identifiants incorrects'
            ], 401);
        }

        \Illuminate\Support\Facades\RateLimiter::clear($throttleKey);

        // Bloquer la connexion si le compte n'est pas encore validé par l'admin
        // (sauf pour les admins, qui n'ont pas besoin de validation)
        if ($user->role !== 'admin') {
            $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;
            if ($profile && $profile->statut_validation === 'en_attente') {
                return response()->json([
                    'success' => false,
                    'code' => 'pending_validation',
                    'message' => 'Votre compte est en attente de validation par un administrateur.',
                ], 403);
            }
            if ($profile && $profile->statut_validation === 'refuse') {
                return response()->json([
                    'success' => false,
                    'code' => 'account_refused',
                    'message' => 'Votre inscription a été refusée. Veuillez contacter l\'administrateur.',
                ], 403);
            }

            // Auto-vérifier l'email si l'admin a validé le compte
            $isValidated = $profile && $profile->statut_validation === 'valide';
            if (!$user->hasVerifiedEmail() && $isValidated) {
                $user->email_verified_at = now();
                $user->save();
            }
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        // Charger les documents pour la ressource
        $user->load(['structure.documents', 'professionnel.documents', 'documents']);

        return response()->json([
            'success' => true,
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => new UserResource($user),
        ]);
    }

    /**
     * Valider ou refuser un utilisateur (Admin uniquement)
     */
    public function validateUser(Request $request, User $user)
    {
        $validated = $request->validate([
            'statut_validation' => 'required|in:valide,refuse',
            'commentaire' => 'nullable|string',
        ]);

        $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;

        if (!$profile) {
            return response()->json([
                'success' => false,
                'message' => 'Profil utilisateur introuvable'
            ], 404);
        }

        $profile->update(['statut_validation' => $validated['statut_validation']]);

        // Marquer la notification 'new_user' comme lue pour tous les admins une fois validé/refusé
        $admins = \App\Models\User::where('role', 'admin')->get();
        foreach ($admins as $admin) {
            $notifications = $admin->unreadNotifications()->get();
            foreach ($notifications as $notif) {
                if (isset($notif->data['type']) && $notif->data['type'] === 'new_user' && isset($notif->data['user_id']) && $notif->data['user_id'] == $user->id) {
                    $notif->markAsRead();
                }
            }
        }

        $statutLabel = $validated['statut_validation'] === 'valide' ? 'validé' : 'refusé';

        return response()->json([
            'success' => true,
            'message' => "Compte {$statutLabel} avec succès",
            'user' => new UserResource($user->fresh(['professionnel.documents', 'structure.documents'])),
        ]);
    }

    /**
     * Supprimer définitivement un utilisateur (Admin uniquement)
     */
    public function deleteUser(User $user)
    {
        try {
            // Révoquer tous les tokens Sanctum
            $user->tokens()->delete();

            // Supprimer le profil lié (professionnel ou structure)
            if ($user->role === 'professionnel' && $user->professionnel) {
                $user->professionnel->documents()->delete();
                $user->professionnel->delete();
            } elseif ($user->role === 'client' && $user->structure) {
                $user->structure->documents()->delete();
                $user->structure->delete();
            }

            // Supprimer l'utilisateur
            $user->delete();

            return response()->json([
                'success' => true,
                'message' => 'Utilisateur supprimé définitivement',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Erreur lors de la suppression : ' . $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Déconnexion
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Déconnexion réussie'
        ]);
    }

    /**
     * Récupérer le profil utilisateur connecté
     */
    public function profile(Request $request)
    {
        $user = $request->user()->load(['structure.documents', 'professionnel.documents', 'documents']);
        
        return response()->json([
            'success' => true,
            'user' => new UserResource($user),
        ]);
    }

    /**
     * Récupérer la liste des professionnels
     */
    public function professionals()
    {
        $professionals = User::where('role', 'professionnel')
            ->with([
                'professionnel.documents', 
                'documents',
                'professionnel.missions' => function($q) {
                    $q->with('structure')->latest()->limit(1);
                }
            ])
            ->get();

        return response()->json([
            'success' => true,
            'data' => UserResource::collection($professionals),
        ]);
    }

    /**
     * Récupérer la liste des structures
     */
    public function structures()
    {
        $structures = User::where('role', 'client')
            ->with([
                'structure.documents',
                'documents',
            ])
            ->get();

        return response()->json([
            'success' => true,
            'data' => UserResource::collection($structures),
        ]);
    }

    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $validator = Validator::make($request->all(), [
            'firstName' => 'nullable|string|max:255',
            'lastName' => 'nullable|string|max:255',
            'email' => [
                'nullable',
                'string',
                'email',
                'max:255',
                Rule::unique('users')->ignore($user->id),
            ],
            'phone' => 'nullable|string|max:20',
            'photo_profil_path' => 'nullable|file|mimes:jpg,jpeg,png|max:10240',
            'diplome_path' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'certificat_medical_path' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
            'permis_conduire_path' => 'nullable|file|mimes:jpg,jpeg,png,pdf|max:10240',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $data = $request->only(['firstName', 'lastName', 'email', 'phone']);

        if (isset($data['firstName'])) $user->prenom = $data['firstName'];
        if (isset($data['lastName'])) $user->nom = $data['lastName'];
        if (isset($data['email'])) $user->email = $data['email'];
        if (isset($data['phone'])) $user->telephone = $data['phone'];

        $user->save();

        // Debug log pour voir ce qui arrive au backend
        \Illuminate\Support\Facades\Log::info('Update Profile Request:', [
            'has_file' => $request->hasFile('photo_profil_path'),
            'file_valid' => $request->hasFile('photo_profil_path') && $request->file('photo_profil_path')->isValid(),
        ]);

        // Gestion de la photo de profil
        if ($request->hasFile('photo_profil_path') && $request->file('photo_profil_path')->isValid()) {
            $file = $request->file('photo_profil_path');
            $ext = $file->getClientOriginalExtension();
            $filename = Str::uuid() . '.' . $ext;
            $path = $file->storeAs('images/profils', $filename, 'public');

            // Déterminer le profil lié (professionnel ou structure)
            $profile = $user->role === 'professionnel' ? $user->professionnel : $user->structure;
            $photoName = 'Photo de profil';

            if ($profile) {
                // Supprimer l'ancienne photo (qu'elle porte le nom technique ou le beau nom)
                $profile->documents()->whereIn('nom', ['photo_profil_path', $photoName])->delete();
                // Sauvegarder sur le profil
                $profile->documents()->create([
                    'nom' => $photoName,
                    'type' => 'document',
                    'cheminFichier' => $path,
                    'statut' => 'actif'
                ]);
            }

            // Aussi mettre à jour sur le User pour les admins
            $user->documents()->whereIn('nom', ['photo_profil_path', $photoName])->delete();
            $user->documents()->create([
                'nom' => $photoName,
                'type' => 'document',
                'cheminFichier' => $path,
                'statut' => 'actif'
            ]);
        }

        // Gestion des documents professionnels
        $documentFields = [
            'diplome_path'            => 'Diplôme',
            'certificat_medical_path' => 'Certificat médical',
            'permis_conduire_path'    => 'Permis de conduire',
        ];

        foreach ($documentFields as $field => $displayName) {
            if ($request->hasFile($field) && $request->file($field)->isValid()) {
                $file = $request->file($field);
                $ext = $file->getClientOriginalExtension();
                $filename = Str::uuid() . '.' . $ext;
                $path = $file->storeAs('documents/professionnels', $filename, 'public');

                $profile = $user->role === 'professionnel' ? $user->professionnel : null;

                if ($profile) {
                    // Supprimer l'ancien (nom technique ou beau nom)
                    $oldDocs = $profile->documents()->whereIn('nom', [$field, $displayName])->get();
                    foreach ($oldDocs as $oldDoc) {
                        Storage::disk('public')->delete($oldDoc->cheminFichier);
                        $oldDoc->delete();
                    }
                    // Sauvegarder le nouveau
                    $profile->documents()->create([
                        'nom' => $displayName,
                        'type' => 'document',
                        'cheminFichier' => $path,
                        'statut' => 'actif'
                    ]);
                }
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Profil mis à jour avec succès (v4-NUCLEAR)',
            'user' => new UserResource($user->fresh(['structure.documents', 'professionnel.documents', 'documents'])),
        ]);
    }

    public function changePassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'current_password' => 'required',
            'password' => ['required', 'confirmed', Password::min(8)->letters()->mixedCase()->numbers()],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $user = $request->user();

        if (!Hash::check($request->current_password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Le mot de passe actuel est incorrect.'
            ], 422);
        }

        $user->password = Hash::make($request->password);
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Mot de passe modifié avec succès.'
        ]);
    }

    /**
     * Envoyer un lien de réinitialisation de mot de passe (simulé via log)
     */
    public function forgotPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:users,email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'L\'adresse email est invalide ou n\'existe pas.'
            ], 422);
        }

        $email = $request->email;
        $token = Str::random(60);

        DB::table('password_reset_tokens')->updateOrInsert(
            ['email' => $email],
            ['token' => Hash::make($token), 'created_at' => now()]
        );

        // Envoi de l'e-mail réel
        try {
            \Illuminate\Support\Facades\Mail::to($email)->send(new \App\Mail\ResetPasswordMail($token));
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("Erreur lors de l'envoi de l'e-mail de réinitialisation: " . $e->getMessage());
        }

        // Sécurité : Supprimer le log qui affichait le token en clair
        Log::info("Demande de réinitialisation de mot de passe pour : {$email}");

        return response()->json([
            'success' => true,
            'message' => 'L\'e-mail de réinitialisation a été envoyé à votre adresse.'
        ]);
    }

    /**
     * Réinitialiser le mot de passe avec le token
     */
    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'token' => 'required',
            'email' => 'required|email|exists:users,email',
            'password' => ['required', 'confirmed', Password::min(8)->letters()->mixedCase()->numbers()],
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $reset = DB::table('password_reset_tokens')
            ->where('email', $request->email)
            ->first();

        if (!$reset || !Hash::check($request->token, $reset->token)) {
            return response()->json([
                'success' => false,
                'message' => 'Le jeton de réinitialisation est invalide ou a expiré.'
            ], 422);
        }

        // Vérification d'expiration (60 minutes)
        if (now()->diffInMinutes($reset->created_at) > 60) {
            DB::table('password_reset_tokens')
                ->where('email', $request->email)->delete();
            return response()->json([
                'success' => false,
                'message' => 'Ce lien a expiré. Veuillez faire une nouvelle demande.'
            ], 422);
        }

        $user = User::where('email', $request->email)->first();
        $user->password = Hash::make($request->password);
        $user->save();

        // Supprimer le token utilisé
        DB::table('password_reset_tokens')->where('email', $request->email)->delete();

        return response()->json([
            'success' => true,
            'message' => 'Votre mot de passe a été réinitialisé avec succès.'
        ]);
    }
}
