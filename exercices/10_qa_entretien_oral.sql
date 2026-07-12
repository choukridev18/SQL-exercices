-- ============================================================
--  EXERCICES 10 — Mode entretien oral
--  Niveau : bases uniquement (comme le fichier 09)
--
--  Contexte : on te pose UNE question, tu écris UNE requête.
--  Pas d'indice. Lis bien l'énoncé avant de coder.
--
--  Lancer : ./run.sh exercices/10_qa_entretien_oral.sql
--  Schéma : voir schema.md
-- ============================================================
--
--  Règles du jeu :
--    - Une question = une requête (sauf si on dit explicitement deux)
--    - Raisonne à voix haute : quelle table ? quel filtre ? quel résultat ?
--    - Si l'énoncé est ambigu, note ce que tu demanderais en entretien
-- ============================================================


-- ============================================================
--  TOUR 1 — Questions directes (réponse rapide attendue)
-- ============================================================


-- Q1
-- L'interviewer te dit : "Montre-moi tous les employés qui n'ont pas de manager."
-- ↓ Ta requête :
SELECT prenom, nom FROM employes
WHERE manager_id IS NULL;


.print ''
.print '========== Q1 =========='


-- Q2
-- "Combien de projets ont le statut Terminé ?"
-- ↓ Ta requête :

SELECT COUNT(*) AS nb_statut_termine FROM projets
WHERE statut = 'Terminé';

.print ''
.print '========== Q2 =========='


-- Q3
-- "Affiche les employés embauchés en 2023. Je veux le prénom, le nom et la date."
-- ↓ Ta requête :

SELECT prenom, nom , date_embauche FROM employes
WHERE date_embauche LIKE '2023%';


.print ''
.print '========== Q3 =========='


-- Q4
-- "Liste tous les postes différents qui existent en base, sans doublon."
-- ↓ Ta requête :
SELECT DISTINCT poste FROM employes;


.print ''
.print '========== Q4 =========='


-- Q5
-- "Quel est le salaire le plus bas parmi les employés qui ont un salaire renseigné ?"
-- ↓ Ta requête :
SELECT prenom, nom , salaire FROM employes
WHERE salaire IS NOT NULL
ORDER BY salaire ASC
LIMIT 1;


.print ''
.print '========== Q5 =========='


-- ============================================================
--  TOUR 2 — Pièges classiques (lis bien ce qu'on te demande)
-- ============================================================




-- Q6
-- "Combien de ventes ont été réalisées au mois de mars 2024 ?"
-- ↓ Ta requête :

SELECT COUNT(*) AS nb_ventes FROM ventes
WHERE  strftime('%Y-%m',date_vente) = '2024-03';

.print ''
.print '========== Q6 =========='


-- Q7
-- "Combien d'unités de Licence Pro ont été vendues au total ?"
-- ↓ Ta requête :
SELECT SUM(quantite) AS total FROM ventes
WHERE produit = 'Licence Pro';

.print ''
.print '========== Q7 =========='


-- Q8
-- "Quels départements comptent strictement plus de 2 employés ?
--  Affiche le nom du département et le nombre d'employés."
-- ↓ Ta requête :

SELECT d.nom AS departement, COUNT(e.id) AS nb_employes
FROM departements d
INNER JOIN employes e
ON d.id = e.departement_id
GROUP BY d.id, d.nom
HAVING COUNT(e.id) > 2; 


.print ''
.print '========== Q8 =========='


-- Q9
-- "Quel commercial a réalisé le plus de ventes (en nombre de transactions) ?
--  Affiche prénom, nom et le nombre de ventes. Un seul résultat."
-- ↓ Ta requête :

SELECT e.prenom , e.nom, COUNT(*) AS nb_ventes 
FROM employes e 
INNER JOIN ventes v
ON e.id = v.employe_id 
GROUP BY e.id,e.prenom, e.nom
ORDER BY nb_ventes DESC
LIMIT 1;

.print ''
.print '========== Q9 =========='


-- ============================================================
--  TOUR 3 — Jointures (comme en entretien live)
-- ============================================================


-- Q10
-- "Affiche chaque vente de plus de 20 000 € avec le prénom et le nom du commercial."
-- ↓ Ta requête :
SELECT e.prenom , e.nom , v.montant
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
WHERE v.montant > 20000;

.print ''
.print '========== Q10 =========='


-- Q11
-- "Montre-moi les employés du département Finance avec le nom de leur département."
-- ↓ Ta requête :

SELECT e.prenom, e.nom , d.nom AS departement
FROM employes e 
INNER JOIN departements d
ON e.departement_id = d.id
WHERE d.nom = 'Finance';


.print ''
.print '========== Q11 =========='


-- Q12
-- "Quels employés ne sont rattachés à aucun département ?
--  Affiche prénom et nom."
-- ↓ Ta requête :
SELECT e.prenom, e.nom , d.nom AS departement
FROM employes e 
LEFT JOIN departements d
ON e.departement_id = d.id
WHERE d.nom IS NULL;





.print ''
.print '========== Q12 =========='


-- Q13
-- "Pour chaque région, quel est le montant total des ventes ?
--  Affiche région et total, du plus grand au plus petit."
-- ↓ Ta requête :

SELECT SUM(montant) as total, region FROM ventes
GROUP BY region
ORDER BY total DESC;

.print ''
.print '========== Q13 =========='


-- ============================================================
--  TOUR 4 — Questions de fin d'entretien (un peu plus réfléchies)
-- ============================================================


-- Q14
-- "Quels projets n'ont aucun employé assigné ?
--  Affiche le nom du projet et son statut."
-- ↓ Ta requête :

SELECT p.nom, p.statut
FROM projets p
LEFT JOIN employes_projets ep
ON p.id = ep.projet_id
WHERE ep.projet_id IS NULL;



.print ''
.print '========== Q14 =========='


-- Q15
-- "Le manager veut un résumé des ventes en région Sud :
--   nombre de ventes, montant total, montant moyen par vente.
--  Tout en une seule requête."
-- ↓ Ta requête :

SELECT COUNT(*) AS nb_ventes, SUM(montant) AS montant_total,
ROUND(AVG(montant),0) AS montant_moyen
FROM ventes
WHERE region = 'Sud';


.print ''
.print '========== Q15 =========='


-- Q16 ★
-- "On te demande de préparer un mini-rapport sur les commerciaux :
--   pour chaque commercial (prénom + nom), affiche le nombre de ventes
--   et le total des montants — mais uniquement pour ceux dont le total
--   dépasse 30 000 €."
-- ↓ Ta requête :
SELECT e.prenom|| ' ' ||e.nom AS employe,
COUNT(v.id) AS nb_ventes , SUM(v.montant) AS total 
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
GROUP BY e.id, e.prenom, e.nom
HAVING total > 30000;


.print ''
.print '========== Q16 =========='
