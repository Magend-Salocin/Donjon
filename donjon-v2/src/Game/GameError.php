<?php

declare(strict_types=1);

namespace Donjon\Game;

use RuntimeException;

/** Action refusée par une règle du jeu. Le message est affiché tel quel au joueur. */
final class GameError extends RuntimeException
{
}
