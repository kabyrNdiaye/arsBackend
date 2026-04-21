<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use Symfony\Component\HttpFoundation\Response;

class FileController extends Controller
{
    /**
     * Sert un fichier depuis le storage public avec les headers CORS.
     */
    public function serve($path)
    {
        // Nettoyage sommaire du chemin
        $path = str_replace('..', '', $path);
        
        \Log::info("Accès média : " . $path);

        if (!Storage::disk('public')->exists($path)) {
            \Log::error("Fichier introuvable : " . $path);
            abort(404);
        }

        $fullPath = Storage::disk('public')->path($path);

        // Les headers CORS doivent être présents même pour les erreurs ou les pré-vols (OPTIONS)
        $headers = [
            'Access-Control-Allow-Origin' => '*',
            'Access-Control-Allow-Methods' => 'GET, OPTIONS',
            'Access-Control-Allow-Headers' => '*',
            'Access-Control-Expose-Headers' => 'Content-Length, Content-Range, Accept-Ranges',
            'Accept-Ranges' => 'bytes',
        ];

        return response()->file($fullPath, $headers);
    }
}
