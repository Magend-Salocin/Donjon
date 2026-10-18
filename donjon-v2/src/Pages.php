<?php

declare(strict_types=1);

namespace Donjon;

use Donjon\Game\Progression;
use Donjon\Repository\Players;

/**
 * Prépare les données de chaque page. Chaque méthode publique correspond à une valeur de ?page=
 * et renvoie les variables du template templates/pages/{page}.php.
 * Clés réservées : title (titre de la page), side (true pour afficher le menu latéral).
 */
final class Pages
{
    public const PUBLIC_PAGES = ['connexion', 'inscription', 'aide', 'version'];

    public const PRIVATE_PAGES = [
        'personnage', 'equipement', 'inventaire', 'messagerie', 'compte', 'niveau',
        'village', 'magasin', 'aventures', 'voyager', 'taverne', 'defis', 'defier', 'combat', 'jeu',
    ];

    public function __construct(private readonly App $app, private readonly ?array $hero, private readonly ?array $journey)
    {
    }

    public function connexion(): array
    {
        return ['title' => 'Connexion'];
    }

    public function inscription(): array
    {
        $form = $_SESSION['form'] ?? ['nom' => '', 'email' => ''];
        unset($_SESSION['form']);

        return ['title' => 'Inscription', 'races' => $this->app->world->races(), 'form' => $form];
    }

    public function aide(): array
    {
        return ['title' => 'Aide', 'side' => $this->hero !== null];
    }

    public function version(): array
    {
        return ['title' => 'Version', 'side' => $this->hero !== null];
    }

    public function personnage(): array
    {
        return ['title' => 'Personnage', 'side' => true, 'journey' => $this->journey];
    }

    public function equipement(): array
    {
        return ['title' => 'Équipement', 'side' => true, 'slots' => Players::EQUIPMENT_SLOTS];
    }

    public function inventaire(): array
    {
        $heroId = (int) $this->hero['num'];

        return [
            'title' => 'Inventaire',
            'side' => true,
            'items' => $this->app->items->inventory($heroId, ['item']),
            'questItems' => $this->app->items->inventory($heroId, ['quete']),
            'equipment' => $this->app->items->inventory($heroId, ['equip']),
        ];
    }

    public function messagerie(): array
    {
        $mode = (string) ($_GET['msg'] ?? 'boite');
        $message = null;
        if ($mode === 'lire') {
            $message = $this->app->messages->find((int) ($_GET['id'] ?? 0), $this->hero['nom']);
            if ($message === null) {
                redirect('messagerie');
            }
            $this->app->messages->markRead((int) $message['code'], $this->hero['nom']);
        }

        return [
            'title' => 'Messagerie',
            'side' => true,
            'mode' => in_array($mode, ['boite', 'ecrire', 'lire'], true) ? $mode : 'boite',
            'inbox' => $mode === 'boite' ? $this->app->messages->inbox($this->hero['nom']) : [],
            'message' => $message,
            'recipient' => (string) ($_GET['a'] ?? ''),
        ];
    }

    public function compte(): array
    {
        return ['title' => 'Mon compte', 'side' => true];
    }

    public function niveau(): array
    {
        if ((int) $this->hero['cexp'] !== 1) {
            flash('info', "Vous n'avez pas encore assez d'expérience pour passer au niveau suivant.");
            redirect('personnage');
        }

        return ['title' => 'Niveau supérieur', 'side' => true, 'stats' => Progression::TRAINABLE_STATS];
    }

    public function village(): array
    {
        return [
            'title' => 'Village',
            'village' => $this->app->world->village($this->hero['village']),
            'buildings' => $this->app->world->buildings($this->hero['village']),
        ];
    }

    public function magasin(): array
    {
        $shop = $this->app->world->shop((string) ($_GET['code'] ?? ''), $this->hero['village']);
        if ($shop === null) {
            redirect('village');
        }

        return ['title' => $shop['libelle'], 'side' => true, 'shop' => $shop, 'offers' => $this->app->world->offers($shop['code'])];
    }

    public function aventures(): array
    {
        $gradeCode = $this->app->world->gradeCode($this->hero['libellerang']);

        return [
            'title' => 'Aventures',
            'side' => true,
            'adventures' => $this->app->world->adventures($gradeCode, $this->hero['village']),
            'missions' => $this->app->world->missionCountsByGrade((int) $this->hero['num']),
            'current' => $this->app->progression->currentAdventure($this->hero),
        ];
    }

    public function voyager(): array
    {
        return [
            'title' => 'Voyager',
            'village' => $this->app->world->village($this->hero['village']),
            'destinations' => $this->app->world->destinations($this->hero['village']),
            'journey' => $this->journey,
        ];
    }

    public function taverne(): array
    {
        return [
            'title' => 'Taverne',
            'side' => true,
            'village' => $this->app->world->village($this->hero['village']),
            'chat' => array_reverse($this->app->chat->latest($this->hero['village'])),
        ];
    }

    public function defis(): array
    {
        $heroId = (int) $this->hero['num'];

        return [
            'title' => 'Défis',
            'side' => true,
            'received' => $this->app->duels->received($heroId),
            'sent' => $this->app->duels->sent($heroId),
            'perDay' => (int) $this->app->config['duels_per_day'],
        ];
    }

    public function defier(): array
    {
        return [
            'title' => 'Défier un héros',
            'side' => true,
            'perDay' => (int) $this->app->config['duels_per_day'],
            'village' => $this->app->world->village($this->hero['village']),
            'online' => $this->app->players->onlineInVillage(
                $this->hero['village'],
                (int) $this->hero['num'],
                (int) $this->app->config['online_window']
            ),
        ];
    }

    public function combat(): array
    {
        $result = $_SESSION['combat'] ?? null;
        unset($_SESSION['combat']);
        if ($result === null) {
            redirect('defis');
        }

        return ['title' => 'Combat', 'side' => true, 'result' => $result];
    }

    public function jeu(): array
    {
        $adventure = $this->app->progression->currentAdventure($this->hero);
        if ($adventure === null) {
            flash('info', 'Choisissez une aventure pour entrer dans le donjon.');
            redirect('aventures');
        }

        return [
            'title' => $adventure['libelle'],
            'adventure' => $adventure,
            'questItems' => $this->app->items->inventory((int) $this->hero['num'], ['item', 'quete']),
        ];
    }
}
