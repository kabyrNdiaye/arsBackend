<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class SecurityHeaders
{
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);
        $response->headers->set('X-Content-Type-Options', 'nosniff');

        // Autoriser l'affichage des médias dans des iframes (utilisé sur Web)
        if (!$request->is('api/media*')) {
            $response->headers->set('X-Frame-Options', 'DENY');
        }


        $response->headers->set('Referrer-Policy', 'strict-origin-when-cross-origin');
        $response->headers->set('Permissions-Policy', 'geolocation=(), microphone=()');
        return $response;
    }
}