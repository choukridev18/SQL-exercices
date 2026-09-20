# Exercices SQL — Série 2 (TechCorp)

Nouvelle série d'entraînement, même base que la série 1 (`setup.sql` + `schema.md`).
Les questions sont différentes : tu t'entraînes à nouveau, pas à recopier.

## Comment lancer

Depuis la racine du projet :

```bash
# 1. Recrée la base si besoin
sqlite3 database.db < setup.sql

# 2. Teste un exercice
./run.sh exercices-2/01_select_basique.sql
```

Ou en interactif :

```bash
sqlite3 database.db
.headers on
.mode column
.tables
```

## Progression

| Fichier | Niveau | Notions |
|---------|--------|---------|
| 01 | Débutant | SELECT, ORDER BY, LIMIT, DISTINCT, AS |
| 02 | Débutant | WHERE, IN, BETWEEN, LIKE, NULL |
| 03 | Débutant | COUNT, SUM, AVG, MIN, MAX, ROUND |
| 04 | Intermédiaire | GROUP BY, HAVING |
| 05 | Intermédiaire | INNER JOIN, self-join |
| 06 | Intermédiaire | LEFT JOIN, IS NULL |
| 07 | Intermédiaire | JOIN + GROUP BY + HAVING |
| 08 | QA | Vérifier des données, anomalies |
| 09 | QA entretien | Scénarios réalistes |
| 10 | Mix | Sans indices, comme à l'oral |

Écris tes requêtes sous `-- ↓ Écris ta requête ici :`
Les exercices ★ sont typiques d'entretien.
