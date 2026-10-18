<?php

declare(strict_types=1);

namespace Donjon;

final class View
{
    /** Rend templates/{$template}.php avec les variables fournies. */
    public static function render(string $template, array $vars = []): string
    {
        extract($vars, EXTR_SKIP);
        ob_start();
        require ROOT_DIR . '/templates/' . $template . '.php';

        return (string) ob_get_clean();
    }
}
