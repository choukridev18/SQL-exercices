-- ============================================================
--  EXERCICES 12 — Mix entretien QA (sans indices)
--  Niveau : bases uniquement
--
--  Lancer : ./run.sh exercices/12_qa_mix_entretien.sql
--  Schéma : voir schema.md
--
--  IMPORTANT : .print AVANT chaque requête (pas après)
-- ============================================================


-- ============================================================
--  PARTIE 1 — Filtrer et trier
-- ============================================================


-- Q1
-- Le PO veut voir les 3 projets avec le budget le plus élevé.
-- Affiche nom et budget.
-- ↓ Ta requête :

.print ''
.print '========== Q1 =========='

SELECT nom, budget AS budjet_plus_eleve FROM projets
ORDER BY budget DESC
LIMIT 3;



-- Q2
-- Liste tous les employés dont le salaire dépasse 80 000 €.
-- Affiche prénom, nom et salaire, du plus grand au plus petit.
-- ↓ Ta requête :

.print ''
.print '========== Q2 =========='

SELECT prenom, nom, salaire FROM employes
WHERE salaire > 80000
ORDER BY salaire DESC;



-- Q3
-- Combien de ventes concernent le produit "Licence Pro" ?
-- (pas les unités — les transactions)
-- ↓ Ta requête :

.print ''
.print '========== Q3 =========='

SELECT COUNT(*) AS nb_ventes FROM ventes
WHERE produit = 'Licence Pro';



-- ============================================================
--  PARTIE 2 — Agrégations
-- ============================================================


-- Q4
-- Quel est le budget total de tous les départements réunis ?
-- ↓ Ta requête :

.print ''
.print '========== Q4 =========='

SELECT SUM(budget) AS budget_total FROM departements;



-- Q5
-- Pour chaque statut de projet, combien de projets existent ?
-- Affiche statut et nombre, par ordre décroissant.
-- ↓ Ta requête :

.print ''
.print '========== Q5 =========='

SELECT statut, COUNT(nom) AS nb_projets FROM projets
GROUP BY statut
ORDER BY nb_projets DESC;



-- Q6
-- Quelle région n'a eu qu'une seule vente ?
-- Affiche région et nombre de ventes.
-- ↓ Ta requête :

.print ''
.print '========== Q6 =========='

SELECT region, COUNT(*) AS nb_ventes FROM ventes
GROUP BY region
HAVING COUNT(*) = 1;



-- ============================================================
--  PARTIE 3 — Jointures
-- ============================================================


-- Q7
-- Affiche toutes les ventes faites par Paul Bonnet
-- (prénom, nom, montant, date de vente).
-- ↓ Ta requête :

.print ''
.print '========== Q7 =========='

SELECT e.prenom, e.nom, v.montant, v.date_vente
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
WHERE e.prenom = 'Paul' AND e.nom = 'Bonnet';

.print '========================'



-- Q8
-- Quels employés ne sont assignés à aucun projet ?
-- Affiche prénom et nom.
-- ↓ Ta requête :

SELECT e.prenom, e.nom 
FROM employes e
LEFT JOIN employes_projets ep 
ON e.id = ep.employe_id
WHERE ep.employe_id IS NULL;


.print ''
.print '========== Q8 =========='



-- Q9
-- Quel département compte le plus d'employés ?
-- Affiche nom du département et nombre. Un seul résultat.
-- ↓ Ta requête :

SELECT d.nom, COUNT(e.id) AS nombre_employes 
FROM departements d
INNER JOIN employes e
ON e.departement_id = d.id
GROUP BY d.id, d.nom
ORDER BY  COUNT(e.id) DESC  
LIMIT 1;

.print ''
.print '========== Q9 =========='



-- Q10 ★
-- Rapport QA sur le département Informatique :
--   nombre d'employés, salaire moyen (arrondi), salaire maximum.
-- Tout en une seule requête.
-- ↓ Ta requête :

SELECT COUNT(*) AS nb_employes, ROUND(AVG(salaire),0) AS salaire_moyen,
MAX(salaire) AS salaire_maximun FROM employes
WHERE departement_id = 1;


.print ''
.print '========== Q10 =========='

