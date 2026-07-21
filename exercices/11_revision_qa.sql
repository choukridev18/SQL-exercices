-- ============================================================
--  EXERCICES 11 — Révision QA (sans indices)
--  Niveau : bases uniquement
--
--  Lancer : ./run.sh exercices/11_revision_qa.sql
--  Schéma : voir schema.md
--
--  IMPORTANT pour les séparateurs :
--    .print AVANT la requête (pas après)
-- ============================================================


-- ============================================================
--  PARTIE 1 — Vérifier les données
-- ============================================================


-- Q1
-- Le PO dit : "Aucun employé ne doit être sans email."
-- Affiche prénom et nom des employés dont l'email est NULL.
-- ↓ Ta requête :

.print ''
.print '========== Q1 =========='

SELECT prenom|| ' ' ||nom AS employe FROM employes
WHERE email IS NULL;


-- Q2
-- Tu dois lister tous les projets dont la date de fin n'est pas renseignée.
-- Affiche nom et statut.
-- ↓ Ta requête :

.print ''
.print '========== Q2 =========='

SELECT nom, statut FROM projets
WHERE date_fin IS NULL;


-- Q3
-- Combien d'employés ont été embauchés en 2022 ?
-- ↓ Ta requête :

.print ''
.print '========== Q3 =========='

SELECT COUNT(*) AS nb_employes_2022 FROM employes
WHERE date_embauche LIKE '2022%';


-- ============================================================
--  PARTIE 2 — Pièges COUNT / SUM / WHERE / HAVING
-- ============================================================


-- Q4
-- Le client demande : "Combien d'unités de Formation SQL ont été vendues en 2024 ?"
-- ↓ Ta requête :

.print ''
.print '========== Q4 =========='

SELECT SUM(quantite) AS nb_formation_sql FROM ventes
WHERE produit = 'Formation SQL'
AND date_vente LIKE '2024%';


-- Q5
-- Combien de ventes ont été faites en avril 2024 ?
-- (utilise LIKE sur date_vente)
-- ↓ Ta requête :

.print ''
.print '========== Q5 =========='

SELECT COUNT(*) AS ns_ventes FROM ventes
WHERE strftime('%Y-%m',date_vente)= '2024-04';


-- Q6
-- Le manager veut les régions dont le montant total des ventes dépasse 50 000 €.
-- Affiche région et total, du plus grand au plus petit.
-- ↓ Ta requête :

.print ''
.print '========== Q6 =========='

SELECT region, SUM(montant) AS total FROM ventes
GROUP BY region
HAVING SUM(montant) > 50000
ORDER BY total DESC;


-- ============================================================
--  PARTIE 3 — Jointures et cas QA complets
-- ============================================================


-- Q7
-- Tu testes l'écran "Ventes du département Commercial".
-- Affiche prénom, nom du commercial et montant de chaque vente
-- — uniquement pour les employés du département Commercial.
-- ↓ Ta requête :

.print ''
.print '========== Q7 =========='

SELECT e.prenom, e.nom, v.montant
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
INNER JOIN departements d
ON e.departement_id = d.id
WHERE d.nom = 'Commercial';


-- Q8
-- Quels employés travaillent sur le projet "CRM Interne" ?
-- Affiche prénom, nom et rôle sur le projet.
-- ↓ Ta requête :

SELECT e.prenom, e.nom , ep.role 
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id
WHERE p.nom = 'CRM Interne';



.print ''
.print '========== Q8 =========='



-- Q9 ★
-- "Donne-moi les commerciaux qui ont fait au moins 3 ventes,
--  avec leur prénom, nom, nombre de ventes et total des montants
--  — mais seulement ceux dont le total dépasse 15 000 €."
-- ↓ Ta requête :

SELECT e.prenom, e.nom, COUNT(v.id) AS nb_ventes, SUM(v.montant) AS total
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
GROUP BY e.id, e.prenom,e.nom
HAVING COUNT(*) >= 3
AND SUM(v.montant) > 15000;



.print ''
.print '========== Q9 =========='



-- Q10 ★
-- Mini-rapport QA sur les ventes en région Paris :
--   nombre de ventes, montant total, montant moyen (arrondi).
-- Tout en une seule requête.
-- ↓ Ta requête :
SELECT COUNT(*) AS nb_ventes, SUM(montant), ROUND(AVG(montant)) AS montant_moyen
FROM ventes
WHERE region = 'Paris' ;




.print ''
.print '========== Q10 =========='

