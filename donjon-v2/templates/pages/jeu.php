<?php
/**
 * Plateau du donjon (ancien Javascript/HeroQuest_V2/index.php).
 * Le plateau fait 26 colonnes sur 19 lignes ; chaque case est une image dont l'id est le numéro de case.
 *
 * @var array $hero
 * @var array $adventure
 * @var list<array> $questItems
 */

use Donjon\View;

$boardColumns = 26;
$boardRows = 19;

// Tableau LeMagend de la v1 : caractéristiques du héros indexées comme dans les modules JavaScript.
$leMagend = array_map('strval', [
    $hero['num'], $hero['nom'], $hero['pv'], $hero['pv2'], $hero['pm'], $hero['pm2'],
    $hero['forc'], $hero['end'], $hero['inti'], $hero['dext'], $hero['vit'], $hero['dext'],
    $hero['man'], $hero['ppm'], $hero['exp'], $hero['ors'], $hero['codeexp'], $hero['nivsuv'],
    $hero['cexp'], $hero['nbexp'], $hero['libellerace'], $hero['libellerang'], $hero['village'], $hero['image'],
    $hero['Arme'], $hero['Bouclier'], $hero['Casque'], $hero['Plastron'], $hero['AvantBras'], $hero['Botte'], $hero['Jambiere'],
    $hero['sexe'],
]);
$json = static fn (mixed $value): string => json_encode($value, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_UNESCAPED_UNICODE);
$questNumber = (int) $adventure['code'];
$dice = static fn (string $prefix): string => implode('', array_map(
    static fn (int $i): string => '<img src="' . asset('game/images/dee/neutre.svg') . '" class="Cache" id="' . $prefix . $i . '" alt="">',
    range(0, 7)
));
?>
<link rel="stylesheet" href="<?= asset('game/game.css') ?>">

<div id="body-fullside" class="quest">
    <h2 class="center"><?= e($adventure['libelle']) ?></h2>

    <div id="Centre" class="Centre">
        <div id="myOtherElement" class="demoElement">
            <div id="scroll_top"><span id="scroll_header"><span id="CarteTitre"></span></span></div>
            <div id="scroll_middle"><div id="CarteDescription"></div></div>
            <div id="scroll_bottom">
                <a href="javascript:void(0)" onclick="RetireStyle('myOtherElement')" id="FermerTresor">Fermer</a>
            </div>
        </div>

        <div id="myHeroItem" class="quest-inventory">
            <h3>Les objets de votre inventaire</h3>
            <div id="myHeroItemListe"><?= View::render('partials/quest-inventory', ['questItems' => $questItems]) ?></div>
            <button type="button" class="link" onclick="CacherElement('myHeroItem')">Fermer</button>
        </div>
    </div>

    <!-- Plateau à gauche, fiche du héros à droite (dessous sur écran étroit) -->
    <div class="quest-grille">
        <div class="plateau-zone">
            <canvas id="board-iso" width="728" height="460" style="display:none"></canvas>
            <table id="board" style="background-image:url('<?= asset('game/quests/quest' . $questNumber . '.jpg') ?>')">
                <?php for ($row = 0; $row < $boardRows; $row++): ?>
                    <tr>
                        <?php for ($column = 0; $column < $boardColumns; $column++): ?>
                            <?php $cell = $row * $boardColumns + $column ?>
                            <td class="FondNoir"><img src="<?= asset('game/images/08.jpg') ?>" id="<?= $cell ?>" alt=""></td>
                        <?php endfor ?>
                    </tr>
                <?php endfor ?>
            </table>
        </div>
        <div class="quest-cote">
            <p class="plateau-outils"><button type="button" id="board-vue" style="display:none" onclick="IsoBasculerVue()">Vue de dessus</button>
                <button type="button" id="plein-ecran" style="display:none" onclick="BasculerPleinEcran()">Plein écran</button>
                <button type="button" id="fiche-heros" style="display:none" aria-expanded="false" aria-controls="quest-fiche" onclick="IsoBasculerFiche()">Fiche du héros</button></p>
            <!-- En vue classique, la fiche est cachée (le livre montre déjà portrait, caractéristiques et actions) et s'ouvre par-dessus le plateau -->
            <div class="quest-fiche" id="quest-fiche">
                <div id="CarteJoueurAventure" class="parchemin hero-board">
                    <div id="MenuJoueur">
                        <div class="actions">
                            <button type="button" class="ActionJeu" onclick="Lancerdee()" id="Mn_Deplacement">Lancer les dés</button>
                            <button type="button" class="ActionJeu" onclick="LancerdeeAttaque()" id="Mn_Attaquer">Attaquer</button>
                            <button type="button" class="ActionJeu" onclick="TirerUneCarteTresor()" id="Mn_Tresor">Chercher un trésor</button>
                            <button type="button" class="ActionJeu" onclick="DeactiverLesPieges()" id="Mn_Piege">Chercher les pièges</button>
                            <button type="button" class="ActionJeu" onclick="AfficherElement('myHeroItem')" id="Mn_Objet">Utiliser un objet</button>
                            <button type="button" class="ActionJeu fin-tour" onclick="FinTour()" id="Mn_FinTour">Fin de tour</button>
                        </div>
                        <div class="hero-infos">
                            <p class="hero-nom"><strong><?= e($hero['nom']) ?></strong> <?= e($hero['libellerace']) ?> · Niveau <?= (int) $hero['codeexp'] ?> · <span id="MyHeroOrs"><?= (int) $hero['ors'] ?></span> or</p>
                            <p class="fiche-jauge hero-vie"><span>Vie</span> <span id="MyHeroPv"><?= (int) $hero['pv2'] ?></span> / <?= (int) $hero['pv'] ?>
                                <?= progress_bar((int) $hero['pv2'], (int) $hero['pv'], 'vie', 'MyHeroBarrePv') ?></p>
                            <p class="fiche-jauge hero-magie"><span>Magie</span> <?= (int) $hero['pm2'] ?> / <?= (int) $hero['pm'] ?>
                                <?= progress_bar((int) $hero['pm2'], (int) $hero['pm'], 'magie') ?></p>
                            <p class="hero-des">Déplacement <img src="<?= asset('game/images/dee/neutre.svg') ?>" id="Dee1" class="die" alt="Dé non lancé"> <img src="<?= asset('game/images/dee/neutre.svg') ?>" id="Dee2" class="die" alt="Dé non lancé"> <span id="DeplacementRestant" aria-live="polite"></span></p>
                            <p class="hero-monstres">Monstres restants : <strong id="NbMonstre"></strong></p>
                        </div>
                    </div>

                    <div id="MenuCombat" style="display:none;">
                        <table id="FenetreCombat">
                            <tr>
                                <td rowspan="2"><img id="Attaquant" style="display:none;" src="" alt=""></td>
                                <td><span class="dice-label">Attaque</span><?= $dice('DA') ?></td>
                                <td rowspan="2"><img id="Defenceur" style="display:none;" src="" alt=""></td>
                            </tr>
                            <tr>
                                <td><span class="dice-label">Défense</span><?= $dice('DD') ?></td>
                            </tr>
                        </table>
                        <p id="BilanCombat" class="center" aria-live="polite"></p>
                        <span id="TourMonstre" style="display:none;"></span>
                    </div>
                </div>
                <p id="TourJoueur" class="center" aria-live="polite"></p>
                <div class="center abandon">
                    <?= action_button('abandon-adventure', 'Abandonner l\'aventure', 'aventures') ?>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var ApiUrl = 'api.php';
    var CsrfToken = <?= $json(csrf_token()) ?>;
    var MyHeroNum = <?= $json((string) $hero['num']) ?>;
    var LeMagend = <?= $json($leMagend) ?>;
