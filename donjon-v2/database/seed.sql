-- Données de référence, reprises du dump MySQL de 2007 (_Version/baseNAl.txt).
-- Les comptes joueurs de test de l'époque ne sont pas importés.

INSERT INTO grade (code, libelle) VALUES
(1, 'Novice'),
(2, 'Ecuyer'),
(3, 'Aventurier'),
(4, 'Legende');

INSERT INTO village (code, libelle, coord01, coord02, coord03, coord04) VALUES
('01', 'Valtordu', 200, 660, 280, 685),
('02', 'Waldorg', 1270, 740, 1360, 770),
('03', 'Gzor', 518, 265, 569, 306);

INSERT INTO villagealler (villagedep, villagearv, temps, dure) VALUES
('01', '02', 10, '1H 30min'),
('02', '01', 10, '1H 25min'),
('01', '03', 20, '2H 45min'),
('02', '03', 30, '2 Jour 5h'),
('03', '01', 50, '3 Jour 2h'),
('03', '02', 60, '1 Jour 5h');

INSERT INTO race (code, libelle, r_pv, r_pm, r_for, r_end, r_vit, r_int, r_dext, r_cha, r_man, r_ppm, r_village, r_image) VALUES
('01', 'Barbare', 60, 5, 4, 4, 1, 0, 1, 2, 10, 1, '01', 'barbare'),
('02', 'Nain', 50, 5, 3, 4, 1, 1, 1, 2, 8, 2, '02', 'nain'),
('03', 'Elfe', 30, 20, 2, 1, 3, 3, 2, 4, 3, 10, '01', 'elfe'),
('04', 'Enchanteur', 25, 30, 1, 2, 2, 4, 2, 3, 2, 14, '01', 'enchanteur');

INSERT INTO magazin (code, libelle, coord01, coord02, coord03, coord04, village, type) VALUES
('01', 'Forgeron', 240, 430, 370, 510, '01', 'magasin'),
('02', 'Chez le père magotte', 240, 430, 370, 510, '01', 'magasin'),
('03', 'Au rat fumant', 240, 30, 340, 130, '01', 'taverne'),
('04', 'Le cimetierre du dés', 630, 210, 730, 290, '02', 'magasin'),
('05', 'Chez le père serte', 40, 200, 130, 260, '02', 'magasin'),
('06', 'Au cheval bondissant', 310, 60, 450, 160, '02', 'aventure'),
('07', 'Le bouclier de rock', 540, 45, 650, 180, '03', 'magasin'),
('08', 'Chez pierre', 45, 50, 150, 190, '03', 'magasin'),
('09', 'Le gai souriseau', 35, 240, 145, 440, '03', 'aventure');

INSERT INTO aventure (code, libelle, resumer, nbor, nbexp, rang, image, village) VALUES
(1, 'Chasseur de rat', 'Cette mission vous a été confier par le pere magotte dont les rat ont envahie sa grange!', 10, 15, 1, 'aventure/01.JPG', '01'),
(2, 'Tueur de poulet', 'Un changement forme s''est infiltré dans un élevage de poulet. Vous devez  retrouver sa trace.', 15, 10, 1, 'aventure/05.JPG', '02'),
(3, 'Tueur de lutin', 'Un lutin tout bleu à été apercu dans la foret voisin. Malheuresement il à prit tout le sctok de biere! Une mission capital!', 20, 20, 2, 'aventure/04.JPG', '01'),
(4, 'Donjon de nalheubeuk', 'Une statuette ? la profécie de galdeulfera? un sorcier de niv 1. Monté votre compagnie et partée à l''aventure!', 50, 50, 3, '', '01'),
(5, 'La caverne du vampire emofile', 'Cette ancien seigneur à refait surface pour dévore le stock de tomate de la region. Le crak boursier est en marche!', 50, 50, 4, '', '01'),
(6, 'Le gobelin unijambiste', 'Un groupe de gobelin éméché ont pillé le champs du fermier. Seriez vous capable de lutter contre ses gobelins estropied?', 5, 20, 1, '', '03');

