# Construire et vérifier

Depuis `donjon-v2/` :

```
python bin/construire-atlas-iso.py <controle.png>
```

Environ une minute. Le résultat est identique à chaque lancement.

1. **Planche de contrôle** (`<controle.png>`, chaque image sous son nom). Chercher les morceaux de voisins, les bords noirs ou verts, les orientations inversées, les tailles qui sautent d'une image à l'autre d'un même personnage.
2. **Scène de test**, avec les formules de placement de `ModuleIso.js` :
   ```
   python ../.claude/skills/atlas-iso/outils.py scene <sortie.png>
   ```
   Les murs doivent se raccorder sans couture noire ; les portes doivent suivre les murs ; les pieds des personnages doivent être au centre de leur dalle.
3. **Noms obligatoires** : les sprites fixes et le repos de chaque personnage.
   ```
   node -e "eval(require('fs').readFileSync('public/assets/game/iso/atlas.js','utf8')+';global.A=IsoAtlas;global.S=IsoSols.concat(Object.values(IsoSolsSpeciaux))');const m=[];const v=n=>A[n]||m.push(n);for(const t of ['barbare','nain','elfe','enchanteur'])for(const s of ['h','f']){v(t+'-'+s+'-repos');v('portrait-'+t+'-'+s)}for(const n of ['gobelin','orc','fimir','chaos','mage','squelette','zombie','momie','gargouille'])v(n+'-repos');for(const i of ['deplacement','attaque','objet','tresor','piege','fin'])v('icone-'+i),v('icone-'+i+'-grise');['bottes','bras','or','bouclier'].forEach(i=>v('icone-'+i));S.forEach(v);for(let i=0;i<4;i++)v('mur'+i);for(let i=0;i<12;i++)v('porte'+i);for(let c=0x4b;c<0x60;c++)if(c!=0x51&&c!=0x52)v('meuble'+c.toString(16));console.log(m.length?'manquants : '+m:'complet')"
   ```
   Attendu : `complet`.
4. **Dans le jeu** : une quête des cartes 101 à 124, vues 3D et classique. Marcher dans les 4 directions, et faire un combat (gros plan × 3 : frappe, touché, mort).
