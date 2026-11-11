# N6 et N18 : sorties de l'agrégation appariée

Serveur de calcul, révision f6edd963c26c (branche fix/n6-n18), sonde tool/deflation.dart, réglages de l'interface
(tool/emergence.dart:parametresInterface), 10 graines × 3 000 j. « avant » : --param planFreshSolve=0,directedSearch=0,excessCashDays=60 ;
« après » : réglages de l'interface (plan sans mémoire, candidature ciblée, réserve de 20 jours). Écart = après − avant, graine par
graine ; ± = erreur-type de l'écart moyen ; « meilleur » = graines où l'après est meilleur (chômage plus bas, indice plus près de 1,
inflation plus près de 0). « pire » = le plus grand des 10 (pour l'inflation, le plus haut, pas le plus mauvais).
Script : agg_paires.py (copié dans ce dossier).

## 2 500 citoyens, Produits coupé (N18)

```
defl-p2500-pr0 : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant   12.27 (pire   13.10)  après    4.25 (pire    5.15)  écart   -8.02 ±    0.21 (e.-t. moy.)  meilleur 10/10
  jours 501-1000         avant   34.50 (pire   36.24)  après    7.66 (pire    8.53)  écart  -26.84 ±    0.52 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant   48.09 (pire   51.84)  après    6.59 (pire    7.18)  écart  -41.51 ±    0.73 (e.-t. moy.)  meilleur 10/10
  jours 1501-2000        avant   53.73 (pire   57.09)  après    7.05 (pire    7.71)  écart  -46.68 ±    0.78 (e.-t. moy.)  meilleur 10/10
  jours 2001-2500        avant   54.67 (pire   58.43)  après    6.46 (pire    7.95)  écart  -48.21 ±    0.75 (e.-t. moy.)  meilleur 10/10
  jours 2501-3000        avant   54.50 (pire   57.70)  après    4.97 (pire    6.01)  écart  -49.53 ±    0.76 (e.-t. moy.)  meilleur 10/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.34 (pire    1.38)  après    1.25 (pire    1.26)  écart   -0.09 ±    0.01 (e.-t. moy.)  meilleur 10/10
  jours 501-1000         avant    1.67 (pire    1.74)  après    1.23 (pire    1.25)  écart   -0.44 ±    0.02 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant    2.09 (pire    2.32)  après    1.15 (pire    1.17)  écart   -0.94 ±    0.04 (e.-t. moy.)  meilleur 10/10
  jours 1501-2000        avant    2.63 (pire    3.01)  après    1.11 (pire    1.14)  écart   -1.52 ±    0.06 (e.-t. moy.)  meilleur 10/10
  jours 2001-2500        avant    3.28 (pire    4.03)  après    1.07 (pire    1.12)  écart   -2.21 ±    0.11 (e.-t. moy.)  meilleur 10/10
  jours 2501-3000        avant    4.00 (pire    5.12)  après    1.06 (pire    1.11)  écart   -2.94 ±    0.18 (e.-t. moy.)  meilleur 10/10
 inflation annualisée (%) :
  jours 0-250            avant    61.7 (pire    68.2)  après    48.4 (pire    55.5)  écart   -13.3 ±     1.8 (e.-t. moy.)  meilleur 10/10
  jours 250-500          avant     6.8 (pire    10.6)  après    -6.7 (pire     1.9)  écart   -13.5 ±     1.8 (e.-t. moy.)  meilleur 5/10
  jours 500-1000         avant    20.0 (pire    27.5)  après    -3.1 (pire     3.4)  écart   -23.1 ±     2.3 (e.-t. moy.)  meilleur 10/10
  jours 1000-1500        avant    16.5 (pire    25.2)  après    -2.9 (pire     0.8)  écart   -19.4 ±     1.4 (e.-t. moy.)  meilleur 10/10
  jours 500-1500         avant    18.2 (pire    24.4)  après    -3.0 (pire    -1.8)  écart   -21.2 ±     1.1 (e.-t. moy.)  meilleur 10/10
  jours 1500-3000        avant    16.7 (pire    21.3)  après    -1.7 (pire    -0.5)  écart   -18.4 ±     1.2 (e.-t. moy.)  meilleur 10/10
 autres :
  machines j50           avant       0 (pire       0)  après    4238 (pire    4263)  écart    4238 ±       6 (e.-t. moy.)  meilleur 10/10
  machines fin           avant       0 (pire       0)  après    3069 (pire    3417)  écart    3069 ±      79 (e.-t. moy.)  meilleur 10/10
  indice max             avant    4.37 (pire    5.52)  après    1.32 (pire    1.35)  écart   -3.05 ±    0.20 (e.-t. moy.)  meilleur 10/10
  indice fin             avant    4.36 (pire    5.52)  après    1.07 (pire    1.11)  écart   -3.30 ±    0.21 (e.-t. moy.)  meilleur 10/10
  salaire fin            avant     773 (pire    1001)  après     201 (pire     206)  écart    -572 ±      38 (e.-t. moy.)  meilleur 0/10
  ménages k$ fin         avant    7475 (pire    9853)  après    5253 (pire    5517)  écart   -2223 ±     441 (e.-t. moy.)  meilleur 1/10
  entreprises k$ fin     avant   15384 (pire   19336)  après    6647 (pire    6991)  écart   -8737 ±     647 (e.-t. moy.)  meilleur 10/10
  actives fin            avant     103 (pire     114)  après     166 (pire     178)  écart      63 ±       4 (e.-t. moy.)  meilleur 10/10
```

## 2 500 citoyens, Produits actif

```
defl-p2500-pr1 : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant    7.74 (pire    8.49)  après    5.62 (pire    6.45)  écart   -2.12 ±    0.41 (e.-t. moy.)  meilleur 9/10
  jours 501-1000         avant    9.49 (pire   16.61)  après    4.54 (pire    6.59)  écart   -4.95 ±    0.72 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant    6.86 (pire   12.25)  après    4.88 (pire    6.87)  écart   -1.98 ±    0.54 (e.-t. moy.)  meilleur 10/10
  jours 1501-2000        avant    5.53 (pire    9.43)  après    6.40 (pire    9.95)  écart    0.88 ±    0.69 (e.-t. moy.)  meilleur 2/10
  jours 2001-2500        avant    7.67 (pire   16.57)  après    6.55 (pire   10.84)  écart   -1.12 ±    1.32 (e.-t. moy.)  meilleur 6/10
  jours 2501-3000        avant    8.38 (pire   13.75)  après    6.55 (pire   10.25)  écart   -1.83 ±    1.15 (e.-t. moy.)  meilleur 7/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.16 (pire    1.22)  après    1.17 (pire    1.21)  écart    0.01 ±    0.01 (e.-t. moy.)  meilleur 3/10
  jours 501-1000         avant    1.03 (pire    1.17)  après    1.09 (pire    1.14)  écart    0.06 ±    0.02 (e.-t. moy.)  meilleur 3/10
  jours 1001-1500        avant    1.04 (pire    1.11)  après    1.14 (pire    1.24)  écart    0.09 ±    0.02 (e.-t. moy.)  meilleur 1/10
  jours 1501-2000        avant    1.10 (pire    1.22)  après    1.21 (pire    1.32)  écart    0.10 ±    0.02 (e.-t. moy.)  meilleur 0/10
  jours 2001-2500        avant    1.17 (pire    1.37)  après    1.23 (pire    1.47)  écart    0.06 ±    0.02 (e.-t. moy.)  meilleur 3/10
  jours 2501-3000        avant    1.17 (pire    1.32)  après    1.23 (pire    1.34)  écart    0.06 ±    0.03 (e.-t. moy.)  meilleur 4/10
 inflation annualisée (%) :
  jours 0-250            avant    32.8 (pire    44.2)  après    31.7 (pire    43.5)  écart    -1.0 ±     1.5 (e.-t. moy.)  meilleur 6/10
  jours 250-500          avant   -15.5 (pire    -5.4)  après   -11.4 (pire    -2.9)  écart     4.1 ±     2.7 (e.-t. moy.)  meilleur 8/10
  jours 500-1000         avant    -5.3 (pire     0.7)  après    -1.0 (pire     4.3)  écart     4.3 ±     2.0 (e.-t. moy.)  meilleur 5/10
  jours 1000-1500        avant     4.0 (pire    16.5)  après     5.6 (pire    22.2)  écart     1.6 ±     3.7 (e.-t. moy.)  meilleur 4/10
  jours 500-1500         avant    -0.9 (pire     6.5)  après     2.1 (pire     8.1)  écart     3.0 ±     1.7 (e.-t. moy.)  meilleur 6/10
  jours 1500-3000        avant     2.1 (pire     7.9)  après     0.3 (pire     5.1)  écart    -1.7 ±     1.3 (e.-t. moy.)  meilleur 3/10
 autres :
  machines j50           avant    3363 (pire    4276)  après    4223 (pire    4326)  écart     860 ±     563 (e.-t. moy.)  meilleur 6/10
  machines fin           avant    3179 (pire    4815)  après    3897 (pire    4648)  écart     718 ±     586 (e.-t. moy.)  meilleur 4/10
  indice max             avant    1.31 (pire    1.48)  après    1.39 (pire    1.56)  écart    0.08 ±    0.03 (e.-t. moy.)  meilleur 3/10
  indice fin             avant    1.14 (pire    1.26)  après    1.19 (pire    1.43)  écart    0.05 ±    0.04 (e.-t. moy.)  meilleur 3/10
  salaire fin            avant     218 (pire     252)  après     225 (pire     272)  écart       7 ±       8 (e.-t. moy.)  meilleur 6/10
  ménages k$ fin         avant    3026 (pire    3532)  après    3676 (pire    4810)  écart     650 ±     231 (e.-t. moy.)  meilleur 8/10
  entreprises k$ fin     avant    8703 (pire    9169)  après    7981 (pire    8542)  écart    -722 ±     184 (e.-t. moy.)  meilleur 9/10
  actives fin            avant     148 (pire     168)  après     146 (pire     161)  écart      -2 ±       4 (e.-t. moy.)  meilleur 5/10
```

## 240 citoyens, Produits actif (N6)

```
defl-p240-pr1 : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant    6.30 (pire    7.34)  après    4.84 (pire    6.64)  écart   -1.47 ±    0.33 (e.-t. moy.)  meilleur 9/10
  jours 501-1000         avant    7.29 (pire    8.82)  après    5.05 (pire    7.04)  écart   -2.24 ±    0.40 (e.-t. moy.)  meilleur 9/10
  jours 1001-1500        avant    5.92 (pire    8.97)  après    5.45 (pire    7.15)  écart   -0.47 ±    0.50 (e.-t. moy.)  meilleur 7/10
  jours 1501-2000        avant    4.88 (pire    6.14)  après    5.03 (pire    7.03)  écart    0.16 ±    0.57 (e.-t. moy.)  meilleur 6/10
  jours 2001-2500        avant    4.84 (pire    6.20)  après    4.24 (pire    7.81)  écart   -0.60 ±    0.58 (e.-t. moy.)  meilleur 7/10
  jours 2501-3000        avant    5.04 (pire    7.66)  après    3.94 (pire    5.87)  écart   -1.10 ±    0.60 (e.-t. moy.)  meilleur 8/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.14 (pire    1.52)  après    1.13 (pire    1.25)  écart   -0.01 ±    0.03 (e.-t. moy.)  meilleur 4/10
  jours 501-1000         avant    0.91 (pire    1.07)  après    1.07 (pire    1.27)  écart    0.16 ±    0.03 (e.-t. moy.)  meilleur 8/10
  jours 1001-1500        avant    0.81 (pire    1.03)  après    1.09 (pire    1.29)  écart    0.29 ±    0.04 (e.-t. moy.)  meilleur 7/10
  jours 1501-2000        avant    0.79 (pire    1.05)  après    1.07 (pire    1.25)  écart    0.28 ±    0.05 (e.-t. moy.)  meilleur 9/10
  jours 2001-2500        avant    0.82 (pire    1.08)  après    1.09 (pire    1.26)  écart    0.27 ±    0.05 (e.-t. moy.)  meilleur 9/10
  jours 2501-3000        avant    0.85 (pire    1.18)  après    1.10 (pire    1.32)  écart    0.25 ±    0.05 (e.-t. moy.)  meilleur 9/10
 inflation annualisée (%) :
  jours 0-250            avant    32.1 (pire   102.4)  après    26.7 (pire    45.5)  écart    -5.4 ±     6.4 (e.-t. moy.)  meilleur 6/10
  jours 250-500          avant   -16.0 (pire    -3.7)  après    -8.0 (pire     3.6)  écart     8.1 ±     3.7 (e.-t. moy.)  meilleur 8/10
  jours 500-1000         avant   -15.9 (pire    -4.3)  après    -1.8 (pire     5.0)  écart    14.1 ±     2.1 (e.-t. moy.)  meilleur 8/10
  jours 1000-1500        avant    -3.6 (pire     7.6)  après    -0.4 (pire     7.6)  écart     3.2 ±     2.6 (e.-t. moy.)  meilleur 10/10
  jours 500-1500         avant   -10.2 (pire    -3.7)  après    -1.2 (pire     6.3)  écart     9.0 ±     1.6 (e.-t. moy.)  meilleur 9/10
  jours 1500-3000        avant     1.6 (pire     5.2)  après     1.1 (pire     4.2)  écart    -0.6 ±     1.3 (e.-t. moy.)  meilleur 6/10
 autres :
  machines j50           avant     391 (pire     416)  après     393 (pire     400)  écart       2 ±       3 (e.-t. moy.)  meilleur 7/10
  machines fin           avant     423 (pire     487)  après     421 (pire     516)  écart      -2 ±      13 (e.-t. moy.)  meilleur 3/10
  indice max             avant    1.23 (pire    1.76)  après    1.27 (pire    1.40)  écart    0.03 ±    0.06 (e.-t. moy.)  meilleur 1/10
  indice fin             avant    0.85 (pire    1.19)  après    1.11 (pire    1.25)  écart    0.27 ±    0.04 (e.-t. moy.)  meilleur 9/10
  salaire fin            avant     152 (pire     195)  après     208 (pire     229)  écart      57 ±       6 (e.-t. moy.)  meilleur 10/10
  ménages k$ fin         avant     242 (pire     297)  après     376 (pire     440)  écart     134 ±      24 (e.-t. moy.)  meilleur 10/10
  entreprises k$ fin     avant     944 (pire    1007)  après     790 (pire     913)  écart    -154 ±      25 (e.-t. moy.)  meilleur 9/10
  actives fin            avant      43 (pire      48)  après      44 (pire      47)  écart       1 ±       1 (e.-t. moy.)  meilleur 4/10
```

## 240 citoyens, Produits coupé

```
defl-p240-pr0 : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant    5.88 (pire    7.19)  après    5.99 (pire    6.62)  écart    0.11 ±    0.31 (e.-t. moy.)  meilleur 4/10
  jours 501-1000         avant    8.61 (pire   10.59)  après    4.35 (pire    5.40)  écart   -4.26 ±    0.33 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant    4.88 (pire    6.36)  après    4.66 (pire    5.65)  écart   -0.22 ±    0.44 (e.-t. moy.)  meilleur 5/10
  jours 1501-2000        avant    4.77 (pire    5.50)  après    4.95 (pire    6.26)  écart    0.18 ±    0.39 (e.-t. moy.)  meilleur 4/10
  jours 2001-2500        avant    5.27 (pire    6.81)  après    4.57 (pire    5.86)  écart   -0.70 ±    0.60 (e.-t. moy.)  meilleur 6/10
  jours 2501-3000        avant    4.33 (pire    6.24)  après    4.33 (pire    5.54)  écart    0.00 ±    0.61 (e.-t. moy.)  meilleur 6/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.01 (pire    1.07)  après    1.03 (pire    1.07)  écart    0.02 ±    0.02 (e.-t. moy.)  meilleur 5/10
  jours 501-1000         avant    0.80 (pire    0.88)  après    0.96 (pire    1.02)  écart    0.16 ±    0.01 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant    0.72 (pire    0.75)  après    0.98 (pire    1.02)  écart    0.26 ±    0.01 (e.-t. moy.)  meilleur 10/10
  jours 1501-2000        avant    0.70 (pire    0.73)  après    0.97 (pire    1.03)  écart    0.27 ±    0.01 (e.-t. moy.)  meilleur 10/10
  jours 2001-2500        avant    0.73 (pire    0.78)  après    0.95 (pire    1.00)  écart    0.22 ±    0.02 (e.-t. moy.)  meilleur 10/10
  jours 2501-3000        avant    0.74 (pire    0.85)  après    0.98 (pire    1.12)  écart    0.23 ±    0.02 (e.-t. moy.)  meilleur 10/10
 inflation annualisée (%) :
  jours 0-250            avant     5.2 (pire    14.0)  après     8.3 (pire    16.4)  écart     3.1 ±     2.5 (e.-t. moy.)  meilleur 3/10
  jours 250-500          avant    -8.9 (pire     0.5)  après   -11.4 (pire    -4.4)  écart    -2.5 ±     2.8 (e.-t. moy.)  meilleur 3/10
  jours 500-1000         avant   -21.4 (pire   -15.6)  après    -0.4 (pire     2.7)  écart    21.0 ±     1.8 (e.-t. moy.)  meilleur 10/10
  jours 1000-1500        avant     2.4 (pire    16.5)  après     0.5 (pire     6.6)  écart    -1.8 ±     3.1 (e.-t. moy.)  meilleur 10/10
  jours 500-1500         avant   -10.5 (pire    -7.8)  après     0.0 (pire     2.1)  écart    10.5 ±     0.8 (e.-t. moy.)  meilleur 10/10
  jours 1500-3000        avant     1.9 (pire     6.8)  après     0.3 (pire     3.4)  écart    -1.6 ±     1.1 (e.-t. moy.)  meilleur 7/10
 autres :
  machines j50           avant     388 (pire     392)  après     393 (pire     400)  écart       5 ±       2 (e.-t. moy.)  meilleur 9/10
  machines fin           avant     401 (pire     437)  après     389 (pire     443)  écart     -12 ±      14 (e.-t. moy.)  meilleur 3/10
  indice max             avant    1.06 (pire    1.14)  après    1.10 (pire    1.16)  écart    0.04 ±    0.02 (e.-t. moy.)  meilleur 4/10
  indice fin             avant    0.77 (pire    0.92)  après    0.98 (pire    1.13)  écart    0.21 ±    0.04 (e.-t. moy.)  meilleur 10/10
  salaire fin            avant     144 (pire     162)  après     185 (pire     194)  écart      41 ±       4 (e.-t. moy.)  meilleur 10/10
  ménages k$ fin         avant     334 (pire     409)  après     428 (pire     456)  écart      94 ±      16 (e.-t. moy.)  meilleur 10/10
  entreprises k$ fin     avant     858 (pire     945)  après     733 (pire     753)  écart    -125 ±      22 (e.-t. moy.)  meilleur 10/10
  actives fin            avant      38 (pire      42)  après      37 (pire      40)  écart      -1 ±       1 (e.-t. moy.)  meilleur 4/10
```

## Décomposition (lot 7)

### 2 500 Produits coupé : avant → plan sans mémoire + candidature ciblée (réserve 60 j)

```
x : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant   12.27 (pire   13.10)  après    4.56 (pire    5.09)  écart   -7.71 ±    0.22 (e.-t. moy.)  meilleur 10/10
  jours 501-1000         avant   34.50 (pire   36.24)  après    7.94 (pire    8.44)  écart  -26.56 ±    0.59 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant   48.09 (pire   51.84)  après    6.70 (pire    8.11)  écart  -41.40 ±    0.82 (e.-t. moy.)  meilleur 10/10
  jours 1501-2000        avant   53.73 (pire   57.09)  après    7.41 (pire    8.00)  écart  -46.32 ±    0.74 (e.-t. moy.)  meilleur 10/10
  jours 2001-2500        avant   54.67 (pire   58.43)  après    6.23 (pire    7.73)  écart  -48.44 ±    0.66 (e.-t. moy.)  meilleur 10/10
  jours 2501-3000        avant   54.50 (pire   57.70)  après    3.87 (pire    6.86)  écart  -50.62 ±    0.72 (e.-t. moy.)  meilleur 10/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.34 (pire    1.38)  après    1.24 (pire    1.26)  écart   -0.10 ±    0.01 (e.-t. moy.)  meilleur 10/10
  jours 501-1000         avant    1.67 (pire    1.74)  après    1.23 (pire    1.25)  écart   -0.44 ±    0.02 (e.-t. moy.)  meilleur 10/10
  jours 1001-1500        avant    2.09 (pire    2.32)  après    1.13 (pire    1.18)  écart   -0.95 ±    0.04 (e.-t. moy.)  meilleur 10/10
  jours 1501-2000        avant    2.63 (pire    3.01)  après    1.09 (pire    1.13)  écart   -1.54 ±    0.06 (e.-t. moy.)  meilleur 10/10
  jours 2001-2500        avant    3.28 (pire    4.03)  après    1.03 (pire    1.08)  écart   -2.25 ±    0.11 (e.-t. moy.)  meilleur 10/10
  jours 2501-3000        avant    4.00 (pire    5.12)  après    1.06 (pire    1.12)  écart   -2.94 ±    0.17 (e.-t. moy.)  meilleur 10/10
 inflation annualisée (%) :
  jours 0-250            avant    61.7 (pire    68.2)  après    48.7 (pire    53.5)  écart   -12.9 ±     1.2 (e.-t. moy.)  meilleur 10/10
  jours 250-500          avant     6.8 (pire    10.6)  après    -8.0 (pire    -2.6)  écart   -14.9 ±     1.2 (e.-t. moy.)  meilleur 3/10
  jours 500-1000         avant    20.0 (pire    27.5)  après    -3.9 (pire     0.3)  écart   -23.9 ±     1.6 (e.-t. moy.)  meilleur 10/10
  jours 1000-1500        avant    16.5 (pire    25.2)  après    -2.9 (pire     1.6)  écart   -19.4 ±     1.5 (e.-t. moy.)  meilleur 10/10
  jours 500-1500         avant    18.2 (pire    24.4)  après    -3.4 (pire    -1.9)  écart   -21.6 ±     0.8 (e.-t. moy.)  meilleur 10/10
  jours 1500-3000        avant    16.7 (pire    21.3)  après    -0.6 (pire     0.8)  écart   -17.3 ±     1.2 (e.-t. moy.)  meilleur 10/10
 autres :
  machines j50           avant       0 (pire       0)  après    4206 (pire    4264)  écart    4206 ±      11 (e.-t. moy.)  meilleur 10/10
  machines fin           avant       0 (pire       0)  après    3065 (pire    3260)  écart    3065 ±      51 (e.-t. moy.)  meilleur 10/10
  indice max             avant    4.37 (pire    5.52)  après    1.31 (pire    1.34)  écart   -3.06 ±    0.20 (e.-t. moy.)  meilleur 10/10
  indice fin             avant    4.36 (pire    5.52)  après    1.10 (pire    1.16)  écart   -3.26 ±    0.20 (e.-t. moy.)  meilleur 10/10
  salaire fin            avant     773 (pire    1001)  après     203 (pire     219)  écart    -570 ±      36 (e.-t. moy.)  meilleur 0/10
  ménages k$ fin         avant    7475 (pire    9853)  après    5112 (pire    5345)  écart   -2363 ±     434 (e.-t. moy.)  meilleur 1/10
  entreprises k$ fin     avant   15384 (pire   19336)  après    6800 (pire    6875)  écart   -8584 ±     639 (e.-t. moy.)  meilleur 10/10
  actives fin            avant     103 (pire     114)  après     170 (pire     187)  écart      67 ±       3 (e.-t. moy.)  meilleur 10/10
```

### 2 500 Produits coupé : plan + candidature (60 j) → les trois réglages

```
x : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant    4.56 (pire    5.09)  après    4.25 (pire    5.15)  écart   -0.31 ±    0.21 (e.-t. moy.)  meilleur 7/10
  jours 501-1000         avant    7.94 (pire    8.44)  après    7.66 (pire    8.53)  écart   -0.28 ±    0.25 (e.-t. moy.)  meilleur 7/10
  jours 1001-1500        avant    6.70 (pire    8.11)  après    6.59 (pire    7.18)  écart   -0.11 ±    0.40 (e.-t. moy.)  meilleur 4/10
  jours 1501-2000        avant    7.41 (pire    8.00)  après    7.05 (pire    7.71)  écart   -0.36 ±    0.29 (e.-t. moy.)  meilleur 8/10
  jours 2001-2500        avant    6.23 (pire    7.73)  après    6.46 (pire    7.95)  écart    0.23 ±    0.38 (e.-t. moy.)  meilleur 5/10
  jours 2501-3000        avant    3.87 (pire    6.86)  après    4.97 (pire    6.01)  écart    1.10 ±    0.73 (e.-t. moy.)  meilleur 3/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.24 (pire    1.26)  après    1.25 (pire    1.26)  écart    0.01 ±    0.01 (e.-t. moy.)  meilleur 2/10
  jours 501-1000         avant    1.23 (pire    1.25)  après    1.23 (pire    1.25)  écart    0.00 ±    0.01 (e.-t. moy.)  meilleur 3/10
  jours 1001-1500        avant    1.13 (pire    1.18)  après    1.15 (pire    1.17)  écart    0.02 ±    0.01 (e.-t. moy.)  meilleur 1/10
  jours 1501-2000        avant    1.09 (pire    1.13)  après    1.11 (pire    1.14)  écart    0.02 ±    0.01 (e.-t. moy.)  meilleur 5/10
  jours 2001-2500        avant    1.03 (pire    1.08)  après    1.07 (pire    1.12)  écart    0.04 ±    0.01 (e.-t. moy.)  meilleur 1/10
  jours 2501-3000        avant    1.06 (pire    1.12)  après    1.06 (pire    1.11)  écart    0.00 ±    0.01 (e.-t. moy.)  meilleur 4/10
 inflation annualisée (%) :
  jours 0-250            avant    48.7 (pire    53.5)  après    48.4 (pire    55.5)  écart    -0.4 ±     1.6 (e.-t. moy.)  meilleur 5/10
  jours 250-500          avant    -8.0 (pire    -2.6)  après    -6.7 (pire     1.9)  écart     1.3 ±     1.3 (e.-t. moy.)  meilleur 6/10
  jours 500-1000         avant    -3.9 (pire     0.3)  après    -3.1 (pire     3.4)  écart     0.8 ±     1.5 (e.-t. moy.)  meilleur 5/10
  jours 1000-1500        avant    -2.9 (pire     1.6)  après    -2.9 (pire     0.8)  écart     0.0 ±     1.3 (e.-t. moy.)  meilleur 7/10
  jours 500-1500         avant    -3.4 (pire    -1.9)  après    -3.0 (pire    -1.8)  écart     0.4 ±     0.4 (e.-t. moy.)  meilleur 6/10
  jours 1500-3000        avant    -0.6 (pire     0.8)  après    -1.7 (pire    -0.5)  écart    -1.1 ±     0.5 (e.-t. moy.)  meilleur 3/10
 autres :
  machines j50           avant    4206 (pire    4264)  après    4238 (pire    4263)  écart      33 ±      15 (e.-t. moy.)  meilleur 7/10
  machines fin           avant    3065 (pire    3260)  après    3069 (pire    3417)  écart       4 ±     106 (e.-t. moy.)  meilleur 5/10
  indice max             avant    1.31 (pire    1.34)  après    1.32 (pire    1.35)  écart    0.00 ±    0.01 (e.-t. moy.)  meilleur 4/10
  indice fin             avant    1.10 (pire    1.16)  après    1.07 (pire    1.11)  écart   -0.03 ±    0.02 (e.-t. moy.)  meilleur 7/10
  salaire fin            avant     203 (pire     219)  après     201 (pire     206)  écart      -2 ±       4 (e.-t. moy.)  meilleur 3/10
  ménages k$ fin         avant    5112 (pire    5345)  après    5253 (pire    5517)  écart     141 ±      49 (e.-t. moy.)  meilleur 7/10
  entreprises k$ fin     avant    6800 (pire    6875)  après    6647 (pire    6991)  écart    -153 ±      53 (e.-t. moy.)  meilleur 9/10
  actives fin            avant     170 (pire     187)  après     166 (pire     178)  écart      -4 ±       5 (e.-t. moy.)  meilleur 3/10
```

### 240 Produits actif : avant → plan + candidature (réserve 60 j)

```
x : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant    6.30 (pire    7.34)  après    5.75 (pire    7.09)  écart   -0.55 ±    0.25 (e.-t. moy.)  meilleur 8/10
  jours 501-1000         avant    7.29 (pire    8.82)  après    7.30 (pire   12.20)  écart    0.01 ±    0.48 (e.-t. moy.)  meilleur 5/10
  jours 1001-1500        avant    5.92 (pire    8.97)  après    8.13 (pire   21.96)  écart    2.21 ±    1.54 (e.-t. moy.)  meilleur 2/10
  jours 1501-2000        avant    4.88 (pire    6.14)  après    5.20 (pire    7.28)  écart    0.32 ±    0.62 (e.-t. moy.)  meilleur 4/10
  jours 2001-2500        avant    4.84 (pire    6.20)  après    4.24 (pire    6.34)  écart   -0.61 ±    0.38 (e.-t. moy.)  meilleur 6/10
  jours 2501-3000        avant    5.04 (pire    7.66)  après    3.68 (pire    4.89)  écart   -1.36 ±    0.52 (e.-t. moy.)  meilleur 9/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.14 (pire    1.52)  après    1.10 (pire    1.28)  écart   -0.04 ±    0.03 (e.-t. moy.)  meilleur 7/10
  jours 501-1000         avant    0.91 (pire    1.07)  après    0.94 (pire    1.07)  écart    0.03 ±    0.02 (e.-t. moy.)  meilleur 4/10
  jours 1001-1500        avant    0.81 (pire    1.03)  après    0.82 (pire    0.98)  écart    0.02 ±    0.03 (e.-t. moy.)  meilleur 5/10
  jours 1501-2000        avant    0.79 (pire    1.05)  après    0.77 (pire    1.01)  écart   -0.02 ±    0.04 (e.-t. moy.)  meilleur 6/10
  jours 2001-2500        avant    0.82 (pire    1.08)  après    0.82 (pire    1.11)  écart   -0.00 ±    0.03 (e.-t. moy.)  meilleur 5/10
  jours 2501-3000        avant    0.85 (pire    1.18)  après    0.86 (pire    1.19)  écart    0.01 ±    0.03 (e.-t. moy.)  meilleur 5/10
 inflation annualisée (%) :
  jours 0-250            avant    32.1 (pire   102.4)  après    23.5 (pire    63.5)  écart    -8.7 ±     3.8 (e.-t. moy.)  meilleur 8/10
  jours 250-500          avant   -16.0 (pire    -3.7)  après   -12.2 (pire    -5.2)  écart     3.8 ±     3.1 (e.-t. moy.)  meilleur 7/10
  jours 500-1000         avant   -15.9 (pire    -4.3)  après   -11.8 (pire    -0.3)  écart     4.2 ±     2.5 (e.-t. moy.)  meilleur 6/10
  jours 1000-1500        avant    -3.6 (pire     7.6)  après   -10.0 (pire     4.4)  écart    -6.4 ±     3.5 (e.-t. moy.)  meilleur 4/10
  jours 500-1500         avant   -10.2 (pire    -3.7)  après   -11.1 (pire    -5.7)  écart    -0.9 ±     1.7 (e.-t. moy.)  meilleur 3/10
  jours 1500-3000        avant     1.6 (pire     5.2)  après     3.7 (pire     5.4)  écart     2.0 ±     1.0 (e.-t. moy.)  meilleur 4/10
 autres :
  machines j50           avant     391 (pire     416)  après     389 (pire     403)  écart      -2 ±       2 (e.-t. moy.)  meilleur 4/10
  machines fin           avant     423 (pire     487)  après     403 (pire     523)  écart     -20 ±      47 (e.-t. moy.)  meilleur 7/10
  indice max             avant    1.23 (pire    1.76)  après    1.18 (pire    1.42)  écart   -0.06 ±    0.03 (e.-t. moy.)  meilleur 8/10
  indice fin             avant    0.85 (pire    1.19)  après    0.89 (pire    1.17)  écart    0.04 ±    0.03 (e.-t. moy.)  meilleur 8/10
  salaire fin            avant     152 (pire     195)  après     153 (pire     203)  écart       1 ±       7 (e.-t. moy.)  meilleur 7/10
  ménages k$ fin         avant     242 (pire     297)  après     268 (pire     334)  écart      26 ±      22 (e.-t. moy.)  meilleur 5/10
  entreprises k$ fin     avant     944 (pire    1007)  après     908 (pire     989)  écart     -36 ±      16 (e.-t. moy.)  meilleur 7/10
  actives fin            avant      43 (pire      48)  après      42 (pire      49)  écart      -0 ±       2 (e.-t. moy.)  meilleur 5/10
```

### 240 Produits actif : avant → plan + réserve 20 j (sans candidature)

```
x : 10 paires (graines [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
 chômage (%) par tranche :
  jours 1-500            avant    6.30 (pire    7.34)  après    4.99 (pire    6.85)  écart   -1.32 ±    0.30 (e.-t. moy.)  meilleur 10/10
  jours 501-1000         avant    7.29 (pire    8.82)  après    5.48 (pire    7.09)  écart   -1.81 ±    0.44 (e.-t. moy.)  meilleur 9/10
  jours 1001-1500        avant    5.92 (pire    8.97)  après    5.19 (pire    8.09)  écart   -0.73 ±    0.58 (e.-t. moy.)  meilleur 6/10
  jours 1501-2000        avant    4.88 (pire    6.14)  après    5.00 (pire    7.23)  écart    0.12 ±    0.58 (e.-t. moy.)  meilleur 6/10
  jours 2001-2500        avant    4.84 (pire    6.20)  après    4.58 (pire    6.47)  écart   -0.26 ±    0.57 (e.-t. moy.)  meilleur 7/10
  jours 2501-3000        avant    5.04 (pire    7.66)  après    4.26 (pire    6.15)  écart   -0.78 ±    0.67 (e.-t. moy.)  meilleur 7/10
 indice des prix moyen par tranche :
  jours 1-500            avant    1.14 (pire    1.52)  après    1.17 (pire    1.70)  écart    0.03 ±    0.02 (e.-t. moy.)  meilleur 3/10
  jours 501-1000         avant    0.91 (pire    1.07)  après    1.10 (pire    1.37)  écart    0.19 ±    0.02 (e.-t. moy.)  meilleur 7/10
  jours 1001-1500        avant    0.81 (pire    1.03)  après    1.08 (pire    1.17)  écart    0.28 ±    0.03 (e.-t. moy.)  meilleur 8/10
  jours 1501-2000        avant    0.79 (pire    1.05)  après    1.08 (pire    1.18)  écart    0.28 ±    0.03 (e.-t. moy.)  meilleur 8/10
  jours 2001-2500        avant    0.82 (pire    1.08)  après    1.09 (pire    1.22)  écart    0.27 ±    0.03 (e.-t. moy.)  meilleur 7/10
  jours 2501-3000        avant    0.85 (pire    1.18)  après    1.12 (pire    1.31)  écart    0.28 ±    0.05 (e.-t. moy.)  meilleur 7/10
 inflation annualisée (%) :
  jours 0-250            avant    32.1 (pire   102.4)  après    34.5 (pire   151.5)  écart     2.4 ±     5.8 (e.-t. moy.)  meilleur 7/10
  jours 250-500          avant   -16.0 (pire    -3.7)  après    -6.9 (pire     2.0)  écart     9.1 ±     2.3 (e.-t. moy.)  meilleur 8/10
  jours 500-1000         avant   -15.9 (pire    -4.3)  après    -4.2 (pire     3.8)  écart    11.7 ±     2.8 (e.-t. moy.)  meilleur 9/10
  jours 1000-1500        avant    -3.6 (pire     7.6)  après     1.9 (pire    10.8)  écart     5.5 ±     3.2 (e.-t. moy.)  meilleur 8/10
  jours 500-1500         avant   -10.2 (pire    -3.7)  après    -1.3 (pire     5.1)  écart     8.9 ±     2.1 (e.-t. moy.)  meilleur 9/10
  jours 1500-3000        avant     1.6 (pire     5.2)  après     1.0 (pire     4.8)  écart    -0.6 ±     1.0 (e.-t. moy.)  meilleur 7/10
 autres :
  machines j50           avant     391 (pire     416)  après     396 (pire     427)  écart       4 ±       2 (e.-t. moy.)  meilleur 6/10
  machines fin           avant     423 (pire     487)  après     409 (pire     477)  écart     -14 ±      14 (e.-t. moy.)  meilleur 3/10
  indice max             avant    1.23 (pire    1.76)  après    1.35 (pire    2.00)  écart    0.12 ±    0.03 (e.-t. moy.)  meilleur 1/10
  indice fin             avant    0.85 (pire    1.19)  après    1.14 (pire    1.29)  écart    0.29 ±    0.04 (e.-t. moy.)  meilleur 7/10
  salaire fin            avant     152 (pire     195)  après     205 (pire     236)  écart      53 ±       8 (e.-t. moy.)  meilleur 9/10
  ménages k$ fin         avant     242 (pire     297)  après     334 (pire     396)  écart      92 ±      20 (e.-t. moy.)  meilleur 9/10
  entreprises k$ fin     avant     944 (pire    1007)  après     827 (pire     883)  écart    -118 ±      19 (e.-t. moy.)  meilleur 10/10
  actives fin            avant      43 (pire      48)  après      44 (pire      48)  écart       1 ±       2 (e.-t. moy.)  meilleur 6/10
```

## Marché du travail (tool/embauche.dart, 2 500 citoyens, Produits coupé, 2 000 j)

Avant : révision ee2f4d033611, plan sans mémoire seul, graines 1-4 ; après : révision f6edd963c26c, réglages de l'interface, graines 1-2.
Par jour : embauches, refus ; refus : réserve ÷ plafond ; part des chômeurs au plancher de leur prestation ; chômage des professionnels ; offre et salaire moyens.

| Tranche | Variante | Chômage | Embauches/j | Refus/j | Réserve ÷ plafond (refus) | Au plancher | Chômage des professionnels | Offre | Salaire |
|---|---|---|---|---|---|---|---|---|---|
| 1-500 | avant | 9.2 % | 33.8 | 174 | 1.16 | 24 % | 14 % | 215 | 265 |
| 1-500 | après | 4.5 % | 34.1 | 0 | 0.00 | 1 % | 7 % | 214 | 246 |
| 501-1000 | avant | 28.6 % | 27.1 | 219 | 1.23 | 75 % | 41 % | 238 | 318 |
| 501-1000 | après | 8.4 % | 31.1 | 0 | 0.00 | 2 % | 11 % | 212 | 241 |
| 1001-1500 | avant | 45.4 % | 22.4 | 189 | 1.24 | 77 % | 56 % | 288 | 397 |
| 1001-1500 | après | 6.2 % | 28.9 | 0 | 0.00 | 0 % | 7 % | 192 | 220 |
| 1501-2000 | avant | 52.8 % | 19.3 | 153 | 1.25 | 73 % | 61 % | 352 | 483 |
| 1501-2000 | après | 6.9 % | 26.7 | 0 | 0.00 | 0 % | 8 % | 182 | 209 |