-- Aventures 101 à 124 : quêtes du HeroQuest PC de Gremlin (1991), cartes générées par bin/import-heroquest.py.
-- Les quêtes 5 et 10 (aventures 105 et 110) ne sont pas converties.
INSERT INTO aventure (code, libelle, resumer, nbor, nbexp, rang, image, village) VALUES
(101, 'Le labyrinthe', 'Votre dernière épreuve avant de partir à l''aventure : trouvez l''escalier au cœur du labyrinthe. Plusieurs monstres y ont été lâchés pour vous barrer la route.', 20, 20, 1, '', '01'),
(102, 'Le sauvetage de sir Ragnar', 'Sir Ragnar, l''un des plus puissants chevaliers de l''Empereur, est retenu prisonnier par Ulag, le seigneur orc. Éliminez ses gardes pour le libérer.', 25, 25, 1, '', '02'),
(103, 'Le repaire du seigneur orc', 'Le prince Magnus veut la tête d''Ulag, responsable de l''enlèvement de sir Ragnar. Le trésor de son repaire revient à qui l''abattra.', 30, 30, 1, '', '03'),
(104, 'L''or du prince Magnus', 'Trois coffres destinés à l''Empereur ont été volés par une bande d''orcs cachée dans les Montagnes Noires, menée par un guerrier du chaos.', 30, 30, 1, '', '01'),
(106, 'L''héritage du seigneur orc', 'Grak, le fils d''Ulag, vous a capturés pour venger son père. Vous avez crocheté la serrure de votre cellule avec un vieil os de rat : rejoignez l''escalier pour vous échapper.', 40, 40, 2, '', '02'),
(107, 'Le chasseur de pierres', 'Karlen, le sorcier de l''Empereur, a disparu. Assassiné ou séduit par la magie du chaos ? Explorez le donjon où il a été vu pour la dernière fois.', 40, 40, 2, '', '03'),
(108, 'Le mage du feu', 'Balur, le mage du feu, aide les orcs des Montagnes Noires dans leurs raids. Descendez dans son antre, sous le pic de Feu Noir, et détruisez-le.', 45, 45, 2, '', '01'),
(109, 'Course contre la montre', 'Votre guide vous a abandonnés dans un donjon oublié en éteignant sa torche. Retrouvez l''escalier avant de périr dans les ténèbres.', 45, 45, 2, '', '02'),
(111, 'Le bastion du chaos', 'Orcs et gobelins pillent les terres de l''Est depuis une forteresse souterraine tenue par des guerriers du chaos. Entrez et tuez tous les monstres.', 50, 50, 3, '', '03'),
(112, 'Barak Tor, demeure du Sorcier-Roi', 'L''Étoile de l''Ouest repose à Barak Tor, le tombeau du Sorcier-Roi. L''Empereur en a besoin pour unir les royaumes avant la guerre contre les orcs.', 55, 55, 3, '', '01'),
(113, 'La quête de la Lame de l''esprit', 'Vous avez réveillé le Sorcier-Roi. Seule la Lame de l''esprit, forgée par les nains, peut le blesser : elle se trouve dans un ancien temple en ruine.', 55, 55, 3, '', '02'),
(114, 'Retour à Barak Tor', 'Armés de la Lame de l''esprit, retournez à Barak Tor et détruisez le Sorcier-Roi avant que son armée de morts-vivants n''attaque l''Empereur.', 60, 60, 3, '', '03'),
(115, 'La porte du destin', 'L''entrée de la forteresse du Sorcier-Roi est grande ouverte. Traversez ses tunnels jusqu''à la porte du destin : l''ennemi a eu le temps de préparer votre accueil.', 65, 65, 4, '', '01'),
(116, 'Les salles glacées', 'Dans ces couloirs gelés reposent les cavaliers spectraux qui menaient autrefois la cavalerie squelette du Sorcier-Roi.', 65, 65, 4, '', '02'),
(117, 'Les couloirs silencieux', 'Ces couloirs sont muets depuis que le roi Agrain et son peuple y ont défendu leur cité il y a mille ans. Une magie ancienne et terrible y est encore à l''œuvre.', 70, 70, 4, '', '03'),
(118, 'Les salles de vision', 'Le roi Agrain, guerrier redouté et magicien à ses heures, a créé ce dédale de salles magiques dont les clés gardent le secret.', 70, 70, 4, '', '01'),
(119, 'La porte de Bellthor', 'Ici commence le vrai domaine du Sorcier-Roi. Bellthor, un terrible gardien, veille sur la porte : affrontez-le ensemble.', 75, 75, 4, '', '02'),
(120, 'Les salles des morts', 'Le Sorcier-Roi rassemble son armée dans les salles des morts. Frappez maintenant, avant qu''il ne s''échappe.', 75, 75, 4, '', '03'),
(121, 'La légion oubliée', 'Vous avez échappé au Sorcier-Roi, mais ces salles abritent la légion oubliée, l''élite de son armée, menée par Skulmar.', 80, 80, 4, '', '01'),
(122, 'La cité interdite', 'Nul n''est jamais entré dans la cité interdite. Ses couloirs grouillent de morts-vivants et la cité elle-même menace de s''effondrer.', 80, 80, 4, '', '02'),
(123, 'La dernière porte', 'Dernière porte avant la cour du Sorcier-Roi. Les guerriers du chaos de la garde du destin qui la défendent sont plus puissants que tous ceux que vous avez combattus.', 90, 90, 4, '', '03'),
(124, 'La cour du Sorcier-Roi', 'Le Sorcier-Roi s''est réfugié dans sa salle du trône. Cette fois, il ne doit pas s''échapper.', 100, 100, 4, '', '01');

