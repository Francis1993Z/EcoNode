# Comparaison appariée avant / après (RESUME de deflation.dart) : fichiers « <prefixe>-g<graine>-avant.txt » et « -apres.txt »
#   python agg_paires.py dossier prefixe [pas]
import sys, glob, json, os, re, statistics as st
d, pre = sys.argv[1], sys.argv[2]
step = int(sys.argv[3]) if len(sys.argv) > 3 else 500

def load(f):
    for l in open(f, encoding='utf-8'):
        if l.startswith('RESUME '):
            return json.loads(l[7:])['series']
    return None

pairs = {}
for f in glob.glob(os.path.join(d, pre + '-g*-*.txt')):
    m = re.search(r'-g(\d+)-(avant|apres)\.txt$', f)
    if not m: continue
    s = load(f)
    if s: pairs.setdefault(int(m.group(1)), {})[m.group(2)] = s
seeds = sorted(g for g in pairs if len(pairs[g]) == 2)
missing = sorted(g for g in pairs if len(pairs[g]) != 2)
print(f'{pre} : {len(seeds)} paires (graines {seeds}){" ; incomplètes " + str(missing) if missing else ""}')

def win(s, k, lo, hi):
    j = s['jour']; v = s[k]
    xs = [v[i] for i in range(len(j)) if lo < j[i] <= hi]
    return st.mean(xs) if xs else float('nan')

def at(s, k, day):
    j = s['jour']
    for i in range(len(j)):
        if j[i] == day: return s[k][i]
    return 1.0 if k == 'ipc' and day == 0 else float('nan')

def infl(s, lo, hi):
    a, b = at(s, 'ipc', lo), at(s, 'ipc', hi)
    return ((b / a) ** (365 / (hi - lo)) - 1) * 100

def row(label, fa, fb, fmt='{:7.2f}', better=lambda x, y: y < x):
    a = [fa(pairs[g]['avant']) for g in seeds]
    b = [fb(pairs[g]['apres']) for g in seeds]
    dd = [y - x for x, y in zip(a, b)]
    nb = sum(1 for x, y in zip(a, b) if better(x, y))
    sd = st.stdev(dd) if len(dd) > 1 else 0
    f = lambda v: fmt.format(v)
    print(f'  {label:<22} avant {f(st.mean(a))} (pire {f(max(a))})  après {f(st.mean(b))} (pire {f(max(b))})  '
          f'écart {f(st.mean(dd))} ± {f(sd / len(dd) ** 0.5)} (e.-t. moy.)  meilleur {nb}/{len(dd)}')

days = int(max(pairs[seeds[0]]['avant']['jour']))
print(' chômage (%) par tranche :')
for lo in range(0, days, step):
    hi = lo + step
    row(f'jours {lo+1}-{hi}', lambda s: win(s, 'chomage', lo, hi) * 100, lambda s: win(s, 'chomage', lo, hi) * 100)
print(' indice des prix moyen par tranche :')
for lo in range(0, days, step):
    hi = lo + step
    row(f'jours {lo+1}-{hi}', lambda s: win(s, 'ipc', lo, hi), lambda s: win(s, 'ipc', lo, hi), better=lambda x, y: abs(y - 1) < abs(x - 1))
print(' inflation annualisée (%) :')
for lo, hi in [(0, 250), (250, 500), (500, 1000), (1000, 1500), (500, 1500), (1500, 3000)]:
    if hi > days: continue
    row(f'jours {lo}-{hi}', lambda s: infl(s, lo, hi), lambda s: infl(s, lo, hi), fmt='{:7.1f}', better=lambda x, y: abs(y) < abs(x))
print(' autres :')
row('machines j50', lambda s: at(s, 'machines', 50), lambda s: at(s, 'machines', 50), fmt='{:7.0f}', better=lambda x, y: y > x)
row('machines fin', lambda s: s['machines'][-1], lambda s: s['machines'][-1], fmt='{:7.0f}', better=lambda x, y: y > x)
row('indice max', lambda s: max(s['ipc']), lambda s: max(s['ipc']), better=lambda x, y: y < x)
row('indice fin', lambda s: s['ipc'][-1], lambda s: s['ipc'][-1], better=lambda x, y: abs(y - 1) < abs(x - 1))
row('salaire fin', lambda s: s['salaire'][-1], lambda s: s['salaire'][-1], fmt='{:7.0f}', better=lambda x, y: y > x)
row('ménages k$ fin', lambda s: s['menages'][-1] / 1000, lambda s: s['menages'][-1] / 1000, fmt='{:7.0f}', better=lambda x, y: y > x)
row('entreprises k$ fin', lambda s: s['entreprises'][-1] / 1000, lambda s: s['entreprises'][-1] / 1000, fmt='{:7.0f}')
row('actives fin', lambda s: s['actives'][-1], lambda s: s['actives'][-1], fmt='{:7.0f}', better=lambda x, y: y > x)