</script>
<script src="<?= asset('game/compat.js') ?>"></script>
<script src="<?= asset('game/MesItem.js') ?>"></script>
<script src="<?= asset('game/quests/quest' . $questNumber . '.js') ?>"></script>
<script>
    //  Nom - Attaque - Defence - Corp - Esprit - Position - Image - Piece - Attaquer - ChercherTresor - Or - deplacement - JOUEUR - ImageCombat
    LesJoueurs[LesJoueurs.length] = [
        LeMagend[1], Math.min(8, <?= max(1, (int) $hero['forc']) ?>), Math.min(8, <?= max(1, (int) $hero['end']) ?>),
        <?= max(1, (int) $hero['pv2']) ?>, 2, PositionDepart, <?= $json(hero_token($hero)) ?>, PieceDepart,
        0, 0, <?= (int) $hero['ors'] ?>, 0, LeMagend, <?= $json(hero_fighter($hero)) ?>
    ];
</script>
<script src="<?= asset('game/ModuleDes.js') ?>"></script>
<script src="<?= asset('game/ModuleActionJeu.js') ?>"></script>
<script src="<?= asset('game/ModulePiece.js') ?>"></script>
<script src="<?= asset('game/ModulePersonnage.js') ?>"></script>
<script src="<?= asset('game/ModuleIAMonstre.js') ?>"></script>
<script src="<?= asset('game/ModuleCombat.js') ?>"></script>
<script src="<?= asset('game/ModuleCarteTresor.js') ?>"></script>
<script src="<?= asset('game/ModuleCarteHero.js') ?>"></script>
<script src="<?= asset('game/ModuleSave.js') ?>"></script>
<script src="<?= asset('game/ModuleMulti.js') ?>"></script>
<script src="<?= asset('game/iso/atlas.js') ?>"></script>
<script src="<?= asset('game/ModulePleinEcran.js') ?>"></script>
<script src="<?= asset('game/ModuleIso.js') ?>"></script>
<script>
    SetMesObjet(<?= $json($questItems) ?>);
    window.addEventListener('load', initialiserJeux);
</script>
