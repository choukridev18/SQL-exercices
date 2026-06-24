-- ============================================================
--  EXERCICES 02 — Filtrer avec WHERE
--  Notions : WHERE, =, >, <, >=, <=, <>, AND, OR,
--             IN, NOT IN, BETWEEN, LIKE, IS NULL, IS NOT NULL
-- ============================================================
-- ★ RAPPEL ORDRE DES CLAUSES
--   SELECT → FROM → WHERE → ORDER BY → LIMIT
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche les employés dont le salaire est supérieur à 70 000 €
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE salaire > 70000;


-- EX 2 -------------------------------------------------------
-- Affiche les employés du département 1
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE departement_id = 1;


-- EX 3 -------------------------------------------------------
-- Affiche les employés dont le salaire est entre 50 000 et 70 000 €
-- Utilise BETWEEN
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE salaire BETWEEN 50000 AND 70000;


-- EX 4 -------------------------------------------------------
-- Affiche les employés dont le prénom commence par la lettre 'C'
-- Utilise LIKE
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE prenom LIKE 'C%';


-- EX 5 -------------------------------------------------------
-- Affiche les employés des départements 1 et 2 uniquement
-- Utilise IN
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE departement_id IN(1,2);


-- EX 6 -------------------------------------------------------
-- Affiche les employés qui n'ont PAS de manager
-- (manager_id est NULL → ce sont les directeurs)
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE manager_id IS NULL;


-- EX 7 -------------------------------------------------------
-- Affiche les employés qui ONT un manager
-- ↓ Écris ta requête ici :

SELECT prenom, nom FROM employes
WHERE manager_id IS NOT NULL;


-- EX 8 -------------------------------------------------------
-- Affiche les projets dont le statut est 'En cours' ou 'Planifié'
-- Utilise IN
-- ↓ Écris ta requête ici :
SELECT nom FROM projets
WHERE statut IN('En cours','Planifié');



-- EX 9 -------------------------------------------------------
-- Affiche les employés embauchés après le 1er janvier 2021
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE  date_embauche > '2021-01-01';


-- EX 10 ------------------------------------------------------
-- Affiche les employés du département 1
-- dont le salaire est supérieur à 60 000 €
-- Utilise AND
-- ↓ Écris ta requête ici :

SELECT prenom, nom FROM employes
WHERE  departement_id = 1 AND salaire > 60000;

-- EX 11 ------------------------------------------------------
-- Affiche les employés dont le salaire est NULL
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE salaire IS NULL;


-- EX 12 ------------------------------------------------------
-- Affiche les employés des départements 1, 3 et 5
-- dont le salaire dépasse 55 000 €
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE departement_id IN(1,3,5)
AND salaire > 55000;