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
        if (!Storage::disk('public')->exists($path)) {
            Log::error("Fichier introuvable sur le disque public : " . $path);
            abort(404, 'Fichier introuvable');
        }

        $headers = [
            'Access-Control-Allow-Origin'   => '*',
            'Access-Control-Allow-Methods'  => 'GET, OPTIONS',
            'Access-Control-Allow-Headers'  => '*',
            'Access-Control-Expose-Headers' => 'Content-Length, Content-Range, Accept-Ranges',
            'Accept-Ranges'                 => 'bytes',
            'Content-Security-Policy'       => "frame-ancestors *",
        ];

        return Storage::disk('public')->response($path, null, $headers);
    }
}
