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
('01', 'Humain', 40, 10, 2, 2, 2, 2, 2, 2, 4, 6, '01', 'Ranger.jpg'),
('02', 'Elfe', 30, 20, 2, 1, 3, 3, 2, 4, 3, 10, '01', 'Elfe.jpg'),
('03', 'Nain', 50, 5, 3, 4, 1, 1, 1, 2, 8, 2, '02', 'Nain.jpg'),
('04', 'Ogre', 60, 5, 4, 4, 1, 0, 1, 2, 10, 1, '01', 'Ogre.jpg');

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

-- Objets 1 à 30 : dump de 2007. Objets 995 à 999 : potions des cartes trésor du donjon (MesItem.js).
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
