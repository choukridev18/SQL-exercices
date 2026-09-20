-- ============================================================
--  SÉRIE 2 — EXERCICES 04 — GROUP BY (une seule table)
--  Notions : GROUP BY, COUNT, SUM, AVG, MIN, MAX, HAVING
--
--  ★ GROUP BY = "fais un paquet pour chaque valeur unique"
--  ★ HAVING   = filtre APRÈS le GROUP BY
-- ============================================================
-- Lancer : ./run.sh exercices-2/04_group_by_simple.sql
-- ============================================================

-- ★ RAPPEL ORDRE DES CLAUSES
--   SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT

-- ★ RÈGLE : toute colonne dans le SELECT qui n'est PAS
--   dans une fonction (COUNT, SUM...) DOIT être dans le GROUP BY


-- EX 1 -------------------------------------------------------
-- Compte le nombre d'employés PAR departement_id
-- Utilise la table : employes
-- ↓ Écris ta requête ici :
.print 'exo1'
SELECT departement_id ,COUNT(*) AS nb_employes FROM employes
GROUP BY departement_id;

-- EX 2 -------------------------------------------------------
-- Même chose, trié du département avec le plus d'employés au moins
-- ↓ Écris ta requête ici :
.print 'exo2'
SELECT departement_id ,COUNT(*) AS nb_employes FROM employes
GROUP BY departement_id 
ORDER BY nb_employes DESC;


-- EX 3 -------------------------------------------------------
-- Affiche le salaire moyen PAR departement_id (arrondi à 0)
-- trié du plus élevé au plus bas
-- ↓ Écris ta requête ici :
SELECT ROUND(AVG(salaire),0) AS salaire_moyen ,departement_id FROM employes
GROUP BY departement_id
ORDER BY salaire_moyen DESC;


-- EX 4 -------------------------------------------------------
-- Affiche le nombre de ventes PAR région
-- Utilise la table : ventes
-- ↓ Écris ta requête ici :
SELECT COUNT(produit) AS nb_ventes , region FROM ventes
GROUP BY region;


-- EX 5 -------------------------------------------------------
-- Affiche la quantité totale vendue PAR produit
-- trié de la plus grande quantité à la plus petite
-- ↓ Écris ta requête ici :
SELECT SUM(quantite) AS quantite_totale, produit from ventes
GROUP BY produit
ORDER BY quantite_totale DESC;


-- EX 6 -------------------------------------------------------
-- Affiche le montant total ET le montant moyen PAR produit
-- ↓ Écris ta requête ici :
.print "-------"
SELECT produit , SUM(montant) AS montant_total , AVG(montant) AS montant_moyen
FROM ventes
GROUP BY produit;


-- EX 7 -------------------------------------------------------
-- Affiche les postes occupés par PLUS D'UN employé
-- Utilise HAVING
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_employes, poste FROM employes
GROUP BY poste
HAVING COUNT(*) >1; 


-- EX 8 -------------------------------------------------------
-- Affiche les produits dont le total des ventes dépasse 20 000 €
-- Utilise HAVING
-- ↓ Écris ta requête ici :
SELECT produit , SUM(montant) AS total_ventes FROM ventes
GROUP BY produit
HAVING SUM(montant) >20000;


-- EX 9 -------------------------------------------------------
-- Affiche le montant total des ventes PAR mois en 2024
-- (utilise : strftime('%Y-%m', date_vente))
-- ↓ Écris ta requête ici :
SELECT SUM(montant) AS total_ventes, strftime('%Y-%m',date_vente) AS mois 
FROM ventes
WHERE strftime('%Y',date_vente) = '2024'
GROUP BY mois;



-- EX 10 ★ ----------------------------------------------------
-- Affiche les régions dont le montant moyen par vente
-- dépasse 15 000 €
-- ↓ Écris ta requête ici :

SELECT region , AVG(montant) AS montant_moyen from ventes
GROUP BY region
HAVING montant_moyen > 15000;


-- EX 11 ------------------------------------------------------
-- Affiche le nombre de projets PAR statut
-- mais UNIQUEMENT pour les projets dont le budget > 50 000
-- (WHERE avant le GROUP BY)
-- ↓ Écris ta requête ici :
SELECT statut,  COUNT(*) as nb_projets FROM projets
WHERE budget > 50000
GROUP BY statut;

