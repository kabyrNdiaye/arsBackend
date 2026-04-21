<?php

// Test script to verify registration endpoint
$url = 'http://localhost:8000/api/register';

// Test data for a professional
$professionalData = [
    'prenom' => 'Jean',
    'nom' => 'Dupont',
    'email' => 'prof_' . time() . '@example.com',
    'password' => 'password123',
    'password_confirmation' => 'password123',
    'role' => 'professionnel',
    'telephone' => '+221771234567',
    'adresse' => '123 Rue Test',
    'code_postal' => '12000',
    'ville' => 'Dakar',
    'date_naissance' => '1990-01-01',
    'lieu_naissance' => 'Dakar',
    'diplome' => 'Master en Soins Infirmiers',
    'annees_experience' => 5,
    'specialites' => ['Soins infirmiers', 'Gériatrie']
];

// Test data for a client (structure)
$clientData = [
    'prenom' => 'Marie',
    'nom' => 'Martin',
    'email' => 'client_' . time() . '@example.com',
    'password' => 'password123',
    'password_confirmation' => 'password123',
    'role' => 'client',
    'telephone' => '+221771234568',
    'adresse' => '456 Avenue Test',
    'code_postal' => '12001',
    'ville' => 'Dakar',
    'nom_etablissement' => 'Maison de Retraite Test',
    'type_etablissement' => 'EHPAD',
    'capacite' => 50,
    'fonction' => 'Directeur',
    'repas' => ['Petit-déjeuner', 'Déjeuner', 'Dîner'],
    'regimes' => ['Normal', 'Sans sel']
];

function testRegistration($url, $data, $type) {
    echo "\n========================================\n";
    echo "Testing $type Registration\n";
    echo "========================================\n";
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, [
        'Content-Type: application/json',
        'Accept: application/json'
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    echo "HTTP Status Code: $httpCode\n";
    echo "Response:\n";
    
    $responseData = json_decode($response, true);
    if ($responseData) {
        echo json_encode($responseData, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "\n";
        
        if (isset($responseData['success']) && $responseData['success']) {
            echo "\n✓ Registration successful!\n";
            if (isset($responseData['user'])) {
                echo "User ID: " . $responseData['user']['id'] . "\n";
                echo "Role: " . $responseData['user']['role'] . "\n";
                echo "Email: " . $responseData['user']['email'] . "\n";
            }
        } else {
            echo "\n✗ Registration failed!\n";
        }
    } else {
        echo $response . "\n";
        echo "\n✗ Invalid JSON response\n";
    }
}

// Test professional registration
testRegistration($url, $professionalData, 'Professional');

// Wait a second to ensure unique email
sleep(1);

// Test client registration
testRegistration($url, $clientData, 'Client');

echo "\n========================================\n";
echo "Tests completed!\n";
echo "========================================\n";
