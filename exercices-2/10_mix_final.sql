-- ============================================================
--  SÉRIE 2 — EXERCICES 10 — Mix final (sans indices)
--  Niveau : bases, comme à l'oral
--
--  Une question = une requête. Lis bien l'énoncé.
-- ============================================================
-- Lancer : ./run.sh exercices-2/10_mix_final.sql
-- Schéma : voir schema.md
--
-- IMPORTANT : .print AVANT chaque requête
-- ============================================================


-- ============================================================
--  TOUR 1 — Questions directes
-- ============================================================


-- Q1
-- "Montre-moi tous les employés dont le poste contient 'Directeur'
--  ou 'Directrice'."
-- ↓ Ta requête :

.print ''
.print '========== Q1 =========='
SELECT prenom , nom FROM employes
WHERE poste LIKE '%Direct%';


-- Q2
-- "Combien de projets ont un budget supérieur ou égal à 200 000 € ?"
-- ↓ Ta requête :

.print ''
.print '========== Q2 =========='
SELECT COUNT(*) AS nb_projets FROM projets
WHERE budget >= 200000;


-- Q3
-- "Liste les régions de vente, sans doublon, par ordre alphabétique."
-- ↓ Ta requête :

.print ''
.print '========== Q3 =========='
SELECT DISTINCT region FROM ventes
ORDER BY region ASC;


-- Q4
-- "Quel est le salaire le plus élevé parmi les employés
--  embauchés après 2019 ?"
-- ↓ Ta requête :

.print ''
.print '========== Q4 =========='
SELECT salaire FROM employes
WHERE strftime('%Y',date_embauche) > '2019'
ORDER BY salaire DESC
LIMIT 1;

-- ============================================================
--  TOUR 2 — Pièges COUNT / SUM / WHERE / HAVING
-- ============================================================


-- Q5
-- "Combien de ventes ont été réalisées en février 2024 ?"
-- ↓ Ta requête :

.print ''
.print '========== Q5 =========='
SELECT COUNT(*) AS nb_ventes_réalisées FROM ventes
WHERE date_vente LIKE '%2024-02%';


-- Q6
-- "Combien d'unités de Licence Basic ont été vendues au total ?"
-- ↓ Ta requête :

.print ''
.print '========== Q6 =========='
SELECT SUM(quantite) AS total_vente, produit FROM ventes
WHERE produit = 'Licence Basic';


-- Q7
-- "Quels produits ont été vendus dans au moins 2 régions différentes ?
--  Affiche le produit et le nombre de régions."
-- Indice : COUNT(DISTINCT region)
-- ↓ Ta requête :

.print ''
.print '========== Q7 =========='
SELECT produit, count(DISTINCT region) AS nb_regions FROM ventes
GROUP BY produit
HAVING count(DISTINCT region) >= 2;


-- Q8
-- "Quelles régions ont un montant total de ventes inférieur à 30 000 € ?
--  Affiche région et total."
-- ↓ Ta requête :

.print ''
.print '========== Q8 =========='
SELECT region , SUM(montant) AS total_ventes FROM ventes
GROUP BY region
HAVING total_ventes < 30000;


-- ============================================================
--  TOUR 3 — Jointures
-- ============================================================


-- Q9
-- "Affiche chaque vente de Formation SQL avec le prénom
--  et le nom du commercial."
-- ↓ Ta requête :

.print ''
.print '========== Q9 =========='
SELECT e.prenom , e.nom, v.produit
FROM employes e 
INNER JOIN ventes v
ON e.id = v.employe_id
WHERE v.produit ='Formation SQL';



-- Q10
-- "Montre-moi les employés du département Ressources Humaines
--  avec le nom de leur département."
-- ↓ Ta requête :

.print ''
.print '========== Q10 =========='
SELECT e.prenom , e.nom, d.nom
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
WHERE d.nom = 'Ressources Humaines';



-- Q11
-- "Quels employés n'ont aucun manager ?
--  Affiche prénom, nom et poste."
-- ↓ Ta requête :

.print ''
.print '========== Q11 =========='

SELECT prenom , nom , poste 
FROM employes 
WHERE manager_id IS NULL;


-- Q12
-- "Quels projets n'ont aucun employé assigné ?
--  Affiche nom, statut et budget."
-- ↓ Ta requête :

.print ''
.print '========== Q12 =========='

SELECT p.nom, p.statut , p.budget 
FROM projets p
LEFT JOIN employes_projets ep
ON p.id = ep.projet_id
WHERE ep.projet_id IS NULL;

-- Q13
-- "Pour chaque projet 'En cours', combien d'employés y travaillent ?
--  Affiche le nom du projet et le nombre."
-- ↓ Ta requête :

.print ''
.print '========== Q13 =========='

SELECT p.nom , count(ep.employe_id) AS nb_employe
FROM projets p 
INNER JOIN employes_projets ep
ON p.id = ep.projet_id
WHERE p.statut = 'En cours'
GROUP BY p.id , p.nom;

-- ============================================================
--  TOUR 4 — Fin d'entretien
-- ============================================================


-- Q14
-- "Le manager veut un résumé des ventes en région Est :
--   nombre de ventes, montant total, montant moyen arrondi.
--  Tout en une seule requête."
-- ↓ Ta requête :

.print ''
.print '========== Q14 =========='

SELECT COUNT(*) AS nb_ventes_region_Est, SUM(montant) AS total,
ROUND(AVG(montant),0) AS montant_moyen FROM ventes
WHERE region = 'Est';


-- Q15
-- "Quel commercial a le plus gros chiffre d'affaires ?
--  Affiche prénom, nom et total. Un seul résultat."
-- ↓ Ta requête :

.print ''
.print '========== Q15 =========='

SELECT e.prenom , e.nom, SUM(v.montant) AS total 
FROM ventes v 
INNER JOIN employes e
ON v.employe_id = e.id
GROUP BY e.id, e.prenom, e.nom
ORDER BY total DESC
LIMIT 1;



-- Q16 ★
-- "Pour chaque commercial, affiche prénom, nom, nombre de ventes
--  et total des montants — uniquement ceux dont le nombre de ventes
--  est d'au moins 2 ET le total dépasse 20 000 €."
-- ↓ Ta requête :

.print ''
.print '========== Q16 =========='
SELECT e.prenom , e.nom , COUNT(v.id) AS nb_ventes,
SUM(v.montant) AS total FROM employes e 
INNER JOIN ventes v
ON v.employe_id = e.id
GROUP BY e.prenom , e.nom
HAVING nb_ventes >= 2 
AND total > 20000;


-- Q17 ★
-- "Donne-moi les employés qui participent à au moins 2 projets,
--  avec leur prénom, nom et le nombre de projets."
-- ↓ Ta requête :

.print ''
.print '========== Q17 =========='

SELECT e.prenom , e.nom , COUNT(p.nom) AS nb_projets
FROM employes e
INNER JOIN employes_projets ep
ON ep.employe_id = e.id
INNER JOIN projets p
ON ep.projet_id = p.id 
GROUP BY e.id, e.prenom ,e.nom
HAVING nb_projets >= 2;