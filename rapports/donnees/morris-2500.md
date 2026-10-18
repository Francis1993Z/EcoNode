# Criblage de Morris

- 2500 habitants, 600 jours (chauffe 100), filets actifs, k = 5 par défaut, 112 parties en 633 s.
- Paramètres et plages d'exploration : `markup` [0,9000 ; 1,5000], `mpcIncome` [0,3000 ; 0,9000], `priceStep` [0,0100 ; 0,0400], `wageStep` [0,0075 ; 0,0300], `priceMaxDaily` [0,0075 ; 0,0300], `wageMaxDaily` [0,0075 ; 0,0300], `dividendRate` [0,0400 ; 0,1600], `jobSwitch` [0,0150 ; 0,0600], `taxRate` [0,0600 ; 0,2400], `benefit` [40,0000 ; 160,0000], `interestRate` [0,0300 ; 0,1200], `entryCooldown` [30,0000 ; 120,0000], `entryMinShare` [0,0500 ; 0,2000].

## Chômage moyen

Effet d'un passage du bas au haut de la plage, en unité de l'indicateur (points de pourcentage).

| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |
|---|---|---|---|---|
| `markup` | 24,65 | 24,65 | 13,30 | 0,54 |
| `dividendRate` | 12,34 | -9,83 | 10,95 | 0,89 |
| `wageStep` | 7,62 | -4,92 | 8,77 | 1,15 |
| `mpcIncome` | 7,42 | -3,13 | 10,28 | 1,38 |
| `priceStep` | 6,74 | 4,56 | 8,13 | 1,21 |
| `wageMaxDaily` | 6,45 | 0,59 | 8,22 | 1,27 |
| `benefit` | 5,46 | -1,64 | 6,34 | 1,16 |
| `taxRate` | 5,30 | -5,14 | 5,49 | 1,04 |
| `interestRate` | 5,17 | 1,74 | 6,46 | 1,25 |
| `jobSwitch` | 4,65 | -3,26 | 7,47 | 1,61 |
| `priceMaxDaily` | 4,26 | 0,42 | 5,93 | 1,39 |
| `entryCooldown` | 0,67 | 0,32 | 1,29 | 1,91 |
| `entryMinShare` | 0,00 | 0,00 | 0,00 | — |

## Faim moyenne

Effet d'un passage du bas au haut de la plage, en unité de l'indicateur (points de pourcentage).

| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |
|---|---|---|---|---|
| `wageStep` | 3,55 | -1,97 | 5,99 | 1,69 |
| `taxRate` | 3,16 | -3,15 | 8,27 | 2,62 |
| `markup` | 2,94 | 2,94 | 5,19 | 1,77 |
| `benefit` | 2,38 | -0,19 | 4,82 | 2,03 |
| `wageMaxDaily` | 2,12 | 0,71 | 4,71 | 2,22 |
| `interestRate` | 1,76 | -1,29 | 3,65 | 2,08 |
| `priceMaxDaily` | 1,70 | 1,69 | 4,78 | 2,81 |
| `mpcIncome` | 0,84 | -0,82 | 1,43 | 1,71 |
| `priceStep` | 0,51 | 0,39 | 1,25 | 2,45 |
| `entryCooldown` | 0,08 | 0,08 | 0,23 | 2,71 |
| `dividendRate` | 0,07 | -0,06 | 0,11 | 1,64 |
| `jobSwitch` | 0,01 | -0,01 | 0,02 | 2,09 |
| `entryMinShare` | 0,00 | 0,00 | 0,00 | — |

## Sans-abri moyen

Effet d'un passage du bas au haut de la plage, en unité de l'indicateur (points de pourcentage).

| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |
|---|---|---|---|---|
| `taxRate` | 7,82 | -7,82 | 9,14 | 1,17 |
| `markup` | 6,72 | 6,72 | 7,89 | 1,18 |
| `wageStep` | 5,83 | -1,81 | 8,60 | 1,47 |
| `dividendRate` | 4,19 | -3,71 | 6,60 | 1,58 |
| `wageMaxDaily` | 3,24 | -1,07 | 6,93 | 2,14 |
| `priceMaxDaily` | 2,85 | -0,99 | 5,69 | 2,00 |
| `benefit` | 2,46 | 0,30 | 4,46 | 1,81 |
| `mpcIncome` | 2,28 | -1,47 | 3,97 | 1,74 |
| `interestRate` | 1,39 | -0,02 | 2,18 | 1,57 |
| `priceStep` | 0,89 | 0,54 | 2,02 | 2,26 |
| `jobSwitch` | 0,89 | -0,32 | 1,14 | 1,28 |
| `entryCooldown` | 0,21 | 0,21 | 0,51 | 2,39 |
| `entryMinShare` | 0,00 | 0,00 | 0,00 | — |

