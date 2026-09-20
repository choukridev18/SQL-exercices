-- ============================================================
--  SÉRIE 2 — EXERCICES 03 — Fonctions d'agrégation (sans GROUP BY)
--  Notions : COUNT, SUM, AVG, MIN, MAX, ROUND
--
--  ★ Ces fonctions calculent UN résultat sur TOUTE la table
-- ============================================================
-- Lancer : ./run.sh exercices-2/03_agregation_simple.sql
-- ============================================================

-- ★ LES 5 FONCTIONS À CONNAÎTRE
--   COUNT(*)         → compte le nombre de lignes
--   COUNT(colonne)   → compte les valeurs non NULL
--   SUM(colonne)     → additionne
--   AVG(colonne)     → calcule la moyenne
--   MIN / MAX        → extrêmes
--   ROUND(nombre, n) → arrondit à n décimales


-- EX 1 -------------------------------------------------------
-- Compte le nombre total de départements
-- ↓ Écris ta requête ici :
.print 'exo 1'
SELECT COUNT(*) AS nbr_departement FROM departements;


-- EX 2 -------------------------------------------------------
-- Compte le nombre de projets qui ont une date de fin renseignée
-- (utilise COUNT sur la colonne date_fin, pas sur *)
-- ↓ Écris ta requête ici :
.print 'exo 2'
SELECT COUNT(date_fin) AS nbr_projets FROM projets;

-- EX 3 -------------------------------------------------------
-- Calcule le budget moyen de tous les départements
-- ↓ Écris ta requête ici :
.print 'exo 3'
SELECT AVG(budget) AS budget_moyen FROM departements;



-- EX 4 -------------------------------------------------------
-- Calcule le budget moyen des projets, arrondi à 0 décimale
-- Utilise ROUND(..., 0)
-- ↓ Écris ta requête ici :
.print 'exo 4'
SELECT ROUND(AVG(budget),0) AS budget_moyen FROM projets;




-- EX 5 -------------------------------------------------------
-- Affiche le plus petit budget et le plus gros budget de projet
-- (les deux dans la même requête)
-- ↓ Écris ta requête ici :
.print 'exo 5'
SELECT MIN(budget), MAX(budget) FROM projets;


-- EX 6 -------------------------------------------------------
-- Calcule le budget total de tous les départements réunis
-- ↓ Écris ta requête ici :
.print 'exo 6'
SELECT SUM(budget) FROM departements;


-- EX 7 -------------------------------------------------------
-- Affiche en une seule requête sur la table ventes :
--   - le nombre de ventes
--   - le montant total
--   - le montant moyen (arrondi)
--   - le montant minimum
--   - le montant maximum
-- ↓ Écris ta requête ici :
.print 'exo 6'
SELECT COUNT(produit) AS nbr_ventes,
SUM(montant) AS montant_total_ventes,
ROUND(AVG(montant)) AS montant_moyen,
MIN(montant) AS montant_minimum,
MAX(montant) AS montant_maximum
FROM ventes;


-- EX 8 -------------------------------------------------------
-- Calcule le nombre total d'heures travaillées sur tous les projets
-- (table employes_projets, colonne heures)
-- ↓ Écris ta requête ici :
.print 'exo 6'
SELECT SUM(heures) AS total_heures_travaille FROM employes_projets;


-- EX 9 -------------------------------------------------------
-- Calcule la quantité totale d'articles vendus (SUM de quantite)
-- ↓ Écris ta requête ici :
.print 'exo 7'
SELECT SUM(quantite) AS total_article_vendu FROM ventes;


-- EX 10 ------------------------------------------------------
-- Combien d'employés ont un département renseigné ?
-- (COUNT sur departement_id)
-- ↓ Écris ta requête ici :
SELECT COUNT(departement_id) AS dep_employés FROM employes;
