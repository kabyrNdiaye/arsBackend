#!/usr/bin/env bash
# Exit on error
set -o errexit

echo "Installation des dépendances PHP..."
composer install --no-dev --optimize-autoloader

echo "Nettoyage du cache..."
php artisan optimize:clear

echo "Exécution des migrations..."
php artisan migrate --force
