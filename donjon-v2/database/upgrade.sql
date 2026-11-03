-- Tables ajoutées après la v2 initiale. Exécuté à chaque ouverture de la base : chaque instruction doit pouvoir se rejouer.

-- Drapeaux de la taverne : ce que le héros a appris, accepté ou déjà reçu (voir .claude/kb/taverne/mecaniques.md).
CREATE TABLE IF NOT EXISTS drapeau (
    jou_num INTEGER NOT NULL REFERENCES joueur(num) ON DELETE CASCADE,
    nom     TEXT NOT NULL,
    PRIMARY KEY (jou_num, nom)
);
