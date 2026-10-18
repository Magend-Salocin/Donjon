-- Schéma SQLite du Donjon de Naheulbeuk (v2).
-- Les noms de tables et de colonnes reprennent ceux de la base MySQL d'origine.

PRAGMA foreign_keys = ON;

CREATE TABLE race (
    code      TEXT PRIMARY KEY,
    libelle   TEXT NOT NULL,
    r_pv      INTEGER NOT NULL,
    r_pm      INTEGER NOT NULL,
    r_for     INTEGER NOT NULL,
    r_end     INTEGER NOT NULL,
    r_vit     INTEGER NOT NULL,
    r_int     INTEGER NOT NULL,
    r_dext    INTEGER NOT NULL,
    r_cha     INTEGER NOT NULL,
    r_man     INTEGER NOT NULL,
    r_ppm     INTEGER NOT NULL,
    r_village TEXT NOT NULL,
    r_image   TEXT NOT NULL
);

CREATE TABLE grade (
    code    INTEGER PRIMARY KEY,
    libelle TEXT NOT NULL UNIQUE
);

CREATE TABLE village (
    code    TEXT PRIMARY KEY,
    libelle TEXT NOT NULL,
    coord01 INTEGER NOT NULL,
    coord02 INTEGER NOT NULL,
    coord03 INTEGER NOT NULL,
    coord04 INTEGER NOT NULL
);

-- temps : durée du voyage en secondes. dure : libellé affiché.
CREATE TABLE villagealler (
    villagedep TEXT NOT NULL REFERENCES village(code),
    villagearv TEXT NOT NULL REFERENCES village(code),
    temps      INTEGER NOT NULL,
    dure       TEXT NOT NULL,
    PRIMARY KEY (villagedep, villagearv)
);

-- type : ce qui s'ouvre quand on clique sur le bâtiment dans le village.
CREATE TABLE magazin (
    code    TEXT PRIMARY KEY,
    libelle TEXT NOT NULL,
    coord01 INTEGER NOT NULL,
    coord02 INTEGER NOT NULL,
    coord03 INTEGER NOT NULL,
    coord04 INTEGER NOT NULL,
    village TEXT NOT NULL REFERENCES village(code),
    type    TEXT NOT NULL CHECK (type IN ('magasin', 'taverne', 'aventure'))
);

-- catheg : item (consommable), equip (équipement), quete (potion trouvée en donjon).
-- autre  : emplacement d'équipement (colonne de joueur) pour catheg = equip.
CREATE TABLE objet (
    num     INTEGER PRIMARY KEY,
    libelle TEXT NOT NULL,
    resumer TEXT NOT NULL,
    effet   TEXT NOT NULL,
    valeur  INTEGER NOT NULL,
    image   TEXT NOT NULL,
    catheg  TEXT NOT NULL CHECK (catheg IN ('item', 'equip', 'quete')),
    autre   TEXT NOT NULL DEFAULT ''
);

CREATE TABLE objetproposer (
    magazin TEXT NOT NULL REFERENCES magazin(code),
    objet   INTEGER NOT NULL REFERENCES objet(num),
    nb      INTEGER NOT NULL,
    prix    INTEGER NOT NULL,
    PRIMARY KEY (magazin, objet)
);

-- Le numéro de l'aventure désigne aussi la carte de donjon assets/game/quests/quest{code}.js.
CREATE TABLE aventure (
    code    INTEGER PRIMARY KEY,
    libelle TEXT NOT NULL,
    resumer TEXT NOT NULL,
    nbor    INTEGER NOT NULL,
    nbexp   INTEGER NOT NULL,
    rang    INTEGER NOT NULL REFERENCES grade(code),
    image   TEXT NOT NULL DEFAULT '',
    village TEXT NOT NULL REFERENCES village(code)
);