-- Objets 1 à 30 : dump de 2007. Objets 995 à 999 : potions des cartes trésor du donjon (public/assets/game/config/tresors.js).
INSERT INTO objet (num, libelle, resumer, effet, valeur, image, catheg, autre) VALUES
(995, 'Breuvage héroïque', 'Un sac de cuir accroché au mur contient une potion. Il s''agit d''un breuvage héroïque. Celui-ci peut être pris juste avant de lever un combat. Le joueur qui absorbe cette potion pourra, le temps d''un tour seulement, attaquer deux fois au lieu d''une.', 'att', 1, 'biere03.png', 'quete', ''),
(996, 'Potion de vitesse', 'Vous repérez un flacon poussiéreux sur une étagère. En le nettoyant, vous vous rendez compte qu''il s''agit d''une potion de vitesse. Elle vous permettra de relancer les dés de déplacement.', 'dee', 2, 'biere02.png', 'quete', ''),
(997, 'Potion de force', 'Vous trouvez un petit flacon rempli de liquide pourpre. Il s''agit d''une potion de force. Elle vous permettra de lancer deux dés de combat en plus pour attaquer.', 'forc', 2, 'biere01.png', 'quete', ''),
(998, 'Potion de résistance', 'Parmi toute une collection de vieux flacons et pots en terre, vous découvrez une petite fiole claire contenant une potion de résistance. Votre défense augmentera de deux.', 'def', 2, 'item01.png', 'quete', ''),
(999, 'Potion de guérison', 'Vous découvrez un petit flacon enveloppé de vieux chiffons et en reconnaissez tout de suite le contenu : il s''agit d''une potion de guérison. Elle vous restituera quatre points de vie perdus.', 'pv2', 4, 'item01.png', 'quete', ''),
(1, 'Pomme', 'Une belle pomme du verger de votre village. Cet aliment vous redonne 5 point de vie', 'pv2', 5, 'item02.png', 'item', ''),
(2, 'Epée', 'Une epee pas trop mal , normal elle est forger par le nain du village', 'forc', 5, 'epee01.png', 'equip', 'Arme'),
(3, 'Armure de cuir', 'Cette armure faite de cuir durci dans de l''huile bouillante et modelée en forme de plastron. Le reste de l''armure est fabriqué à partir de matiière plus souples et plus douce', 'end', 10, 'armure02.png', 'equip', 'Plastron'),
(4, 'Besantine', 'Cette armure faite de cuir souple est renforcée par des rivets métalliques', 'end', 15, 'armure01.png', 'equip', 'Plastron'),
(7, 'Plates d armure', 'Combinaison d''armure en cotte de mailles et de plaques métalliques couvrant les zones vitales telles que le torse , l''abdomen et l''aine. Le poids est distribué sur tout le corps et l''armure est maintenue en place grâce à des boucles et des sangles', 'end', 30, '01.png', 'equip', 'Plastron'),
(5, 'Cotte de maille', 'La cotte de maille est composée d''anneaux métaliques s''imbriquant les uns dans les autres. Elle se porte toujours par-dessus une couche de tissu matelassé ou de cuir souple pour éviter l''irritation et amortie l''impact des coups', 'end', 20, '01.png', 'equip', 'Plastron'),
(6, 'Armure Feuilletée', 'Les bandes de métal sont appliquées verticalement au dos de mailles de cuir ou de tissu plutôt qu''horizontalement comme dans l''armure à bandes. L''armure feuilleté offre moin de mobilité lors d''un combat', 'end', 25, '01.png', 'equip', 'Plastron'),
(8, 'Armure complète', 'Les plaques s''imbriquant parfaitement les unes aux autres sont spécialement orientées pour dévier les flèches et les coups. L''armure est soigneusement décoré de glyphe et d''estamps riches en détails', 'end', 50, '01.png', 'equip', 'Plastron'),
(9, 'Grand bouclier', 'Ce large bouclier de métal ou de bois protège son utilisateur du menton à la pointe des pieds. Il doit solidement l''attaché à l''avant-bras', 'end', 20, 'bouclier01.png', 'equip', 'Bouclier'),
(10, 'Ecu', 'Les écus sont généralement composé de métal , font de 1 m à 1,20m de haut et sont de différente forme. Un écu médiéval typique ressemble à un triangles pointant vers le bas', 'end', 15, 'bouclier02.png', 'equip', 'Bouclier'),
(11, 'Rondache', 'Son poids léger comparé à celui de lécu permet à l''utilisateur de porter d''autre objets dans cette main, même s''il ne peut manier ou porter une autre arme.', 'end', 10, 'bouclier05.png', 'equip', 'Bouclier'),
(12, 'Targe', 'Ce sont des versions légèrement plus petites des rondaches idéal pour les débutant', 'end', 5, '01.png', 'equip', 'Bouclier'),
(13, 'Bottes', 'Faites à la amin par des cordonniers, fabriquées en seri selon un modèle regional, les plus chères sont faite spécialement au pied d''un individu', 'end', 5, '01.png', 'equip', 'Botte'),
(14, 'Gantelets', 'Ses gant de protection peuvent être faits de cuir, de plaques de métal ou en cotte de mailles.', 'end', 5, 'gant01.png', 'equip', 'AvantBras'),
(15, 'Casque', 'Les casque protègent une grande partie de la tête, excepté le visage et le cou. ils sont fait de cuir renforcé ou de métal', 'end', 5, 'casque04.png', 'equip', 'Casque'),
(16, 'Dague', 'Lame pointue et à double tranchant, contrairement à un couteau qui a un seul bord coupant et qui est un peu plus court', 'forc', 5, 'dague01.png', 'equip', 'Arme'),
(17, 'Epée courte', 'Elle a une lame à double tranchant d''environ 60 cm de long. La pointe de l''épée est généralement pointue, idéale pour piquer', 'forc', 10, '01.png', 'equip', 'Arme'),
(18, 'Epée à deux mains', 'L''épée à deux main est un dérivé de l''épée longue. La lame a été allongée et la poignée a été étendue. Il faut alors deux mains pour manier l''épée correctement', 'forc', 30, '01.png', 'equip', 'Arme'),
(19, 'Poulet', 'Une chair bien tendre, cuit à point. Le repas sur le pouce de tout aventurier
Cet aliment vous redonne 20 point de vie', 'pv2', 20, 'item04.png', 'item', ''),
(20, 'Gateau de miel', 'La durée de conservation et ses valeurs nutritives, on permit à bien des aventurier de survivre lors de longue quête.
Cet aliment vous redonne 15 point de vie.', 'pv2', 15, 'item03.png', 'item', ''),
(21, 'Fléau', 'Le fléau est composé d''une boule de fer hérissée de pointe attachée par une chaine à un manche de bois', 'forc', 10, 'fleau.png', 'equip', 'Arme'),
(22, 'Morgenstern', 'Un manche de bois surmonté d''une tête métalique hérissée de pointes. Elles mesurent généralement 1.20m environ', 'forc', 10, 'mosterg.png', 'equip', 'Arme'),
(23, 'Hachette', 'La hachette est également connue sous le nom de hache de poing ou hache de jet. Elle présente d''un côté une lame tranchante et de l''autre un appendice pointu. Le manche est souvent doté d''une pointe métallique.', 'forc', 10, 'hache02.png', 'equip', 'Arme'),
(24, 'Hache d''armes', 'La version la plus communes de la hache d''armes est constitué d''un manche d''environ 1.20m de long surmonté d''une lame tranchante. Les haches d''armes sont aussi appelées grandes haches.', 'forc', 15, 'hache03.png', 'equip', 'Arme'),
(25, 'Gourdin', 'La plupart des gourdins sont de simple manches de bois, étroits à la poignée et plus large à l''autre extrémité. Cette armeest utilisé depuis que l''humanité à commencé à utiliser des outil. Tout le monde peut trouver un morceau de bois robuste et s''en servir, ce uqi explique l''usage répendu du gourdin', 'forc', 5, '01.png', 'equip', 'Arme'),
(26, 'Masse', 'La masse est une descendante directe du gourdin. Un manche de bois surmonté d''un bloc de pierre ou d''une tête métallique', 'forc', 10, 'massarme.png', 'equip', 'Arme'),
(27, 'Bâton', 'Le bâton est un manche de bois d''une longueur allant de 1.80m à 2.7m. Les bâtons de qulité sont fabriqués dans du chêne et leurs extrémités sont ferrées. Le bâtonse manie à deux mains', 'forc', 5, '01.png', 'equip', 'Arme'),
(28, 'Marteau de guerre', 'Le marteau de guerre se compose d''un manche de métal ou de bois surmonté d''une tête de métal généralement carrée. Son poids le rend redoutable contre toutes les créatures, même protégées de lourdes armures.', 'forc', 30, '01.png', 'equip', 'Arme'),
(29, 'Lance', 'L''une des premières armes de l''homme, remontant aux époques les plus primitives. les premières lances étaient des bâtons de bois taillés à une des extrémités. Lorque l''homme a commencé à maîtriser les métaux, il ajouta aux lances des pointes de fer et d''acier. Avec le développement d''armures plus résistantes, les fabricants de lances commencèrent à utiliser différents types d''alliage pour leurs pointes', 'forc', 10, '01.png', 'equip', 'Arme'),
(30, 'Hallebarde', 'La hallebarde est constituée d''une lame de hache semblable à un couperet montée sur un bâton d''environ 1.80m de haut. La hallebarde combine les caractéristiques à a fois de la lance et de la hache.', 'forc', 20, '01.png', 'equip', 'Arme');

INSERT INTO objetproposer (magazin, objet, nb, prix) VALUES
('07', 9, 10, 50),
('04', 3, 5, 55),
('04', 18, 10, 60),
('04', 17, 10, 50),
('04', 16, 10, 30),
('04', 2, 10, 40),
('01', 18, 10, 120),
('01', 2, 10, 60),
('01', 16, 10, 40),
('01', 15, 5, 60),
('01', 13, 5, 55),
('01', 11, 5, 50),
('01', 9, 4, 75),
('01', 8, 5, 575),
('01', 7, 5, 175),
('01', 3, 5, 50),
('07', 10, 10, 60),
('07', 11, 10, 70),
('07', 12, 10, 80),
('07', 3, 5, 60),
('02', 1, 50, 6),
('02', 19, 20, 18),
('02', 20, 10, 12),
('05', 1, 10, 12),
('05', 19, 15, 20),
('05', 20, 40, 8),
('08', 1, 10, 10),
('08', 19, 30, 15),
('08', 20, 10, 10)
;
