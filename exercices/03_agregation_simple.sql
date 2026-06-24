-- ============================================================
--  EXERCICES 03 — Fonctions d'agrégation (sans GROUP BY)
--  Notions : COUNT, SUM, AVG, MIN, MAX, ROUND
--
--  ★ Ces fonctions calculent UN résultat sur TOUTE la table
--  ★ On verra GROUP BY dans le fichier 04
-- ============================================================


-- ★ LES 5 FONCTIONS À CONNAÎTRE
--   COUNT(*)         → compte le nombre de lignes
--   COUNT(colonne)   → compte les valeurs non NULL
--   SUM(colonne)     → additionne
--   AVG(colonne)     → calcule la moyenne
--   MIN(colonne)     → trouve le minimum
--   MAX(colonne)     → trouve le maximum
--   ROUND(nombre, n) → arrondit à n décimales


-- EX 1 -------------------------------------------------------
-- Compte le nombre total d'employés dans l'entreprise
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nombre_total FROM employes;



-- EX 2 -------------------------------------------------------
-- Compte le nombre d'employés qui ont un salaire renseigné
-- (utilise COUNT sur la colonne salaire, pas sur *)
-- ↓ Écris ta requête ici :
SELECT COUNT(salaire) AS nombre_total_avec_salaire_renseigné FROM employes;


-- EX 3 -------------------------------------------------------
-- Calcule le salaire moyen de tous les employés
-- ↓ Écris ta requête ici :
SELECT AVG(salaire) AS salaire_moyen FROM employes;




-- EX 4 -------------------------------------------------------
-- Calcule le salaire moyen arrondi à 0 décimale
-- Utilise ROUND(..., 0)
-- ↓ Écris ta requête ici :
SELECT ROUND(AVG(salaire)) AS salaire_moyen_arrondi FROM employes;



-- EX 5 -------------------------------------------------------
-- Affiche le salaire le plus bas et le salaire le plus élevé
-- (les deux dans la même requête, sur une seule ligne)
-- ↓ Écris ta requête ici :


SELECT MIN(salaire) AS salaire_min, MAX(salaire) AS salaire_max
FROM employes;

-- EX 6 -------------------------------------------------------
-- Calcule la masse salariale totale de l'entreprise
-- (la somme de tous les salaires)
-- ↓ Écris ta requête ici :

SELECT SUM(salaire) AS somme_total FROM employes;



-- EX 7 -------------------------------------------------------
-- Affiche en une seule requête :
--   - le nombre d'employés
--   - le salaire moyen (arrondi)
--   - le salaire minimum
--   - le salaire maximum
--   - la masse salariale totale
-- ↓ Écris ta requête ici :

SELECT count(*) AS nombre_employés,
ROUND(AVG(salaire)) AS salaire_moyen_arrondi,
MIN(salaire) AS salaire_min,
MAX(salaire) AS salaire_max,
SUM(salaire) AS masse_salariale
FROM employes;

-- EX 8 -------------------------------------------------------
-- Compte le nombre total de projets
-- ↓ Écris ta requête ici :

SELECT COUNT(*) AS nombre_total_projets FROM projets;

-- EX 9 -------------------------------------------------------
-- Calcule le budget moyen des projets (arrondi à 0 décimale)
-- ↓ Écris ta requête ici :
SELECT ROUND(AVG(budget)) AS budget_moyen_projets FROM projets;


-- EX 10 ------------------------------------------------------
-- Calcule la somme totale de toutes les ventes
-- ↓ Écris ta requête ici :
SELECT SUM(montant) AS somme_total_des_ventes FROM ventes;