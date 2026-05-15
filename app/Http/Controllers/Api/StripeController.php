<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Stripe\Stripe;
use Stripe\Account;
use Stripe\AccountLink;

class StripeController extends Controller
{
    public function __construct()
    {
        Stripe::setApiKey(env('STRIPE_SECRET'));
    }

    /**
     * Create or retrieve Stripe Connect Express account link
     */
    public function createAccount(Request $request)
    {
        $user = $request->user();

        if (!$user->stripe_account_id) {
            $account = Account::create([
                'type' => 'express',
                'country' => 'FR', // À adapter selon vos besoins
                'email' => $user->email,
                'business_type' => 'individual',
                'capabilities' => [
                    'transfers' => ['requested' => true],
                ],
            ]);

            $user->update([
                'stripe_account_id' => $account->id,
            ]);
        }

        // L'URL vers laquelle Stripe redirigera après succès ou rafraîchissement
        $returnUrl = env('APP_URL') . '/api/stripe/success';
        $refreshUrl = env('APP_URL') . '/api/stripe/refresh';

        $accountLink = AccountLink::create([
            'account' => $user->stripe_account_id,
            'refresh_url' => $refreshUrl,
            'return_url' => $returnUrl,
            'type' => 'account_onboarding',
        ]);

        return response()->json([
            'success' => true,
            'url' => $accountLink->url
        ]);
    }

    /**
     * Check if onboarding is complete
     */
    public function accountStatus(Request $request)
    {
        $user = $request->user();

        if (!$user->stripe_account_id) {
            return response()->json(['is_completed' => false]);
        }

        try {
            $account = Account::retrieve($user->stripe_account_id);
            
            $isCompleted = $account->details_submitted;

            \Log::info('Stripe account status', [
                'account_id' => $user->stripe_account_id,
                'details_submitted' => $account->details_submitted,
                'payouts_enabled' => $account->payouts_enabled,
                'charges_enabled' => $account->charges_enabled,
            ]);

            if ($isCompleted && !$user->stripe_onboarding_complete) {
                $user->update(['stripe_onboarding_complete' => true]);
            }

            return response()->json([
                'complete' => $isCompleted,
                'is_completed' => $isCompleted,
                'details_submitted' => $account->details_submitted,
                'payouts_enabled' => $account->payouts_enabled,
                'account_id' => $user->stripe_account_id
            ]);
        } catch (\Exception $e) {
            return response()->json(['is_completed' => false, 'error' => $e->getMessage()], 400);
        }
    }

    /**
     * Lien vers le tableau de bord Express Stripe du professionnel
     */
    public function dashboardLink(Request $request)
    {
        $user = $request->user();

        if (!$user->stripe_account_id) {
            return response()->json(['success' => false, 'message' => 'Aucun compte Stripe configuré.'], 404);
        }

        try {
            $loginLink = \Stripe\Account::createLoginLink($user->stripe_account_id);
            return response()->json([
                'success' => true,
                'url' => $loginLink->url,
            ]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => $e->getMessage()], 400);
        }
    }

    /**
     * Pages de redirection temporaires
     */
    public function returnSuccess()
    {
        return response("<html><body><h2>Merci ! Votre compte est configuré.</h2><p>Vous pouvez retourner sur l'application.</p></body></html>");
    }

    public function returnRefresh()
    {
        return response("<html><body><h2>Le lien a expiré.</h2><p>Veuillez relancer la procédure depuis l'application.</p></body></html>");
    }

    public function checkoutSuccess(Request $request)
    {
        $missionId = $request->query('mission_id');
        return response("<html><body style='font-family:sans-serif;text-align:center;padding:40px'>
            <h2 style='color:#2E7D32'>✅ Paiement effectué avec succès !</h2>
            <p>La mission #$missionId a été payée. Vous pouvez retourner sur l'application.</p>
        </body></html>");
    }

    public function checkoutCancel(Request $request)
    {
        $missionId = $request->query('mission_id');
        return response("<html><body style='font-family:sans-serif;text-align:center;padding:40px'>
            <h2 style='color:#D32F2F'>❌ Paiement annulé</h2>
            <p>Le paiement pour la mission #$missionId a été annulé. Retournez sur l'application pour réessayer.</p>
        </body></html>");
    }

    public function webhook(Request $request)
    {
        $payload = $request->getContent();
        $sigHeader = $request->header('Stripe-Signature');
        $webhookSecret = env('STRIPE_WEBHOOK_SECRET');

        try {
            Stripe::setApiKey(env('STRIPE_SECRET'));
            $event = \Stripe\Webhook::constructEvent($payload, $sigHeader, $webhookSecret);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 400);
        }

        if ($event->type === 'checkout.session.completed') {
            $session = $event->data->object;
            $missionId = $session->metadata->mission_id ?? null;
            if ($missionId) {
                $mission = \App\Models\Mission::find($missionId);
                if ($mission) {
                    $mission->update(['paiement_structure' => true]);
                    \Illuminate\Support\Facades\Log::info("Paiement structure confirmé pour mission #$missionId");
                }
            }
        }

        return response()->json(['received' => true]);
    }
}
