# Corrections du commerce extérieur : B1 (prix mondiaux qui vivent), B2 (repas non échangeables), B3 (préférence de
# 20 % pour ce qui est fait ici), B123 (les trois), comparées à A, B et C (../releves.csv, mêmes graines).
#   python agg.py > agg.txt
# Lit les fichiers bruts p<pop>-g<graine>-<config>.txt s'ils sont là (et écrit releves.csv), sinon releves.csv.
# Moyennes des 10 graines sur les jours 1 001-3 000 (médiane entre crochets), relevés en crise (chômage > 20 %), puis
# écarts appariés par graine avec le nombre de graines où l'écart est positif.
import csv, json, os, statistics as st, sys

sys.stdout.reconfigure(encoding='utf-8')
d = os.path.dirname(os.path.abspath(__file__))
pops, seeds = [240, 1000, 2500], range(1, 11)
nouv, anc = ['B1', 'B2', 'B3', 'B123'], ['A', 'B', 'C']
cles = ['jour', 'chomage', 'ipcMoyen', 'salaireMoyen', 'ipc', 'salaire', 'menages', 'entreprises', 'etat', 'banques',
        'total', 'credit', 'hypotheques', 'batiments', 'actives', 'varietes', 'affames', 'sansAbri', 'bonheur', 'gini',
        'pib', 'etatParc', 'renovees', 'secondes']
R = {}


def lire_csv(f, configs):
    for r in csv.DictReader(open(f, encoding='utf-8')):
        if r['config'] not in configs:
            continue
        x = {k: (int(v) if k == 'jour' else float(v)) for k, v in r.items()
             if k not in ('population', 'graine', 'config', 'entrepreneur', 'briqueterie') and v != ''}
        x['construction'] = {k: int(r[k]) for k in ('entrepreneur', 'briqueterie') if r.get(k, '') != ''}
        R.setdefault((int(r['population']), int(r['graine']), r['config']), []).append(x)


lire_csv(os.path.join(d, '..', 'releves.csv'), anc)
brut = False
for p in pops:
    for g in seeds:
        for c in nouv:
            f = os.path.join(d, f'p{p}-g{g}-{c}.txt')
            if os.path.exists(f):
                brut = True
                R[(p, g, c)] = [json.loads(l[7:]) for l in open(f, encoding='utf-8') if l.startswith('RELEVE ')]
if brut:
    with open(os.path.join(d, 'releves.csv'), 'w', newline='', encoding='utf-8') as fo:
        w = csv.writer(fo)
        w.writerow(['population', 'graine', 'config'] + cles + ['entrepreneur', 'briqueterie'])
        for (p, g, c), rs in sorted(R.items()):
            if c not in nouv:
                continue
            for r in rs:
                co = r.get('construction', {})
                w.writerow([p, g, c] + [r.get(k, '') for k in cles] + [co.get('entrepreneur', ''), co.get('briqueterie', '')])
else:
    lire_csv(os.path.join(d, 'releves.csv'), nouv)


def moy(rs, k):
    v = [r[k] for r in rs if r['jour'] > 1000]
    return st.mean(v) if v else float('nan')


ind = [('chômage %', lambda rs: 100 * moy(rs, 'chomage')), ('indice', lambda rs: moy(rs, 'ipcMoyen')),
       ('salaire', lambda rs: moy(rs, 'salaireMoyen')), ('sans-abri', lambda rs: moy(rs, 'sansAbri')),
       ('affamés', lambda rs: moy(rs, 'affames')), ('Gini', lambda rs: moy(rs, 'gini')),
       ('entreprises actives', lambda rs: moy(rs, 'actives'))]
for p in pops:
    print(f'=== {p} citoyens (moyenne des graines, jours 1 001-3 000 ; médiane entre crochets)')
    for c in anc + nouv:
        rs_all = [R[(p, g, c)] for g in seeds if (p, g, c) in R]
        if not rs_all:
            continue
        parts = []
        for nom, fn in ind:
            v = [fn(rs) for rs in rs_all]
            parts.append(f'{nom} {st.mean(v):.2f} [{st.median(v):.2f}]')
        crise = sum(1 for rs in rs_all for r in rs if r['chomage'] > 0.2)
        gr = sum(1 for rs in rs_all if any(r['chomage'] > 0.2 for r in rs))
        fini = sum(1 for rs in rs_all if rs and rs[-1]['jour'] == 3000)
        print(f'  {c:4} ({len(rs_all)} parties, {fini} au bout) : ' + ', '.join(parts)
              + f' ; relevés chômage > 20 % : {crise} ({gr} graines)')
    for a, b in [(n, 'B') for n in nouv] + [('B123', 'C'), ('B123', 'A')]:
        gs = [g for g in seeds if (p, g, a) in R and (p, g, b) in R]
        if not gs:
            continue
        parts = []
        for nom, fn in ind:
            dd = [fn(R[(p, g, a)]) - fn(R[(p, g, b)]) for g in gs]
            parts.append(f'{nom} {st.mean(dd):+.2f} ({sum(x > 0 for x in dd)}/{len(dd)})')
        print(f'  {a} − {b} : ' + ', '.join(parts))
    print()
