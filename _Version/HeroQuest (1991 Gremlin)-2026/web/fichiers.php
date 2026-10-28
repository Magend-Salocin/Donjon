<?php
// Fichiers du jeu d'origine pour la page (web/jeu/principal.js).
//   GET  fichiers.php            tous les fichiers en une archive : pour chacun, longueur du nom
//                                (1 octet), nom, taille (4 octets, petit-boutiste), contenu
//   GET  fichiers.php?nom=X      contenu de X (la sauvegarde du joueur si elle existe)
//   POST fichiers.php?nom=X      enregistre X, seulement pour les fichiers que le jeu écrit
// Les fichiers d'origine ne sont jamais modifiés : les écritures vont dans sauvegardes/.

declare(strict_types=1);

const JEU = __DIR__ . '/../../HeroQuest (1991 Gremlin)';
const SAUVEGARDES = __DIR__ . '/sauvegardes';
const ECRITS = ['QUEST.SAV', 'QUEST.CFG'];
// Un seul affichage (VGA) et un seul son (AdLib) : les fichiers des autres versions ne sont pas servis.
const ECARTES = '/\.(EGA|PIF|MD)$|^(TANDY|MT32)\.DRV$/';

function nomValide(string $nom): bool
{
    return preg_match('/^[A-Z0-9&_-]{1,8}\.[A-Z0-9]{1,3}$/', $nom) === 1;
}

// Le nom réel du fichier, quelle que soit sa casse (les noms DOS sont en majuscules).
function chemin(string $nom): ?string
{
    foreach ([SAUVEGARDES, JEU] as $dossier) {
        foreach (is_dir($dossier) ? scandir($dossier) : [] as $fichier) {
            if (strtoupper($fichier) === $nom && is_file($dossier . '/' . $fichier)) {
                return $dossier . '/' . $fichier;
            }
        }
    }
    return null;
}

$nom = strtoupper((string)($_GET['nom'] ?? ''));

if ($nom === '') {
    $noms = array_map('strtoupper', array_values(array_filter(
        scandir(JEU) ?: [],
        fn ($f) => is_file(JEU . '/' . $f) && nomValide(strtoupper($f)) && !preg_match(ECARTES, strtoupper($f))
    )));
    foreach (ECRITS as $ecrit) {
        if (is_file(SAUVEGARDES . '/' . $ecrit) && !in_array($ecrit, $noms, true)) {
            $noms[] = $ecrit;
        }
    }
    header('Content-Type: application/octet-stream');
    header('Cache-Control: no-cache');
    foreach ($noms as $n) {
        $contenu = file_get_contents(chemin($n));
        echo chr(strlen($n)), $n, pack('V', strlen($contenu)), $contenu;
    }
    exit;
}

if (!nomValide($nom)) {
    http_response_code(400);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!in_array($nom, ECRITS, true)) {
        http_response_code(403);
        exit;
    }
    if (!is_dir(SAUVEGARDES)) {
        mkdir(SAUVEGARDES, 0775, true);
    }
    file_put_contents(SAUVEGARDES . '/' . $nom, file_get_contents('php://input'));
    http_response_code(204);
    exit;
}

$chemin = chemin($nom);
if ($chemin === null) {
    http_response_code(404);
    exit;
}
header('Content-Type: application/octet-stream');
header('Cache-Control: no-cache');
readfile($chemin);
