<?php

declare(strict_types=1);

namespace Donjon;

use Donjon\Game\GameError;

/**
 * Traitement des formulaires (POST). Chaque action se termine par une redirection
 * pour qu'un rafraîchissement de la page ne rejoue pas l'action.
 */
final class Actions
{
    public function __construct(private readonly App $app, private readonly ?array $hero)
    {
    }

    public function handle(string $action): never
    {
        if (!csrf_is_valid($_POST['csrf'] ?? null)) {
            flash('erreur', 'Formulaire expiré, veuillez réessayer.');
            redirect($this->hero ? 'personnage' : 'connexion');
        }

        if ($this->hero === null) {
            match ($action) {
                'login' => $this->login(),
                'register' => $this->register(),
                default => redirect('connexion'),
            };
        }

        $hero = $this->hero;
        try {
            match ($action) {
                'change-password' => $this->changePassword($hero),
                'use-item' => $this->useItem($hero),
                'equip' => $this->equip($hero),
                'unequip' => $this->unequip($hero),
                'buy' => $this->buy($hero),
                'start-adventure' => $this->startAdventure($hero),
                'abandon-adventure' => $this->abandonAdventure($hero),
                'travel' => $this->travel($hero),
                'level-up' => $this->levelUp($hero),
                'send-message' => $this->sendMessage($hero),
                'delete-message' => $this->deleteMessage($hero),
                'challenge' => $this->challenge($hero),
                'delete-challenges' => $this->deleteChallenges($hero),
                'fight' => $this->fight($hero),
                'chat' => $this->chat($hero),
                default => redirect('personnage'),
            };
        } catch (GameError $error) {
            flash('erreur', $error->getMessage());
            redirect((string) ($_POST['retour'] ?? 'personnage'));
        }
    }

    private function login(): never
    {
        $player = $this->app->players->findByLogin(post_string('login'));
        if ($player === null || !password_verify((string) ($_POST['mdp'] ?? ''), $player['mdp_hash'])) {
            flash('erreur', "Nom d'utilisateur ou mot de passe incorrect.");
            redirect('connexion');
        }

        session_regenerate_id(true);
        $_SESSION['player_id'] = (int) $player['num'];
        redirect('personnage');
    }

    private function register(): never
    {
        $name = post_string('nom');
        $email = post_string('email');
        $password = (string) ($_POST['mdp'] ?? '');
        $race = $this->app->world->race(post_string('race'));

        $errors = [];
        if (!preg_match('/^[\p{L}]{3,20}$/u', $name)) {
            $errors[] = 'Votre nom de héros doit contenir de 3 à 20 lettres, sans espace.';
        } elseif ($this->app->players->nameExists($name)) {
            $errors[] = 'Ce nom de héros existe déjà.';
        }
        if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
            $errors[] = "L'e-mail doit correspondre à un format valide.";
        } elseif ($this->app->players->emailExists($email)) {
            $errors[] = 'Cet e-mail est déjà utilisé.';
        }
        if (strlen($password) < 6) {
            $errors[] = 'Le mot de passe doit contenir au moins 6 caractères.';
        } elseif ($password !== ($_POST['mdp2'] ?? '')) {
            $errors[] = 'Les mots de passe doivent être identiques.';
        }
        if ($race === null) {
            $errors[] = 'Sélectionnez une race dans la liste.';
        }

        if ($errors !== []) {
            foreach ($errors as $error) {
                flash('erreur', $error);
            }
            $_SESSION['form'] = ['nom' => $name, 'email' => $email];
            redirect('inscription');
        }

