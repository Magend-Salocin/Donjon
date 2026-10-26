# Lance HeroQuest dans DOSBox-X (C:\DOSBox-X) sur une copie de travail du jeu, car le jeu écrit QUEST.SAV.
#   .\lancer-dosbox.ps1            jeu complet (HERO.EXE : intro puis jeu)
#   .\lancer-dosbox.ps1 -Debug     QUEST.EXE sous le débogueur, arrêté sur la première instruction (voir DEBOGUER.md)
#   .\lancer-dosbox.ps1 -Neuf      recopie le jeu d'origine dans la copie de travail avant de lancer

param([switch] $Debug, [switch] $Neuf)

$ErrorActionPreference = 'Stop'
$racine = Split-Path $PSScriptRoot -Parent
$original = Join-Path (Split-Path $racine -Parent) 'HeroQuest (1991 Gremlin)'
$travail = Join-Path $racine 'travail'
$jeu = Join-Path $travail 'jeu'
$dosbox = 'C:\DOSBox-X\dosbox-x.exe'

if ($Neuf -and (Test-Path $jeu)) { Remove-Item $jeu -Recurse -Force }
if (-not (Test-Path $jeu)) {
    New-Item -ItemType Directory -Force $jeu | Out-Null
    Get-ChildItem $original -File | Where-Object { $_.Extension -ne '.md' } | Copy-Item -Destination $jeu
}

# LOADFIX réserve les 64 premiers Ko : sans lui, le décompresseur EXEPACK du jeu échoue
# (« Packed file is corrupt ») quand le programme est chargé trop bas en mémoire.
$programme = if ($Debug) { 'DEBUGBOX QUEST.EXE' } else { 'HERO.EXE' }
& $dosbox -conf (Join-Path $PSScriptRoot 'dosbox-x.conf') -set "log logfile=$(Join-Path $travail 'dosbox-x.log')" `
    -c "MOUNT C '$jeu'" -c 'C:' -c 'LOADFIX' -c $programme
