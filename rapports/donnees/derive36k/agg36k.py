# Lot derive36k : relevés RELEVE (tous les 250 j) de derive-g<g>-f<f>.txt ; agrégats par tranche et par configuration.
#   python agg36k.py dossier [pas]
import sys, json, glob, os, re, statistics as st
d = sys.argv[1]
step = int(sys.argv[2]) if len(sys.argv) > 2 else 3000
runs = {}
for f in glob.glob(os.path.join(d, 'derive-g*-f*.txt')):
    g, fi = map(int, re.search(r'g(\d+)-f(\d)', f).groups())
    rs = [json.loads(l[7:]) for l in open(f, encoding='utf-8') if l.startswith('RELEVE ')]
    runs[(g, fi)] = rs

def win(rs, k, lo, hi):
    xs = [r[k] for r in rs if lo < r['jour'] <= hi]
    return st.mean(xs) if xs else None

def at(rs, k, day):
    for r in rs:
        if r['jour'] == day: return r[k]
    return None

keys = [('chomage', 100, '%5.1f'), ('ipcMoyen', 1, '%6.2f'), ('salaireMoyen', 1, '%6.0f'), ('menages', 1e-6, '%6.2f'),
        ('entreprises', 1e-6, '%6.2f'), ('etat', 1e-6, '%6.2f'), ('banques', 1e-6, '%6.2f'), ('total', 1e-6, '%6.1f'),
        ('detteEntreprises', 1e-6, '%6.2f'), ('hypotheques', 1e-6, '%6.2f'), ('credit', 1e-6, '%6.2f'), ('banquesActives', 1, '%4.1f'),
        ('actives', 1, '%5.0f'), ('machines', 1, '%6.0f'), ('varietes', 1, '%4.0f'), ('affames', 1, '%6.1f'), ('sansAbri', 1, '%6.1f'),
        ('bonheur', 100, '%5.1f'), ('gini', 1, '%5.3f'), ('batiments', 1, '%6.0f')]
days = 36000
for fi in (0, 1):
    seeds = sorted(g for (g, f) in runs if f == fi)
    print(f'\n=== filets {"actifs" if fi else "coupés"} : {len(seeds)} parties ; moyennes des graines (médiane entre crochets pour le chômage)')
    print('tranche       ' + ' '.join(f'{k[:8]:>8}' for k, _, _ in keys))
    for lo in range(0, days, step):
        hi = lo + step
        vals = []
        for k, sc, fmt in keys:
            xs = [win(runs[(g, fi)], k, lo, hi) for g in seeds]
            xs = [x for x in xs if x is not None]
            vals.append((fmt % (st.mean(xs) * sc)).rjust(8) if xs else '       -')
        us = sorted(x for x in (win(runs[(g, fi)], 'chomage', lo, hi) for g in seeds) if x is not None)
        print(f'{lo+1:5d}-{hi:<6d} ' + ' '.join(vals) + f'  [méd {st.median(us)*100:.1f}, max {max(us)*100:.1f}, n {len(us)}]')

print('\n=== par graine : chômage moyen (%) par tranche de 6 000 j, filets coupés | actifs')
for g in range(1, 21):
    row = []
    for fi in (0, 1):
        rs = runs.get((g, fi), [])
        row.append(' '.join((f'{win(rs, "chomage", lo, lo + 6000) * 100:5.1f}' if win(rs, "chomage", lo, lo + 6000) is not None else '    -') for lo in range(0, days, 6000)))
    print(f'g{g:<3d} {row[0]}  |  {row[1]}')

print('\n=== par graine : indice des prix moyen par tranche de 6 000 j, filets coupés | actifs')
for g in range(1, 21):
    row = []
    for fi in (0, 1):
        rs = runs.get((g, fi), [])
        row.append(' '.join((f'{win(rs, "ipcMoyen", lo, lo + 6000):6.2f}' if win(rs, "ipcMoyen", lo, lo + 6000) is not None else '     -') for lo in range(0, days, 6000)))
    print(f'g{g:<3d} {row[0]}  |  {row[1]}')

# crises : relevés (250 j) avec chômage > 20 %, et pic
print('\n=== crises (relevés de 250 j avec chômage moyen > 20 %)')
for fi in (0, 1):
    n = 0; tot = 0; parts = 0
    for g in range(1, 21):
        rs = runs.get((g, fi), [])
        c = [r for r in rs if r['chomage'] > 0.2]
        tot += len(rs); n += len(c)
        if c: parts += 1
    print(f'filets {fi} : {n} relevés sur {tot} ({n / tot * 100:.1f} %), dans {parts} parties sur 20')
for fi in (0, 1):
    print(f'filets {fi} : pic du chômage par graine :', ' '.join(f'g{g}:{max(r["chomage"] for r in runs[(g, fi)]) * 100:.0f}@{max(runs[(g, fi)], key=lambda r: r["chomage"])["jour"]}' for g in range(1, 21) if (g, fi) in runs))
for fi in (0, 1):
    print(f'filets {fi} : durée (h) :', ' '.join(f'{runs[(g, fi)][-1]["secondes"] / 3600:.2f}' for g in range(1, 21)))