        $this->app->players->create($email, $name, $password, $race);
        flash('ok', 'Inscription validée ! Connectez-vous avec votre nom de héros.');
        redirect('connexion');
    }

    private function changePassword(array $hero): never
    {
        $new = (string) ($_POST['newMDP'] ?? '');
        if (!password_verify((string) ($_POST['oldMdp'] ?? ''), $hero['mdp_hash'])) {
            throw new GameError('Ancien mot de passe incorrect.');
        }
        if (strlen($new) < 6 || $new !== ($_POST['confMDP'] ?? '')) {
            throw new GameError('Le nouveau mot de passe doit contenir au moins 6 caractères et être confirmé.');
        }

        $this->app->players->update((int) $hero['num'], ['mdp_hash' => password_hash($new, PASSWORD_DEFAULT)]);
        flash('ok', 'Mot de passe changé.');
        redirect('compte');
    }

    private function useItem(array $hero): never
    {
        flash('ok', $this->app->inventory->use($hero, post_int('objet')));
        redirect('inventaire');
    }

    private function equip(array $hero): never
    {
        flash('ok', $this->app->inventory->equip($hero, post_int('objet')));
        redirect('inventaire');
    }

    private function unequip(array $hero): never
    {
        flash('ok', $this->app->inventory->unequip($hero, post_string('emplacement')));
        redirect('equipement');
    }

    private function buy(array $hero): never
    {
        $shop = $this->app->world->shop(post_string('magasin'), $hero['village'])
            ?? throw new GameError("Cette boutique n'est pas dans votre village.");
        $itemNum = post_int('objet');
        $offer = $this->app->world->offer($shop['code'], $itemNum);

        if ($offer === null) {
            flash('erreur', "Cet objet n'est plus en stock.");
        } elseif ((int) $hero['ors'] < (int) $offer['prix']) {
            flash('erreur', "Vous n'avez pas assez d'or.");
        } else {
            $this->app->db->transaction(function () use ($hero, $shop, $itemNum, $offer): void {
                $this->app->items->add((int) $hero['num'], $itemNum);
                $this->app->players->update((int) $hero['num'], ['ors' => (int) $hero['ors'] - (int) $offer['prix']]);
                $this->app->world->decrementStock($shop['code'], $itemNum);
            });
            flash('ok', "Vous venez d'acquérir l'objet sélectionné.");
        }

        redirect('magasin', ['code' => $shop['code']]);
    }

    private function startAdventure(array $hero): never
    {
        $this->app->progression->startAdventure($hero, post_int('aventure'));
        redirect('jeu');
    }

    private function abandonAdventure(array $hero): never
    {
        flash('info', $this->app->progression->finishAdventure($hero, false));
        redirect('aventures');
    }

    private function travel(array $hero): never
    {
        flash('ok', $this->app->travel->start($hero, post_string('village')));
        redirect('personnage');
    }

    private function levelUp(array $hero): never
    {
        flash('ok', $this->app->progression->spendPoint($hero, post_string('stat')));
        redirect('niveau');
    }

    private function sendMessage(array $hero): never
    {
        $to = $this->app->players->findByName(post_string('pseudo_msg'));
        $subject = limit_text(post_string('sujet_msg'), 100);
        $content = post_string('text_msg');
        if ($to === null) {
            throw new GameError("Aucun héros ne porte ce nom.");
        }
        if ($subject === '' || $content === '') {
            throw new GameError('Le sujet et le message sont obligatoires.');
        }

        $this->app->messages->send($to['nom'], $hero['nom'], $subject, $content);
        flash('ok', "Message envoyé à {$to['nom']}.");
        redirect('messagerie');
    }

    private function deleteMessage(array $hero): never
    {
        $this->app->messages->delete(post_int('message'), $hero['nom']);
        flash('ok', 'Message effacé.');
        redirect('messagerie');
    }

    private function challenge(array $hero): never
    {
        flash('ok', $this->app->duel->challenge($hero, post_int('adversaire')));
        redirect('defier');
    }

    private function deleteChallenges(array $hero): never
    {
        $this->app->duels->deleteAll((int) $hero['num'], post_string('liste') === 'recus' ? 'heros' : 'MoiHeros');
        redirect('defis');
    }

    private function fight(array $hero): never
    {
        $_SESSION['combat'] = $this->app->duel->fight($hero, post_int('defi'));
        redirect('combat');
    }

    private function chat(array $hero): never
    {
        $message = limit_text(post_string('message'), 200);
        if ($message !== '') {
            $this->app->chat->post($hero['village'], $hero['nom'], $message);
        }
        redirect('taverne');
    }
}
