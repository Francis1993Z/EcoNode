#!/usr/bin/env python3
"""Synthèse des sorties de tool/formation.dart : médiane et étendue sur les graines, par taille.
   python tool/formation_synthese.py dossier [dossier2 ...]   (deux dossiers : comparaison appariée)"""
import json, sys, glob, os, statistics as st
sys.stdout.reconfigure(encoding="utf-8")

def charge(d):
    r = {}
    for f in glob.glob(os.path.join(d, 'g*_n*.txt')):
        b = os.path.basename(f)[1:-4]
        g, n = b.split('_n')
        try:
            r[(int(n), int(g))] = json.loads(open(f, encoding='utf-8').read().split(' ', 1)[1])
        except Exception:
            pass
    return r

def val(o, cle):
    m = o['moyennes']
    if cle.startswith('an:'):  # an:champ:index  -> moyenne d'un champ annuel après la première année
        pass
    return m.get(cle)

CLES = [('chomage', '%', 100), ('cours_par_hab_an', 'cours/hab/an', 1), ('montees_par_hab_an', 'montées de classe/hab/an', 1),
        ('chgt_filiere_par_hab_an', 'changements de filière/hab/an', 1), ('embauches_par_hab_an', 'embauches/hab/an', 1),
        ('duree_montee_0_1', 'jours d\'une montée 0→1', 1), ('duree_montee_1_2', 'jours d\'une montée 1→2', 1),
        ('hors_filiere', '% employés hors filière d\'origine', 100)]

def resume(dossier):
    d = charge(dossier)
    for n in sorted({k[0] for k in d}):
        obs = [d[k] for k in sorted(d) if k[0] == n]
        print(f'--- {dossier} : {n} citoyens, {len(obs)} graines')
        for cle, nom, ech in CLES:
            v = [o['moyennes'][cle] * ech for o in obs if o['moyennes'].get(cle) == o['moyennes'].get(cle) and o['moyennes'].get(cle) is not None]
            if v:
                print(f'  {nom:42s} médiane {st.median(v):8.2f}   min {min(v):8.2f}   max {max(v):8.2f}')

for dos in sys.argv[1:]:
    resume(dos)
