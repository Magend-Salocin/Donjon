# Lance le jeu sur http://localhost:8000 avec le serveur integre de PHP.
# Charge pdo_sqlite explicitement : l installation PHP de winget n a pas de php.ini.

param([int] $Port = 8000)

$php = (Get-Command php -ErrorAction Stop).Source
$extensionDir = Join-Path (Split-Path $php) 'ext'

Write-Host "Donjon de Naheulbeuk : http://localhost:$Port (Ctrl+C pour quitter)"
& $php -d "extension_dir=$extensionDir" -d extension=pdo_sqlite -S "localhost:$Port" -t (Join-Path $PSScriptRoot 'public')
