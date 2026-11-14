import json, glob, statistics as st, sys, collections
sys.stdout.reconfigure(encoding='utf-8')
B = collections.defaultdict(dict)  # (pop,b) -> good -> list of dicts
T = collections.defaultdict(lambda: collections.defaultdict(collections.Counter))
F = collections.defaultdict(collections.Counter)
for f in glob.glob('c-*.txt'):
    _, p, g, b = f[:-4].split('-'); p, b = p[1:], b[1:]
    for l in open(f, encoding='utf-8'):
        if l.startswith('BIEN '):
            j = json.loads(l[5:]); B[(p, b)].setdefault(j['bien'], []).append(j)
        elif l.startswith('TYPE '):
            j = json.loads(l[5:])
            for k, v in j['fermetures'].items(): T[(p, b)][j['type']][k] += v
            F[(p, b)][j['type']] += j['fondations']
def m(l, k):
    v = [x[k] for x in l if x.get(k) is not None]
    return st.mean(v) if v else float('nan')
for p in ('240', '1000', '2500'):
    print(f'===== {p} citoyens : par bien, frontières ouvertes (fermées), moyennes des graines, jours 1 001-3 000')
    o, c = B[(p, '1')], B[(p, '0')]
    rows = []
    for g in o:
        rows.append((m(o[g], 'importationsValeur') - m(o[g], 'exportationsValeur'), g))
    rows.sort(reverse=True)
    print('bien | solde import−export $/j | import $/j | export $/j | part importée | prod/j ouvert (fermé) | emplois ouvert (fermé) | prix ici / import | prix import / mondial')
    for _, g in rows:
        lo, lc = o[g], c.get(g, [])
        pi, pw = m(lo, 'prixImport'), m(lo, 'prixMondial')
        print(f"{g} | {m(lo,'importationsValeur')-m(lo,'exportationsValeur'):.0f} | {m(lo,'importationsValeur'):.0f} | {m(lo,'exportationsValeur'):.0f} | {100*m(lo,'partImportee'):.0f} % | "
              f"{m(lo,'production'):.1f} ({m(lc,'production'):.1f}) | {m(lo,'emplois'):.1f} ({m(lc,'emplois'):.1f}) | {m(lo,'prixIci')/pi if pi==pi and pi else float('nan'):.2f} | {pi/pw if pw else float('nan'):.2f}")
    print('fermetures par type (ouvert / fermé), fondations :')
    tt = sorted(set(T[(p,'1')]) | set(T[(p,'0')]), key=lambda t: -(sum(T[(p,'1')][t].values()) - sum(T[(p,'0')][t].values())))
    for t in tt[:12]:
        print(f"  {t}: {sum(T[(p,'1')][t].values())} / {sum(T[(p,'0')][t].values())} ; causes ouvert {dict(T[(p,'1')][t])} ; fondations {F[(p,'1')][t]} / {F[(p,'0')][t]}")
    print()
