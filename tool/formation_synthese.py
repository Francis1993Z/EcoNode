#!/usr/bin/env python3
"""Synthèse des sorties de tool/formation.dart (une ligne « FORM {json} » par partie, fichiers g<graine>_n<taille>.txt).

   python tool/formation_synthese.py dossier                 médiane, min, max par taille
   python tool/formation_synthese.py dossier_A dossier_B     comparaison appariée graine par graine (B − A)
"""
import glob
import json
import os
import statistics as st
import sys

sys.stdout.reconfigure(encoding='utf-8')


def charge(d):
    r = {}
    for f in glob.glob(os.path.join(d, 'g*_n*.txt')):
        g, n = os.path.basename(f)[1:-4].split('_n')
        try:
            r[(int(n), int(g))] = json.loads(open(f, encoding='utf-8').read().split(' ', 1)[1])
        except Exception:
            pass
    return r


def an_moy(o, cle, depuis=0, idx=None):
    """Moyenne pondérée par les jours d'un champ annuel, à partir de l'année `depuis`."""
    t = j = 0.0
    for a in o['annees'][depuis:]:
        v = a.get(cle, 0)
        if isinstance(v, list):
            v = sum(v) if idx is None else v[idx]
        t += v * a['jours']
        j += a['jours']
    return t / j if j else float('nan')


def an_somme(o, cle, depuis=0):
    return sum(a.get(cle, 0) for a in o['annees'][depuis:])


def par_hab_an(o, cle):
    jours = sum(a['jours'] for a in o['annees'])
    return an_somme(o, cle) / o['population'] / (jours / 365)


# (nom, fonction, échelle, format)
MESURES = [
    ('chômage, toute la partie (%)', lambda o: o['moyennes']['chomage'], 100),
    ('chômage, jours 1001-3000 (%)', lambda o: an_moy(o, 'chomage', 3), 100),
    ('sans emploi, étudiants compris (%)', lambda o: o['moyennes']['sans_emploi'], 100),
    ('étudiants (% de la population)', lambda o: o['moyennes'].get('etudiants', 0), 100),
    ('dont à temps plein (%)', lambda o: o['moyennes'].get('etudiants_plein', 0), 100),
    ('salaire moyen ($/j)', lambda o: o['moyennes']['salaire'], 1),
    ('salaire réel moyen (salaire ÷ indice)', lambda o: an_moy(o, 'salaire') / an_moy(o, 'ipc'), 1),
    ('indice des prix moyen', lambda o: o['moyennes']['ipc'], 1),
    ('indice des prix final', lambda o: o['moyennes']['ipc_fin'], 1),
    ('montées de classe /hab/an (ancien modèle)', lambda o: o['moyennes']['montees_par_hab_an'], 1),
    ('diplômes décernés /hab/an', lambda o: par_hab_an(o, '_diplomes'), 1),
    ('durée moyenne des études (j)', lambda o: o['moyennes'].get('duree_etudes', -1), 1),
    ('reconversions (total)', lambda o: o['moyennes'].get('reconversions', 0), 1),
    ('inscriptions temps plein (total)', lambda o: o['moyennes'].get('inscriptions_plein', 0), 1),
    ('inscriptions cours du soir (total)', lambda o: o['moyennes'].get('inscriptions_soir', 0), 1),
    ('changements de filière /hab/an', lambda o: o['moyennes']['chgt_filiere_par_hab_an'], 1),
    ('employés hors filière d\'origine (%)', lambda o: o['moyennes']['hors_filiere'], 100),
    ('employés hors de leur filière de diplôme (%)', lambda o: an_moy(o, 'hors_diplome') / o['population'], 100),
    ('postes qualifiés vacants (moy. lissée)', lambda o: an_moy(o, 'vacants_qualifies'), 1),
    ('pénurie de diplômés (postes)', lambda o: an_moy(o, 'penurie'), 1),
    ('postes vacants, toutes classes (moy.)', lambda o: an_moy(o, 'vacants'), 1),
    ('prêts étudiants accordés ($/hab)', lambda o: o['moyennes'].get('prets_par_hab', 0), 1),
    ('jours d\'études sans cours (total)', lambda o: o['moyennes'].get('jours_sans_cours', 0), 1),
    ('naissances d\'entreprises', lambda o: o['moyennes']['naissances'], 1),
    ('morts d\'entreprises', lambda o: o['moyennes']['morts'], 1),
    ('morts : sans employé (30 j)', lambda o: an_somme(o, 'mort_sans_employe'), 1),
    ('morts : faillite', lambda o: an_somme(o, 'mort_faillite'), 1),
    ('morts : demande perdue', lambda o: an_somme(o, 'mort_demande_perdue'), 1),
]


def val(o, f, e):
    try:
        v = f(o)
        return None if v is None or v != v or v < -0.5 and v == -1 else v * e
    except Exception:
        return None


def seul(d):
    data = charge(d)
    for n in sorted({k[0] for k in data}):
        obs = [data[k] for k in sorted(data) if k[0] == n]
        print(f'--- {d} : {n} citoyens, {len(obs)} graines')
        for nom, f, e in MESURES:
            v = [x for x in (val(o, f, e) for o in obs) if x is not None]
            if v:
                print(f'  {nom:46s} médiane {st.median(v):10.2f}   min {min(v):10.2f}   max {max(v):10.2f}')


def compare(da, db):
    a, b = charge(da), charge(db)
    print(f'Comparaison appariée : A = {da}, B = {db} (B − A ; « B<A » = graines où B est plus bas)')
    for n in sorted({k[0] for k in a} & {k[0] for k in b}):
        graines = sorted(g for (m, g) in a if m == n and (m, g) in b)
        print(f'--- {n} citoyens, {len(graines)} graines appariées')
        print(f'  {"":46s} {"A méd.":>10s} {"B méd.":>10s} {"B−A méd.":>10s} {"min":>9s} {"max":>9s}  B<A')
        for nom, f, e in MESURES:
            va = [val(a[(n, g)], f, e) for g in graines]
            vb = [val(b[(n, g)], f, e) for g in graines]
            paires = [(x, y) for x, y in zip(va, vb) if x is not None and y is not None]
            if not paires:
                continue
            d = [y - x for x, y in paires]
            bas = sum(1 for x in d if x < 0)
            print(f'  {nom:46s} {st.median([x for x, _ in paires]):10.2f} {st.median([y for _, y in paires]):10.2f} '
                  f'{st.median(d):10.2f} {min(d):9.2f} {max(d):9.2f}  {bas}/{len(d)}')


if __name__ == '__main__':
    if len(sys.argv) == 3:
        compare(sys.argv[1], sys.argv[2])
    else:
        for x in sys.argv[1:]:
            seul(x)
