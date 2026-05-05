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

        if (!file_exists($fullPath)) {
            Log::error("Fichier introuvable : " . $path);
            abort(404, 'Fichier introuvable');
        }

        $realPath = realpath($fullPath);

        // Bloquer les path traversal
        if (
            $realPath === false ||
            $publicBase === false ||
            !str_starts_with($realPath, $publicBase . DIRECTORY_SEPARATOR) ||
            !is_file($realPath)
        ) {
            Log::warning("Accès refusé (path traversal ou dossier) : " . $path);
            abort(403, 'Accès refusé');
        }

        Log::info("Accès média autorisé : " . $realPath);

        $origin = config('cors.allowed_origins')[0] ?? '';
        $headers = [
            'Access-Control-Allow-Origin'   => $origin,
            'Access-Control-Allow-Methods'  => 'GET, OPTIONS',
            'Access-Control-Allow-Headers'  => 'Authorization, Accept, Content-Type',
            'Access-Control-Expose-Headers' => 'Content-Length, Content-Range, Accept-Ranges',
            'Accept-Ranges'                 => 'bytes',
        ];

        return response()->file($realPath, $headers);
    }
}
