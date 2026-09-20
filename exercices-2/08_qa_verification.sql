-- ============================================================
--  SÉRIE 2 — EXERCICES 08 — SQL pour QA (vérification)
--  Niveau : débutant à intermédiaire
--  Contexte : volumétrie, anomalies, cohérence des données
-- ============================================================
-- Lancer : ./run.sh exercices-2/08_qa_verification.sql
--
-- IMPORTANT : .print AVANT chaque requête
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Le PO dit qu'il doit y avoir 8 projets en base.
-- Compte-les pour vérifier.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 1 =========='

SELECT count(nom) AS nb_projets FROM projets;



-- EX 2 -------------------------------------------------------
-- Anomalie : certains employés n'ont pas de salaire.
-- Liste prénom, nom et poste de ces employés.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 2 =========='

SELECT prenom , nom , poste FROM employes
WHERE salaire is NULL;


-- EX 3 -------------------------------------------------------
-- Anomalie : certains employés n'ont pas de département.
-- Liste-les (prénom + nom).
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 3 =========='

SELECT prenom , nom , departement_id AS departement FROM employes
WHERE departement_id is NULL;



-- EX 4 -------------------------------------------------------
-- Vérifie qu'il n'y a pas de doublon d'email :
-- affiche COUNT(*) et COUNT(DISTINCT email) dans UNE requête.
-- Si les 2 chiffres sont égaux → pas de doublon.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 4 =========='

SELECT COUNT(*) AS nb_employe , COUNT(DISTINCT email) AS nb_email
FROM employes;

-- EX 5 -------------------------------------------------------
-- Liste les projets "Planifié" avec leur date de début
-- (vérification d'un statut métier).
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 5 =========='

SELECT nom , date_debut ,statut FROM projets
WHERE statut LIKE "%Planifié%";


-- EX 6 -------------------------------------------------------
-- Combien d'employés ont été embauchés en 2021 ?
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 6 =========='

SELECT COUNT(*) AS nb_employes FROM employes
WHERE strftime('%Y',date_embauche)  = '2021';

-- EX 7 -------------------------------------------------------
-- Répartition : compte le nombre d'employés par ville
-- (nom de la ville + nombre).
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 7 =========='

SELECT  d.ville , COUNT(e.id) AS nb_employes 
FROM employes e 
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.ville;

-- EX 8 -------------------------------------------------------
-- Vérifie les ventes du 1er trimestre 2024 (janvier à mars).
-- Affiche produit, montant, date_vente.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 8 =========='

SELECT produit , montant , date_vente FROM ventes
where strftime('%Y-%m',date_vente) IN ('2024-01', '2024-02', '2024-03') ;



-- EX 9 -------------------------------------------------------
-- Affiche les employés dont le salaire dépasse 75 000 €
-- avec le nom de leur département.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 9 =========='

SELECT e.prenom, e.nom , d.nom AS departement , e.salaire 
from employes e
INNER JOIN departements d
ON e.departement_id = d.id
WHERE salaire > 75000;


-- EX 10 ------------------------------------------------------
-- Couverture : pour chaque produit, nombre de ventes
-- et montant total, trié par montant décroissant.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 10 =========='

SELECT produit, COUNT(date_vente) AS nb_ventes,
SUM(montant) AS montant_total FROM ventes
GROUP BY produit
ORDER BY montant_total DESC;


-- EX 11 ------------------------------------------------------
-- Quels projets "En cours" n'ont toujours pas de date_fin ?
-- Affiche nom et budget.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 11 =========='

SELECT nom , budget FROM projets
WHERE statut LIKE '%En cours%'
AND date_fin IS NULL;

-- EX 12 ------------------------------------------------------
-- Mini-rapport QA sur les projets :
--   nombre total, budget total, budget moyen (arrondi).
-- Une seule requête.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 12 =========='

SELECT COUNT(*) AS nb_total, SUM(budget) AS budget_total,
ROUND(AVG(budget),0) AS budget_moyen FROM projets;


-- EX 13 ★ ----------------------------------------------------
-- Trouve les employés qui sont managers
-- (leur id apparaît dans manager_id d'au moins un autre employé).
-- Affiche prénom et nom.
-- Astuce : id IN (SELECT DISTINCT manager_id FROM employes
--                  WHERE manager_id IS NOT NULL)
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 13 =========='
SELECT prenom, nom FROM employes
WHERE id IN(
SELECT DISTINCT manager_id FROM employes
WHERE manager_id is NOT NULL);


-- EX 14 ★ ----------------------------------------------------
-- Départements avec plus de 2 employés :
-- affiche le nom, le nombre d'employés et le salaire moyen.
-- ↓ Écris ta requête ici :

.print ''
.print '========== EX 14 =========='

SELECT d.nom, COUNT(e.id) AS nb_employe, AVG(e.salaire) AS salaire_moyen
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.nom
HAVING nb_employe > 2;