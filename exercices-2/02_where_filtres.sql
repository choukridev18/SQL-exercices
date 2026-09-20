-- ============================================================
--  SÉRIE 2 — EXERCICES 02 — Filtrer avec WHERE
--  Notions : WHERE, =, >, <, >=, <=, <>, AND, OR,
--             IN, NOT IN, BETWEEN, LIKE, IS NULL, IS NOT NULL
-- ============================================================
-- Lancer : ./run.sh exercices-2/02_where_filtres.sql
-- ★ RAPPEL ORDRE DES CLAUSES
--   SELECT → FROM → WHERE → ORDER BY → LIMIT
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche les employés dont le salaire est inférieur à 60 000 €
-- (prénom, nom, salaire)
-- ↓ Écris ta requête ici :
.print 'exo1'
SELECT prenom , nom , salaire FROM employes
WHERE salaire < 60000;



-- EX 2 -------------------------------------------------------
-- Affiche les employés du département 5 (Commercial)
-- ↓ Écris ta requête ici :
.print 'exo2'
SELECT nom FROM employes
WHERE departement_id = 5;



-- EX 3 -------------------------------------------------------
-- Affiche les employés dont le salaire est entre 60 000 et 90 000 €
-- Utilise BETWEEN
-- ↓ Écris ta requête ici :
.print 'exo3'
SELECT nom FROM employes
WHERE salaire BETWEEN 60000 and 90000;


-- EX 4 -------------------------------------------------------
-- Affiche les employés dont le nom de famille commence par 'B'
-- Utilise LIKE
-- ↓ Écris ta requête ici :

.print 'exo4'
SELECT nom FROM employes
WHERE nom LIKE 'B%';

-- EX 5 -------------------------------------------------------
-- Affiche les employés des départements 3, 4 et 5 uniquement
-- Utilise IN
-- ↓ Écris ta requête ici :
.print 'exo5'
SELECT nom from employes
WHERE departement_id IN(3,4,5);


-- EX 6 -------------------------------------------------------
-- Affiche les projets qui n'ont PAS de date de fin
-- (date_fin est NULL)
-- ↓ Écris ta requête ici :
.print 'exo6'
SELECT nom from projets
WHERE date_fin IS NULL;

-- EX 7 -------------------------------------------------------
-- Affiche les projets qui ONT une date de fin renseignée
-- ↓ Écris ta requête ici :
.print 'exo7'
SELECT nom , date_fin FROM projets
WHERE date_fin is NOT NULL;





-- EX 8 -------------------------------------------------------
-- Affiche les projets dont le statut est 'Terminé' ou 'Annulé'
-- Utilise IN
-- ↓ Écris ta requête ici :
.print 'exo8'
SELECT nom, statut from projets
WHERE statut IN('Terminé','Annulé');


-- EX 9 -------------------------------------------------------
-- Affiche les employés embauchés avant le 1er janvier 2020
-- (prénom, nom, date_embauche)
-- ↓ Écris ta requête ici :
.print 'exo9'
SELECT prenom, nom, date_embauche FROM employes
WHERE date_embauche < '2020-01-01';

-- EX 10 ------------------------------------------------------
-- Affiche les employés du département 2
-- dont le salaire est inférieur à 70 000 €
-- Utilise AND
-- ↓ Écris ta requête ici :
.print 'exo10'

SELECT prenom , nom , salaire FROM employes
WHERE  departement_id = 2
AND salaire< 70000;


-- EX 11 ------------------------------------------------------
-- Affiche les ventes réalisées en région 'Sud' ou 'Paris'
-- dont le montant dépasse 8 000 €
-- ↓ Écris ta requête ici :
.print 'exo11'
SELECT produit , montant FROM ventes
WHERE region IN('Sud','Paris')
AND montant > 8000;


-- EX 12 ------------------------------------------------------
-- Affiche les employés dont le poste contient le mot 'Senior'
-- Utilise LIKE
-- ↓ Écris ta requête ici :
.print 'exo12'
SELECT prenom, nom , poste FROM employes
WHERE poste LIKE '%Senior%';


-- EX 13 ------------------------------------------------------
-- Affiche les employés qui ne sont NI du département 1 NI du 2
-- Utilise NOT IN
-- ↓ Écris ta requête ici :

.print 'exo13'
SELECT prenom , nom , departement_id as departement from employes
WHERE departement_id NOT IN(1,2);