## Parc moyen d’entreprises

Effet d'un passage du bas au haut de la plage, en unité de l'indicateur (entreprises).

| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |
|---|---|---|---|---|
| `markup` | 17,52 | 3,46 | 21,11 | 1,21 |
| `priceStep` | 9,77 | 9,77 | 6,26 | 0,64 |
| `priceMaxDaily` | 8,56 | -5,68 | 10,59 | 1,24 |
| `wageStep` | 6,54 | 6,02 | 5,67 | 0,87 |
| `mpcIncome` | 5,21 | 1,32 | 8,41 | 1,61 |
| `dividendRate` | 5,20 | 4,46 | 5,79 | 1,11 |
| `taxRate` | 4,83 | 1,26 | 6,44 | 1,33 |
| `jobSwitch` | 4,40 | 1,46 | 5,53 | 1,26 |
| `wageMaxDaily` | 4,33 | -2,56 | 5,24 | 1,21 |
| `interestRate` | 4,13 | 1,99 | 4,94 | 1,20 |
| `benefit` | 3,15 | -0,56 | 3,97 | 1,26 |
| `entryCooldown` | 0,33 | 0,12 | 0,60 | 1,81 |
| `entryMinShare` | 0,00 | 0,00 | 0,00 | — |

## Inflation moyenne par jour

Effet d'un passage du bas au haut de la plage, en unité de l'indicateur (points de % par jour).

| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |
|---|---|---|---|---|
| `markup` | 0,21 | -0,06 | 0,28 | 1,35 |
| `mpcIncome` | 0,17 | 0,16 | 0,20 | 1,14 |
| `priceStep` | 0,14 | -0,04 | 0,19 | 1,40 |
| `benefit` | 0,13 | -0,05 | 0,20 | 1,56 |
| `priceMaxDaily` | 0,13 | 0,02 | 0,16 | 1,31 |
| `taxRate` | 0,12 | -0,11 | 0,18 | 1,50 |
| `dividendRate` | 0,12 | -0,08 | 0,15 | 1,21 |
| `interestRate` | 0,09 | 0,07 | 0,12 | 1,37 |
| `jobSwitch` | 0,08 | -0,05 | 0,13 | 1,63 |
| `wageStep` | 0,07 | -0,02 | 0,10 | 1,37 |
| `wageMaxDaily` | 0,05 | -0,03 | 0,07 | 1,29 |
| `entryCooldown` | 0,01 | 0,00 | 0,02 | 1,87 |
| `entryMinShare` | 0,00 | 0,00 | 0,00 | — |

## Gini moyen

Effet d'un passage du bas au haut de la plage, en unité de l'indicateur (indice).

| Paramètre | μ* (importance) | μ (sens) | σ | σ / μ* |
|---|---|---|---|---|
| `markup` | 0,38 | 0,38 | 0,18 | 0,49 |
| `mpcIncome` | 0,18 | 0,18 | 0,15 | 0,85 |
| `taxRate` | 0,17 | -0,17 | 0,06 | 0,34 |
| `priceStep` | 0,16 | 0,15 | 0,11 | 0,70 |
| `dividendRate` | 0,12 | -0,03 | 0,14 | 1,22 |
| `wageMaxDaily` | 0,11 | -0,04 | 0,13 | 1,12 |
| `priceMaxDaily` | 0,09 | 0,03 | 0,11 | 1,28 |
| `benefit` | 0,08 | -0,04 | 0,10 | 1,22 |
| `interestRate` | 0,07 | 0,06 | 0,07 | 0,92 |
| `jobSwitch` | 0,05 | 0,00 | 0,07 | 1,37 |
| `wageStep` | 0,05 | 0,03 | 0,07 | 1,37 |
| `entryCooldown` | 0,01 | 0,01 | 0,04 | 2,61 |
| `entryMinShare` | 0,00 | 0,00 | 0,00 | — |

Lecture : μ* grand = le paramètre compte ; μ de même signe que μ* = effet monotone ; σ / μ* au-dessus de 1 = effet qui change de sens ou dépend des autres paramètres. Avec r = 8 trajectoires, un μ* proche de σ / √r est du bruit.

