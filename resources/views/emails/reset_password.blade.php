<!DOCTYPE html>
<html>
<head>
    <title>Réinitialisation de mot de passe</title>
</head>
<body style="font-family: Arial, sans-serif; line-height: 1.6; color: #333;">
    <h2>Bonjour,</h2>
    <p>Vous avez demandé la réinitialisation de votre mot de passe pour votre compte ARS.</p>
    <p>Votre jeton (token) de réinitialisation est le suivant :</p>
    <div style="background: #f4f4f4; padding: 15px; border-radius: 5px; font-weight: bold; text-align: center; font-size: 1.2em; letter-spacing: 2px;">
        {{ $token }}
    </div>
    <p>Veuillez copier ce code dans votre application pour définir votre nouveau mot de passe.</p>
    <p>Si vous n'avez pas demandé ce changement, vous pouvez ignorer cet e-mail en toute sécurité.</p>
    <br>
    <p>Merci,<br>L'équipe ARS</p>
</body>
</html>
