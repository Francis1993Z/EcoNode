# Synthèse des sorties de tool/demographie.dart (une ou plusieurs configurations).
#
#   python tool/demographie_synthese.py dossier [dossier2 ...]
#
# Chaque dossier contient des fichiers g<graine>-p<population>.txt (une ligne « DEMO {json} »). Pour chaque population :
# taux annuels de naissance et de mort (rapportés au nombre moyen d'entreprises privées, années 2 et suivantes : la
# première année est celle du démarrage), survie à 1, 3 et 5 ans des entreprises nées pendant la partie (cohortes assez
# anciennes pour être observées jusqu'à cet âge), mortalité par âge, âge moyen des entreprises vivantes à la fin, part
# des morts par cause, rachats par an, chômage et indice des prix. Avec deux dossiers, les écarts par graine appariée.
import json
import os
import re
import statistics as st
import sys

AN = 365


def lire(dossier):
    parties = {}
    for nom in os.listdir(dossier):
        m = re.match(r'g(\d+)-p(\d+)\.txt$', nom)
        if not m:
            continue
        txt = open(os.path.join(dossier, nom), encoding='utf-8').read().strip()
        if not txt.startswith('DEMO '):
            continue
        d = json.loads(txt[5:])
        parties.setdefault(int(m.group(2)), {})[int(m.group(1))] = d
    return parties


def mesures(d):
    jours = d['jours']
    ans = [a for a in d['annees'] if a['annee'] >= 1 and a['jours'] == AN]
    moy = sum(a['entreprises'] for a in ans) / len(ans)
    nais = sum(a.get('naissances', 0) for a in ans) / len(ans)
    morts = sum(a.get('morts', 0) for a in ans) / len(ans)
    rach = sum(a.get('rachats', 0) for a in ans) / len(ans)
    causes = {}
    for a in ans:
        for k, v in a.items():
            if k.startswith('mort_'):
                causes[k[5:]] = causes.get(k[5:], 0) + v
    tot = sum(causes.values()) or 1
    fiches = d['entreprises']
    nees = [f for f in fiches if f[1] > 0]
    surv = {}
    for k in (1, 3, 5):
        coh = [f for f in nees if f[1] <= jours - k * AN]
        if coh:
            vivantes = [f for f in coh if f[2] is None or f[2] - f[1] >= k * AN]
            surv[k] = len(vivantes) / len(coh)
    # mortalité par âge : morts / entreprises-années exposées, pour les entreprises nées pendant la partie
    tranches = [(0, 1), (1, 2), (2, 3), (3, 5), (5, 99)]
    haz = {}
    for lo, hi in tranches:
        expo = morts_t = 0.0
        for f in nees:
            fin = f[2] if f[2] is not None else jours
            age_fin = (fin - f[1]) / AN
            e = max(0.0, min(age_fin, hi) - lo)
            expo += e
            if f[2] is not None and lo <= age_fin < hi:
                morts_t += 1
        haz[f'{lo}-{hi}'] = (morts_t / expo) if expo > 0.5 else None
    # mortalité des entreprises du plan de départ, années 2 et suivantes
    init = [f for f in fiches if f[1] == 0]
    expo_i = sum(max(0.0, ((f[2] if f[2] is not None else jours) - AN) / AN) for f in init)
    morts_i = sum(1 for f in init if f[2] is not None and f[2] > AN)
    vivantes = [f for f in fiches if f[2] is None]
    age = st.mean((jours - f[1]) / AN for f in vivantes) if vivantes else 0
    part_nees = sum(1 for f in vivantes if f[1] > 0) / len(vivantes) if vivantes else 0
    fin = [a for a in d['annees'] if a['jours'] == AN][-2:]
    return {
        'entreprises': moy,
        'naissance': nais / moy,
        'mort': morts / moy,
        'rachat': rach / moy,
        'causes': {k: v / tot for k, v in causes.items()},
        'survie': surv,
        'hazard': haz,
        'mort_initiales': morts_i / expo_i if expo_i > 0 else None,
        'age': age,
        'part_nees': part_nees,
        'nees': len(nees),
        'chomage': st.mean(a['chomage'] for a in ans),
        'chomage_fin': st.mean(a['chomage'] for a in fin),
        'ipc_fin': fin[-1]['ipc'],
        'fin_n': d['annees'][-1]['fin'],
    }


