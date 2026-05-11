<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class FileController extends Controller
{
    /**
     * Sert un fichier depuis le storage public avec les headers CORS.
     */
    public function serve($path)
    {
        $publicBase = realpath(Storage::disk('public')->path(''));
        $fullPath   = Storage::disk('public')->path($path);
        $realPath   = realpath($fullPath);

        Log::info("FileController@serve: ", [
            'raw_path' => $path,
            'full_path' => $fullPath,
            'real_path' => $realPath,
            'public_base' => $publicBase,
            'exists' => file_exists($fullPath),
            'is_file' => ($realPath && is_file($realPath))
        ]);

        if (!file_exists($fullPath)) {
            Log::error("Fichier introuvable sur le disque : " . $fullPath);
            abort(404, 'Fichier introuvable sur le disque');
        }

        // Bloquer les path traversal
        if (
            $realPath === false ||
            $publicBase === false ||
            !str_starts_with($realPath, $publicBase) ||
            !is_file($realPath)
        ) {
            Log::warning("Accès refusé (path traversal ou dossier) : " . $path);
            abort(403, 'Accès refusé');
        }

        Log::info("Accès média autorisé : " . $realPath);

        $origin = config('cors.allowed_origins')[0] ?? '';
        $headers = [
            'Access-Control-Allow-Origin'   => '*',
            'Access-Control-Allow-Methods'  => 'GET, OPTIONS',
            'Access-Control-Allow-Headers'  => '*',
            'Access-Control-Expose-Headers' => 'Content-Length, Content-Range, Accept-Ranges',
            'Accept-Ranges'                 => 'bytes',
            // X-Frame-Options est omis ici car géré par CSP ou par l'absence globale de DENY pour les médias
            'Content-Security-Policy'       => "frame-ancestors *", // CSP moderne pour l'iframe
        ];

        return response()->file($realPath, $headers);
    }
}