CREATE TABLE joueur (
    num         INTEGER PRIMARY KEY AUTOINCREMENT,
    email       TEXT NOT NULL UNIQUE,
    login       TEXT NOT NULL UNIQUE COLLATE NOCASE,
    mdp_hash    TEXT NOT NULL,
    nom         TEXT NOT NULL UNIQUE COLLATE NOCASE,
    pv          INTEGER NOT NULL,
    pv2         INTEGER NOT NULL,
    pm          INTEGER NOT NULL,
    pm2         INTEGER NOT NULL,
    forc        INTEGER NOT NULL,
    "end"       INTEGER NOT NULL,
    inti        INTEGER NOT NULL,
    dext        INTEGER NOT NULL,
    vit         INTEGER NOT NULL,
    cha         INTEGER NOT NULL,
    man         INTEGER NOT NULL,
    ppm         INTEGER NOT NULL,
    exp         INTEGER NOT NULL DEFAULT 0,
    ors         INTEGER NOT NULL DEFAULT 0,
    codeexp     INTEGER NOT NULL DEFAULT 1,
    nivsuv      INTEGER NOT NULL DEFAULT 150,
    cexp        INTEGER NOT NULL DEFAULT 0,
    nbexp       INTEGER NOT NULL DEFAULT 0,
    libellerace TEXT NOT NULL,
    libellerang TEXT NOT NULL DEFAULT 'Novice' REFERENCES grade(libelle),
    village     TEXT NOT NULL REFERENCES village(code),
    image       TEXT NOT NULL,
    Enligne     INTEGER NOT NULL DEFAULT 0,
    nbCombat    INTEGER NOT NULL DEFAULT 0,
    nbVictoire  INTEGER NOT NULL DEFAULT 0,
    NbCombatDay INTEGER NOT NULL DEFAULT 0,
    combat_jour TEXT NOT NULL DEFAULT '',
    Arme        TEXT NOT NULL DEFAULT 'rien',
    Bouclier    TEXT NOT NULL DEFAULT 'rien',
    Casque      TEXT NOT NULL DEFAULT 'rien',
    Plastron    TEXT NOT NULL DEFAULT 'rien',
    AvantBras   TEXT NOT NULL DEFAULT 'rien',
    Botte       TEXT NOT NULL DEFAULT 'rien',
    Jambiere    TEXT NOT NULL DEFAULT 'rien'
);

CREATE TABLE objethero (
    hero  INTEGER NOT NULL REFERENCES joueur(num) ON DELETE CASCADE,
    objet INTEGER NOT NULL REFERENCES objet(num),
    nb    INTEGER NOT NULL CHECK (nb > 0),
    PRIMARY KEY (hero, objet)
);

-- Nombre de fois qu'un joueur a terminé chaque aventure (sert au passage de grade).
CREATE TABLE accomplir (
    aven_num INTEGER NOT NULL REFERENCES aventure(code),
    jou_num  INTEGER NOT NULL REFERENCES joueur(num) ON DELETE CASCADE,
    nb       INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (aven_num, jou_num)
);

-- Action en cours d'un joueur : A = aventure (aven_num = code aventure), V = voyage (aven_num = village d'arrivée).
CREATE TABLE aventureencour (
    jou_num  INTEGER PRIMARY KEY REFERENCES joueur(num) ON DELETE CASCADE,
    aven_num TEXT NOT NULL,
    sec      INTEGER NOT NULL,
    libelle  TEXT NOT NULL CHECK (libelle IN ('A', 'V'))
);

-- Défi lancé par MoiHeros à heros.
CREATE TABLE avantcombat (
    num      INTEGER PRIMARY KEY AUTOINCREMENT,
    heros    INTEGER NOT NULL REFERENCES joueur(num) ON DELETE CASCADE,
    MoiHeros INTEGER NOT NULL REFERENCES joueur(num) ON DELETE CASCADE,
    village  TEXT NOT NULL,
    date     INTEGER NOT NULL
);

-- a et de contiennent des noms de héros.
CREATE TABLE message (
    code    INTEGER PRIMARY KEY AUTOINCREMENT,
    a       TEXT NOT NULL COLLATE NOCASE,
    de      TEXT NOT NULL,
    date    INTEGER NOT NULL,
    sujet   TEXT NOT NULL,
    contenu TEXT NOT NULL,
    lue     INTEGER NOT NULL DEFAULT 0
);

-- Remplace les fichiers Module/Chatte/{village}.txt de la v1.
CREATE TABLE chat (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    village TEXT NOT NULL,
    auteur  TEXT NOT NULL,
    message TEXT NOT NULL,
    date    INTEGER NOT NULL
);

CREATE INDEX idx_message_a ON message(a);
CREATE INDEX idx_chat_village ON chat(village, id);
CREATE INDEX idx_joueur_village_enligne ON joueur(village, Enligne);
