<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Storage;
use App\Models\Document;

class MigrateDocumentsToPublic extends Command
{
    protected $signature   = 'documents:migrate-to-public {--dry-run : Simuler sans déplacer les fichiers}';
    protected $description = 'Migre tous les fichiers stockés sur le disk local vers le disk public';

    public function handle(): int
    {
        $dryRun = $this->option('dry-run');

        if ($dryRun) {
            $this->warn('Mode simulation (--dry-run) : aucun fichier ne sera déplacé.');
        }

        $documents = Document::all();
        $migrated  = 0;
        $skipped   = 0;
        $missing   = 0;

        $this->info("Analyse de {$documents->count()} documents...");
        $this->newLine();

        foreach ($documents as $doc) {
            $path = $doc->cheminFichier;

            // Déjà sur public → skip
            if (Storage::disk('public')->exists($path)) {
                $this->line("  <fg=green>✓ Déjà sur public :</> {$path}");
                $skipped++;
                continue;
            }

            // Existe sur local → migrer
            if (Storage::disk('local')->exists($path)) {
                $this->line("  <fg=yellow>→ Migration :</> {$path}");

                if (!$dryRun) {
                    // Lire depuis local, écrire sur public
                    $content = Storage::disk('local')->get($path);
                    Storage::disk('public')->put($path, $content);

                    // Supprimer l'ancien fichier local
                    Storage::disk('local')->delete($path);
                }

                $migrated++;
                continue;
            }

            // Introuvable sur les deux disks
            $this->line("  <fg=red>✗ Fichier manquant :</> {$path}");
            $missing++;
        }

        $this->newLine();
        $this->info("Résultat :");
        $this->line("  Migrés   : <fg=yellow>{$migrated}</>");
        $this->line("  Déjà OK  : <fg=green>{$skipped}</>");
        $this->line("  Manquants: <fg=red>{$missing}</>");

        if ($dryRun && $migrated > 0) {
            $this->newLine();
            $this->warn("Relance sans --dry-run pour effectuer la migration réelle.");
        }

        return Command::SUCCESS;
    }
}
