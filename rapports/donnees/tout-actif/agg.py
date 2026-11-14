# Lot tout-actif : anciens défauts de l'interface (A), nouveaux défauts (B), tous les modules frontières fermées (C).
#   python agg.py [dossier] > agg.txt   (dossier : celui des fichiers p<pop>-g<graine>-<config>.txt ; défaut : ici)
# Par population et configuration : moyennes des 10 graines sur les jours 1 001-3 000 (chômage, indice, salaire,
# sans-abri, affamés, Gini, bonheur), indice et salaire au jour 3 000, relevés en crise (chômage > 20 %) ; puis écarts
# appariés par graine (B − A, C − A, B − C) avec le nombre de graines où l'écart est positif. Écrit aussi releves.csv ;
# sans les fichiers bruts (retirés après le lot), relit releves.csv.
import csv, json, os, statistics as st, sys

sys.stdout.reconfigure(encoding='utf-8')
d = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(os.path.abspath(__file__))
pops, seeds, confs = [240, 1000, 2500], range(1, 11), 'ABC'
R = {}
for p in pops:
    for g in seeds:
        for c in confs:
            f = os.path.join(d, f'p{p}-g{g}-{c}.txt')
            if not os.path.exists(f):
                continue
            R[(p, g, c)] = [json.loads(l[7:]) for l in open(f, encoding='utf-8') if l.startswith('RELEVE ')]
brut = bool(R)
if not brut:
    for r in csv.DictReader(open(os.path.join(d, 'releves.csv'), encoding='utf-8')):
        x = {k: (int(v) if k == 'jour' else float(v)) for k, v in r.items()
             if k not in ('population', 'graine', 'config', 'entrepreneur', 'briqueterie') and v != ''}
        x['construction'] = {k: int(r[k]) for k in ('entrepreneur', 'briqueterie') if r[k] != ''}
        R.setdefault((int(r['population']), int(r['graine']), r['config']), []).append(x)

# relevés à plat
cles = ['jour', 'chomage', 'ipcMoyen', 'salaireMoyen', 'ipc', 'salaire', 'menages', 'entreprises', 'etat', 'banques',
        'total', 'credit', 'hypotheques', 'batiments', 'actives', 'varietes', 'affames', 'sansAbri', 'bonheur', 'gini',
        'pib', 'etatParc', 'renovees', 'secondes']
with open(os.path.join(d, 'releves.csv') if brut else os.devnull, 'w', newline='', encoding='utf-8') as fo:
    w = csv.writer(fo)
    w.writerow(['population', 'graine', 'config'] + cles + ['entrepreneur', 'briqueterie'])
    for (p, g, c), rs in sorted(R.items()):
        for r in rs:
            co = r.get('construction', {})
            w.writerow([p, g, c] + [r.get(k, '') for k in cles] + [co.get('entrepreneur', ''), co.get('briqueterie', '')])


def moy(rs, k):  # moyenne des relevés des jours 1 001-3 000
    v = [r[k] for r in rs if r['jour'] > 1000]
    return st.mean(v) if v else float('nan')


def fin(rs, k):
    return rs[-1][k] if rs else float('nan')


ind = [('chômage %', lambda rs: 100 * moy(rs, 'chomage')), ('indice', lambda rs: moy(rs, 'ipcMoyen')),
       ('indice j3000', lambda rs: fin(rs, 'ipcMoyen')), ('salaire', lambda rs: moy(rs, 'salaireMoyen')),
       ('sans-abri', lambda rs: moy(rs, 'sansAbri')), ('affamés', lambda rs: moy(rs, 'affames')),
       ('Gini', lambda rs: moy(rs, 'gini')), ('bonheur %', lambda rs: 100 * moy(rs, 'bonheur'))]
for p in pops:
    print(f'=== {p} citoyens (moyenne des graines, jours 1 001-3 000 ; médiane entre crochets)')
    for c in confs:
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
        sec = st.mean(rs[-1]['secondes'] for rs in rs_all if rs)
        extra = ''
        if c != 'A':
            eg = sum(1 for rs in rs_all if rs and rs[-1].get('construction', {}).get('entrepreneur', 0) > 0)
            extra = f' ; entrepreneur général actif au jour 3 000 : {eg}/{len(rs_all)}'
        print(f'  {c} ({len(rs_all)} parties, {fini} au bout, {sec:.0f} s) : ' + ', '.join(parts)
              + f' ; relevés chômage > 20 % : {crise} ({gr} graines){extra}')
    for a, b in (('B', 'A'), ('C', 'A'), ('B', 'C')):
        gs = [g for g in seeds if (p, g, a) in R and (p, g, b) in R]
        if not gs:
            continue
        parts = []
        for nom, fn in ind:
            dd = [fn(R[(p, g, a)]) - fn(R[(p, g, b)]) for g in gs]
            parts.append(f'{nom} {st.mean(dd):+.2f} ({sum(x > 0 for x in dd)}/{len(dd)})')
        print(f'  {a} − {b} : ' + ', '.join(parts))
    print()
