# Lot reno18k (rénovation, filets coupés) comparé aux parties filets coupés de derive36k, jours <= 18 000.
#   python agg18k.py ../derive36k/releves.csv releves.csv > agg18k.txt
import csv, json, statistics as st, sys, os
sys.stdout.reconfigure(encoding="utf-8")
base_csv, reno_csv = sys.argv[1], sys.argv[2]
B = {}  # (g, jour) -> row
for r in csv.DictReader(open(base_csv)):
    if r['filets'] != '0': continue
    j = int(r['jour'])
    if j > 18000: continue
    B[(int(r['graine']), j)] = {k: float(v) for k, v in r.items() if k not in ('graine', 'filets')}
R = {}
for r in csv.DictReader(open(reno_csv, encoding='utf-8')):
    d = {k: float(v) for k, v in r.items() if k not in ('graine', 'filets') and not k.startswith('actives_')}
    d['actives'] = float(r['actives'])
    d['construction'] = {k[8:]: int(v) for k, v in r.items() if k.startswith('actives_')}
    R[(int(r['graine']), int(r['jour']))] = d
seeds = range(1, 21)
def tr(j): return (j - 1) // 3000
def agg(D, key, t, f=st.mean):
    v = [D[(g, j)][key] for g in seeds for j in range(250, 18001, 250) if tr(j) == t and (g, j) in D]
    return f(v) if v else float('nan')
def per_seed(D, key, t):
    out = {}
    for g in seeds:
        v = [D[(g, j)][key] for j in range(250, 18001, 250) if tr(j) == t and (g, j) in D]
        if v: out[g] = st.mean(v)
    return out
print('Tranche | chômage sans/avec réno | IPC médian | salaire | sans-abri | affamés | bâtiments | hypothèques M$ | crédit M$ | ménages M$')
for t in range(6):
    def pair(k, f=st.mean, s=1, fmt='{:.2f}'):
        return fmt.format(agg(B, k, t, f) * s) + ' / ' + fmt.format(agg(R, k, t, f) * s)
    print(f'{t*3000+1}-{(t+1)*3000}', '|', pair('chomage', s=100, fmt='{:.1f}'), '|', pair('ipcMoyen', st.median), '|',
          pair('salaireMoyen', fmt='{:.0f}'), '|', pair('sansAbri', fmt='{:.0f}'), '|', pair('affames', fmt='{:.0f}'), '|',
          pair('batiments', fmt='{:.0f}'), '|', pair('hypotheques', s=1e-6, fmt='{:.1f}'), '|', pair('credit', s=1e-6, fmt='{:.1f}'),
          '|', pair('menages', s=1e-6, fmt='{:.1f}'))
print()
print('Rénovation seule : état du parc, inhabitables, en rénovation, rénovées (cumul), construits (cumul), prix module, dépenses réno M$')
for t in range(6):
    print(f'{t*3000+1}-{(t+1)*3000}', *(f'{agg(R, k, t):.3f}' if k == 'etatParc' else f'{agg(R, k, t):.0f}' for k in ('etatParc', 'inhabitables', 'enRenovation', 'renovees', 'construits', 'prixModule')), f"{agg(R,'depensesReno',t)/1e6:.1f}")
print()
print('Écarts appariés par graine (réno − sans), tranche 15 001-18 000 :')
for k, s in (('chomage', 100), ('ipcMoyen', 1), ('salaireMoyen', 1), ('sansAbri', 1), ('hypotheques', 1e-6)):
    a, b = per_seed(B, k, 5), per_seed(R, k, 5)
    d = [(b[g] - a[g]) * s for g in seeds if g in a and g in b]
    print(f'  {k}: moyenne {st.mean(d):+.2f}, médiane {st.median(d):+.2f}, réno plus haut dans {sum(x > 0 for x in d)}/{len(d)}')
print()
print('Par graine au jour 18 000 : chômage sans/réno, IPC sans/réno, sans-abri sans/réno, état parc, entrepreneur et briqueterie actifs')
for g in seeds:
    b, r = B.get((g, 18000)), R[(g, 18000)]
    c = r.get('construction', {})
    print(g, f"{b['chomage']*100:.1f}/{r['chomage']*100:.1f}", f"{b['ipcMoyen']:.2f}/{r['ipcMoyen']:.2f}", f"{b['sansAbri']:.0f}/{r['sansAbri']:.0f}",
          f"{r['etatParc']:.3f}", c.get('entrepreneur', 0), c.get('briqueterie', 0), int(r['renovees']), int(r['construits']))
# présence de la chaîne dans le temps
print()
print("Relevés où l'entrepreneur général est actif (part), par tranche :",
      [f"{sum(1 for g in seeds for j in range(250,18001,250) if tr(j)==t and R[(g,j)].get('construction',{}).get('entrepreneur',0)>0)/(20*12):.2f}" for t in range(6)])
print("Relevés où la briqueterie est active (part), par tranche :",
      [f"{sum(1 for g in seeds for j in range(250,18001,250) if tr(j)==t and R[(g,j)].get('construction',{}).get('briqueterie',0)>0)/(20*12):.2f}" for t in range(6)])
# crises
for name, D in (('sans réno', B), ('réno', R)):
    n = sum(1 for k in D if D[k]['chomage'] > 0.12); m = sum(1 for k in D if D[k]['sansAbri'] > 200)
    print(name, ': relevés chômage > 12 % :', n, '; sans-abri > 200 :', m, '; IPC > 10 :', sum(1 for k in D if D[k]['ipcMoyen'] > 10), '; total relevés', len(D))
print()
print("Par graine : épisodes de l'entrepreneur général, part des relevés où il est actif, plus long trou, IPC max, parc min, attente max, sans-abri max")
for g in seeds:
    rs = [R[(g, j)] for j in range(250, 18001, 250)]
    on = [r['construction'].get('entrepreneur', 0) > 0 for r in rs]
    waves = sum(1 for i, x in enumerate(on) if x and (i == 0 or not on[i - 1]))
    gap = best = 0
    for x in on:
        gap = 0 if x else gap + 1; best = max(best, gap)
    print(g, waves, f'{sum(on)/len(on):.2f}', best * 250, f"{max(r['ipcMoyen'] for r in rs):.2f}", f"{min(r['etatParc'] for r in rs):.3f}",
          int(max(r['enRenovation'] for r in rs)), int(max(r['sansAbri'] for r in rs)))
