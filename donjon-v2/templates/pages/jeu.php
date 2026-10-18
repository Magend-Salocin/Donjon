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
]);
$json = static fn (mixed $value): string => json_encode($value, JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT | JSON_UNESCAPED_UNICODE);
$questNumber = (int) $adventure['code'];
$dice = static fn (string $prefix): string => implode('', array_map(
    static fn (int $i): string => '<img src="' . asset('game/images/dee/E01.png') . '" class="Cache die" id="' . $prefix . $i . '" alt="">',
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

    <div id="CarteJoueurAventure" class="hero-board">
        <div id="MenuJoueur">
            <div class="center actions">
                <a href="javascript:void(0)" class="ActionJeu" onclick="DeactiverLesPieges()" id="Mn_Piege">Piège</a>
                <a href="javascript:void(0)" class="ActionJeu" onclick="LancerdeeAttaque()" id="Mn_Attaquer">Attaquer</a>
                <a href="javascript:void(0)" class="ActionJeu" onclick="Lancerdee()" id="Mn_Deplacement">Lancer les dés</a>
                <a href="javascript:void(0)" class="ActionJeu" onclick="TirerUneCarteTresor()" id="Mn_Tresor">Tirer une carte trésor</a>
                <a href="javascript:void(0)" class="ActionJeu" onclick="AfficherElement('myHeroItem')" id="Mn_Objet">Utiliser objet</a>
                <a href="javascript:void(0)" class="ActionJeu" onclick="FinTour()" id="Mn_FinTour">Fin de tour</a>
            </div>
            <div class="hero-line">
                <span><?= e($hero['nom']) ?> : <?= e($hero['libellerace']) ?> - Niveau <?= (int) $hero['codeexp'] ?> - Or : <strong id="MyHeroOrs"><?= (int) $hero['ors'] ?></strong></span>
                <span>Déplacement : <img src="<?= asset('game/images/dee/Dee.gif') ?>" id="Dee1" alt=""> <img src="<?= asset('game/images/dee/Dee.gif') ?>" id="Dee2" alt=""></span>
                <span>Monstres restants : <span id="NbMonstre"></span></span>
            </div>
            <div class="hero-line">
                <span><strong>Vie :</strong> <span id="MyHeroPv"><?= (int) $hero['pv2'] ?></span>/<?= (int) $hero['pv'] ?>
                    <?= progress_bar((int) $hero['pv2'], (int) $hero['pv'], 'vie', 'MyHeroBarrePv') ?></span>
                <span><strong>Magie :</strong> <?= (int) $hero['pm2'] ?>/<?= (int) $hero['pm'] ?>
                    <?= progress_bar((int) $hero['pm2'], (int) $hero['pm'], 'magie') ?></span>
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
            <span id="TourMonstre" style="display:none;"></span>
        </div>
    </div>
    <p id="TourJoueur" class="center"></p>
    <div class="center">
        <?= action_button('abandon-adventure', 'Abandonner l\'aventure', 'aventures') ?>
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
        <?= max(1, (int) $hero['pv2']) ?>, 2, PositionDepart, <?= $json(race_token($hero['libellerace'])) ?>, PieceDepart,
        0, 0, <?= (int) $hero['ors'] ?>, 0, LeMagend, <?= $json(race_fighter($hero['libellerace'])) ?>
    ];
</script>
<script src="<?= asset('game/ModuleActionJeu.js') ?>"></script>
<script src="<?= asset('game/ModulePiece.js') ?>"></script>
<script src="<?= asset('game/ModulePersonnage.js') ?>"></script>
<script src="<?= asset('game/ModuleIAMonstre.js') ?>"></script>
<script src="<?= asset('game/ModuleCombat.js') ?>"></script>
<script src="<?= asset('game/ModuleCarteTresor.js') ?>"></script>
<script src="<?= asset('game/ModuleCarteHero.js') ?>"></script>
<script src="<?= asset('game/ModuleSave.js') ?>"></script>
<script src="<?= asset('game/ModuleMulti.js') ?>"></script>
<script>
    SetMesObjet(<?= $json($questItems) ?>);
    window.addEventListener('load', initialiserJeux);
</script>
