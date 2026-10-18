<?php

declare(strict_types=1);

namespace Donjon;

use Donjon\Game\Duel;
use Donjon\Game\Inventory;
use Donjon\Game\Progression;
use Donjon\Game\Travel;
use Donjon\Repository\Chat;
use Donjon\Repository\Duels;
use Donjon\Repository\Items;
use Donjon\Repository\Messages;
use Donjon\Repository\Players;
use Donjon\Repository\World;

/** Point d'accès unique aux dépôts de données et aux règles du jeu. */
final class App
{
    public readonly Players $players;
    public readonly Items $items;
    public readonly World $world;
    public readonly Messages $messages;
    public readonly Duels $duels;
    public readonly Chat $chat;

    public readonly Inventory $inventory;
    public readonly Progression $progression;
    public readonly Travel $travel;
    public readonly Duel $duel;

    public function __construct(public readonly Database $db, public readonly array $config)
    {
        $this->players = new Players($db);
        $this->items = new Items($db);
        $this->world = new World($db);
        $this->messages = new Messages($db);
        $this->duels = new Duels($db);
        $this->chat = new Chat($db);

        $this->inventory = new Inventory($this->players, $this->items);
        $this->progression = new Progression($db, $this->players, $this->world);
        $this->travel = new Travel($this->players, $this->world);
        $this->duel = new Duel($this->players, $this->duels, (int) $config['duels_per_day']);
    }
}