def pct(v):
    return '—' if v is None else f'{100 * v:.1f} %'


def resume(ms, cle, sous=None):
    vals = [m[cle] if sous is None else m[cle].get(sous) for m in ms]
    vals = [v for v in vals if v is not None]
    if not vals:
        return None, None
    return st.mean(vals), (st.median(vals))


def afficher(nom, parties):
    print(f'## {nom}')
    for pop in sorted(parties):
        ms = [mesures(d) for d in parties[pop].values()]
        n = len(ms)
        print(f'\n### {pop} citoyens ({n} graines, {parties[pop][next(iter(parties[pop]))]["jours"]} jours)')
        def ligne(lib, cle, sous=None, f=pct):
            m, med = resume(ms, cle, sous)
            print(f'- {lib} : moyenne {f(m) if m is not None else "—"}, médiane {f(med) if med is not None else "—"}')
        ligne('Entreprises privées (moyenne des années 2+)', 'entreprises', f=lambda v: f'{v:.0f}')
        ligne('Taux de naissance annuel', 'naissance')
        ligne('Taux de mort annuel', 'mort')
        ligne('Rachats par an (part des entreprises)', 'rachat')
        for k in (1, 3, 5):
            ligne(f'Survie à {k} an(s) des entreprises nées en partie', 'survie', k)
        for t in ('0-1', '1-2', '2-3', '3-5', '5-99'):
            ligne(f'Mortalité à l’âge {t} ans (nées en partie)', 'hazard', t)
        ligne('Mortalité annuelle des entreprises du départ (années 2+)', 'mort_initiales')
        ligne('Âge moyen des entreprises vivantes à la fin (ans)', 'age', f=lambda v: f'{v:.1f}')
        ligne('Part des vivantes à la fin nées en partie', 'part_nees')
        causes = sorted({k for m in ms for k in m['causes']})
        for c in causes:
            ligne(f'Part des morts : {c}', 'causes', c)
        ligne('Chômage moyen (années 2+)', 'chomage')
        ligne('Chômage des deux dernières années', 'chomage_fin')
        ligne('Indice des prix à la fin', 'ipc_fin', f=lambda v: f'{v:.2f}')


def apparier(a, b, na, nb):
    print(f'\n## Écarts appariés : {nb} − {na}')
    for pop in sorted(set(a) & set(b)):
        graines = sorted(set(a[pop]) & set(b[pop]))
        ma = {g: mesures(a[pop][g]) for g in graines}
        mb = {g: mesures(b[pop][g]) for g in graines}
        print(f'\n### {pop} citoyens, {len(graines)} graines appariées')
        def ecart(lib, f):
            d = [f(mb[g]) - f(ma[g]) for g in graines if f(mb[g]) is not None and f(ma[g]) is not None]
            if not d:
                return
            plus = sum(1 for x in d if x > 0)
            print(f'- {lib} : {st.mean(f(ma[g]) for g in graines if f(ma[g]) is not None):.4f} → '
                  f'{st.mean(f(mb[g]) for g in graines if f(mb[g]) is not None):.4f} '
                  f'(écart moyen {st.mean(d):+.4f}, médian {st.median(d):+.4f}, hausse dans {plus}/{len(d)})')
        ecart('Taux de naissance', lambda m: m['naissance'])
        ecart('Taux de mort', lambda m: m['mort'])
        ecart('Survie à 1 an', lambda m: m['survie'].get(1))
        ecart('Survie à 3 ans', lambda m: m['survie'].get(3))
        ecart('Survie à 5 ans', lambda m: m['survie'].get(5))
        ecart('Entreprises privées', lambda m: m['entreprises'])
        ecart('Âge moyen', lambda m: m['age'])
        ecart('Chômage (années 2+)', lambda m: m['chomage'])
        ecart('Chômage (2 dernières années)', lambda m: m['chomage_fin'])
        ecart('Indice des prix final', lambda m: m['ipc_fin'])


if __name__ == '__main__':
    dossiers = sys.argv[1:]
    parties = [lire(d) for d in dossiers]
    for d, p in zip(dossiers, parties):
        afficher(d, p)
    for i in range(1, len(parties)):
        apparier(parties[0], parties[i], dossiers[0], dossiers[i])
