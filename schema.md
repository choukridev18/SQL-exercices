# Schéma des tables — TechCorp

```
┌─────────────────────────────┐
│          employes           │
├─────────────────────────────┤
│ id              INTEGER  PK │
│ prenom          TEXT        │
│ nom             TEXT        │
│ email           TEXT        │
│ salaire         REAL        │
│ poste           TEXT        │
│ departement_id  INTEGER  FK ├─────────────────────────┐
│ manager_id      INTEGER  FK ├──┐                      │
│ date_embauche   TEXT        │  │ (self-join)          │
└─────────────────────────────┘  │                      │
           ▲                     │                      │
           └─────────────────────┘                      │
                                                        │
┌─────────────────────────────┐                         │
│        departements         │◄────────────────────────┘
├─────────────────────────────┤
│ id              INTEGER  PK │
│ nom             TEXT        │
│ ville           TEXT        │
│ budget          REAL        │
└─────────────────────────────┘

┌─────────────────────────────┐       ┌──────────────────────────┐
│      employes_projets       │       │         projets          │
├─────────────────────────────┤       ├──────────────────────────┤
│ employe_id  INTEGER  FK     ├──┐    │ id         INTEGER  PK   │
│ projet_id   INTEGER  FK     ├──┼───►│ nom        TEXT          │
│ role        TEXT            │  │    │ budget     REAL          │
│ heures      INTEGER         │  │    │ statut     TEXT          │
└─────────────────────────────┘  │    │ date_debut TEXT          │
           │                     │    │ date_fin   TEXT          │
           │                     │    └──────────────────────────┘
           ▼                     │
┌─────────────────────────────┐  │
│          employes           │◄─┘
└─────────────────────────────┘

┌─────────────────────────────┐
│          ventes             │
├─────────────────────────────┤
│ id          INTEGER  PK     │
│ employe_id  INTEGER  FK     ├────► employes
│ produit     TEXT            │
│ montant     REAL            │
│ quantite    INTEGER         │
│ date_vente  TEXT            │
│ region      TEXT            │
└─────────────────────────────┘
```

## Légende
- `PK` = clé primaire (identifiant unique de chaque ligne)
- `FK` = clé étrangère (lien vers une autre table)
- `►` = sens de la relation

## Relations
| Colonne FK | Table source | Lien vers |
|---|---|---|
| `employes.departement_id` | employes | departements.id |
| `employes.manager_id` | employes | employes.id (self-join) |
| `employes_projets.employe_id` | employes_projets | employes.id |
| `employes_projets.projet_id` | employes_projets | projets.id |
| `ventes.employe_id` | ventes | employes.id |

## Rappel jointures
```sql
-- employes ↔ departements
ON e.departement_id = d.id

-- employes ↔ manager (self-join)
ON e.manager_id = m.id

-- employes ↔ projets (via employes_projets)
ON e.id = ep.employe_id
JOIN projets p ON ep.projet_id = p.id

-- employes ↔ ventes
ON e.id = v.employe_id
```
