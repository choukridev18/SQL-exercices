-- ============================================================
--  EXERCICES 08 — SQL pour QA (Questions d'entretien)
--  Niveau : débutant à intermédiaire
--  Contexte : vérification de données, recherche d'anomalies,
--              validation de résultats
-- ============================================================
-- Ces exercices simulent ce qu'un QA fait réellement :
--   - Vérifier que les données sont cohérentes
--   - Trouver des anomalies ou données manquantes
--   - Compter et valider des résultats
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Compte le nombre total d'employés dans la base
-- (vérification basique de la volumétrie)
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_employes FROM employes;



-- EX 2 -------------------------------------------------------
-- Affiche tous les employés dont le salaire est NULL
-- (données manquantes — anomalie à signaler)
-- ↓ Écris ta requête ici :

SELECT prenom|| ' ' ||nom  AS employe FROM employes
WHERE salaire IS NULL;

-- EX 3 -------------------------------------------------------
-- Affiche tous les employés sans département assigné
-- (données incohérentes — anomalie à signaler)
-- ↓ Écris ta requête ici :

SELECT prenom, nom FROM employes
WHERE departement_id IS NULL;

-- EX 4 -------------------------------------------------------
-- Vérifie que tous les emails sont uniques
-- Compte le nombre d'emails distincts et compare avec le total d'employés
-- (deux requêtes séparées)
-- ↓ Écris ta requête ici :
SELECT COUNT(DISTINCT email) AS nb_emails, FROM employes;
SELECT COUNT(*) AS nb_employes FROM employes;


-- EX 5 -------------------------------------------------------
-- Affiche les projets dont le statut est 'Annulé'
-- (vérification d'un statut spécifique)
-- ↓ Écris ta requête ici :

SELECT nom FROM projets
WHERE statut = 'Annulé';

-- EX 6 -------------------------------------------------------
-- Affiche les employés embauchés en 2023
-- (utilise LIKE ou BETWEEN sur la date)
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE date_embauche LIKE '2023%';


-- EX 7 -------------------------------------------------------
-- Compte le nombre d'employés par département
-- (vérification de la répartition)
-- ↓ Écris ta requête ici :
SELECT COUNT(e.id) AS nb_employes, d.nom AS departement
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.id, d.nom;


-- EX 8 -------------------------------------------------------
-- Affiche les ventes du mois de janvier 2024
-- (vérification d'une période spécifique)
-- ↓ Écris ta requête ici :

SELECT produit , strftime('%Y-%m',date_vente) FROM ventes
WHERE strftime('%Y-%m', date_vente) = '2024-01';


-- EX 9 -------------------------------------------------------
-- Affiche le prénom, nom et département de chaque employé
-- (vérification des données avec JOIN)
-- ↓ Écris ta requête ici :

SELECT e.prenom || ' ' || e.nom  AS employe , d.nom AS departement
FROM departements d
INNER JOIN employes e
ON e.departement_id = d.id;

-- EX 10 ------------------------------------------------------
-- Affiche les employés dont le salaire est supérieur à 80 000 €
-- avec leur département
-- (vérification croisée salaire + département)
-- ↓ Écris ta requête ici :

SELECT e.prenom || ' ' || e.nom AS employes , e.salaire, d.nom AS departement
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
WHERE salaire > 80000;


-- EX 11 ------------------------------------------------------
-- Compte le nombre de ventes par région
-- (vérification de la couverture géographique)
-- ↓ Écris ta requête ici :

SELECT COUNT(produit) AS nb_ventes ,region
FROM ventes 
GROUP BY region;

-- EX 12 ------------------------------------------------------
-- Affiche les projets "En cours" avec leur budget
-- triés du plus cher au moins cher
-- (vérification des projets actifs)
-- ↓ Écris ta requête ici :

SELECT nom, statut, budget FROM projets
WHERE statut = 'En cours'
ORDER BY budget DESC ;


-- EX 13 ------------------------------------------------------
-- Affiche les employés qui sont managers
-- (ceux dont l'id apparaît dans la colonne manager_id d'autres employés)
-- Astuce : cherche les employés dont l'id est dans
--          (SELECT DISTINCT manager_id FROM employes WHERE manager_id IS NOT NULL)
-- ↓ Écris ta requête ici :
SELECT prenom || ' ' || nom AS manager FROM employes
WHERE  manager_id is NOT NULL;



-- EX 14 ------------------------------------------------------
-- Vérifie la cohérence des ventes :
-- affiche le montant total, le nombre de ventes
-- et le montant moyen par vente
-- (tout en une seule requête)
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_ventes , SUM(montant) AS total_ventes, ROUND(AVG(montant),0) AS montant_moyen
FROM ventes;


-- EX 15 ★ ----------------------------------------------------
-- Affiche les départements qui ont plus de 2 employés
-- avec le salaire moyen du département
-- (rapport de synthèse typique en QA)
-- ↓ Écris ta requête ici :

SELECT d.nom AS departement , ROUND(AVG(e.salaire),0) AS salaire_moyen
FROM departements d
INNER JOIN employes e
ON d.id = e.departement_id
GROUP BY d.id, d.nom
HAVING COUNT(e.nom) > 2;