# Exercices SQL — TechCorp

Environnement d'entraînement SQL avec SQLite, conçu pour préparer les entretiens techniques.

## Structure

```
sql/
├── setup.sql                    ← Crée et remplit la base de données
├── database.db                  ← La base SQLite (générée par setup.sql)
├── README.md
└── exercices/
    ├── 01_select_basique.sql    ← SELECT, ORDER BY, DISTINCT, LIMIT, AS
    ├── 02_where_filtres.sql     ← WHERE, AND/OR, IN, BETWEEN, LIKE, NULL
    ├── 03_jointures.sql         ← INNER JOIN, LEFT JOIN, self-join
    ├── 04_agregation_groupby.sql← COUNT, SUM, AVG, GROUP BY, HAVING
    ├── 05_sous_requetes.sql     ← Subqueries, EXISTS, CTE (WITH)
    ├── 06_window_functions.sql  ← ROW_NUMBER, RANK, LAG, SUM OVER...
    └── solutions/
        ├── 01_solutions.sql
        ├── 02_solutions.sql
        ├── 03_solutions.sql
        ├── 04_solutions.sql
        ├── 05_solutions.sql
        └── 06_solutions.sql
```

## Démarrage rapide

### 1. Initialise la base de données (une seule fois)
```bash
sqlite3 database.db < setup.sql
```

### 2. Ouvre un exercice
Ouvre un fichier d'exercice dans Cursor, écris ta requête, puis teste-la :
```bash
sqlite3 database.db "SELECT prenom, nom FROM employes LIMIT 5;"
```

### 3. Mode interactif (le plus pratique)
```bash
sqlite3 database.db
```
Puis tape tes requêtes directement. Commandes utiles :
- `.tables`        → liste les tables
- `.schema employes` → voir la structure d'une table
- `.headers on`    → afficher les noms de colonnes
- `.mode column`   → affichage en colonnes alignées
- `.quit`          → quitter

---

## La base de données : TechCorp

### Tables disponibles

#### `employes`
| Colonne        | Type    | Description                     |
|----------------|---------|---------------------------------|
| id             | INTEGER | Clé primaire                    |
| prenom         | TEXT    | Prénom                          |
| nom            | TEXT    | Nom de famille                  |
| email          | TEXT    | Email unique                    |
| salaire        | REAL    | Salaire annuel (peut être NULL) |
| poste          | TEXT    | Intitulé du poste               |
| departement_id | INTEGER | Clé étrangère → departements    |
| manager_id     | INTEGER | Auto-référence → employes       |
| date_embauche  | TEXT    | Format YYYY-MM-DD               |

#### `departements`
| Colonne | Type    | Description       |
|---------|---------|-------------------|
| id      | INTEGER | Clé primaire      |
| nom     | TEXT    | Nom du département|
| ville   | TEXT    | Ville du siège    |
| budget  | REAL    | Budget annuel     |

#### `projets`
| Colonne    | Type    | Description                              |
|------------|---------|------------------------------------------|
| id         | INTEGER | Clé primaire                             |
| nom        | TEXT    | Nom du projet                            |
| budget     | REAL    | Budget alloué                            |
| statut     | TEXT    | En cours / Terminé / Annulé / Planifié   |
| date_debut | TEXT    | Format YYYY-MM-DD                        |
| date_fin   | TEXT    | Peut être NULL (projet en cours)         |

#### `employes_projets` *(table d'association)*
| Colonne    | Type    | Description             |
|------------|---------|-------------------------|
| employe_id | INTEGER | Clé étrangère → employes|
| projet_id  | INTEGER | Clé étrangère → projets |
| role       | TEXT    | Rôle sur le projet      |
| heures     | INTEGER | Heures travaillées      |

#### `ventes`
| Colonne    | Type    | Description             |
|------------|---------|-------------------------|
| id         | INTEGER | Clé primaire            |
| employe_id | INTEGER | Clé étrangère → employes|
| produit    | TEXT    | Nom du produit vendu    |
| montant    | REAL    | Montant de la vente     |
| quantite   | INTEGER | Quantité vendue         |
| date_vente | TEXT    | Format YYYY-MM-DD       |
| region     | TEXT    | Région de vente         |

---

## Progression recommandée

| Fichier | Niveau | Concepts clés |
|---------|--------|---------------|
| 01 | Débutant | SELECT, ORDER BY, LIMIT, DISTINCT |
| 02 | Débutant | WHERE, IN, BETWEEN, LIKE, NULL |
| 03 | Intermédiaire | JOIN, self-join |
| 04 | Intermédiaire | GROUP BY, HAVING, fonctions d'agrégation |
| 05 | Avancé | Sous-requêtes, CTE (WITH) |
| 06 | Avancé | Window functions (ROW_NUMBER, RANK, LAG...) |

> **Conseil** : Essaie d'abord seul, puis compare avec les solutions dans `exercices/solutions/`.
> Les exercices marqués ★ sont typiques des questions d'entretien.
