-- ============================================================
--  EXERCICES 09 — SQL QA Entretien (scénarios réalistes)
--  Niveau : bases uniquement — ce qu'on te demande vraiment en QA
--
--  Contexte : tu es QA, on te donne une base de données
--  et tu dois vérifier si les données sont correctes.
--
--  Lancer : ./run.sh exercices/09_qa_entretien_bases.sql
--  Schéma : voir schema.md
-- ============================================================
--
--  CE FICHIER COUVRE (sans concepts avancés) :
--    SELECT, WHERE, NULL, IN, LIKE, BETWEEN
--    ORDER BY, LIMIT, DISTINCT
--    COUNT, SUM, AVG
--    GROUP BY simple
--    INNER JOIN (2 tables max)
--
--  PAS DE : sous-requêtes, CTE, window functions, HAVING complexe
-- ============================================================


-- ============================================================
--  PARTIE 1 — Vérifier que les données existent
--  (le QA le plus basique : "est-ce qu'il y a des données ?")
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Scénario : le PO dit qu'il doit y avoir des employés en base.
-- Vérifie combien il y en a au total.
-- ↓ Écris ta requête ici :

SELECT COUNT(*) AS nb_employes FROM employes;
.print '====================================================='
-- EX 2 -------------------------------------------------------
-- Scénario : tu dois lister tous les noms de départements
-- pour vérifier qu'ils correspondent au cahier des charges.
-- ↓ Écris ta requête ici :
SELECT nom FROM departements;
.print '====================================================='

-- EX 3 -------------------------------------------------------
-- Scénario : tu dois afficher les 5 premiers employés
-- par ordre alphabétique de nom de famille.
-- ↓ Écris ta requête ici :
SELECT prenom|| ' ' ||nom AS cinq_premiers_employes FROM employes
ORDER BY nom ASC
LIMIT 5;
.print '====================================================='

-- ============================================================
--  PARTIE 2 — Trouver des données manquantes ou incorrectes
--  (très fréquent en entretien QA)
-- ============================================================


-- EX 4 -------------------------------------------------------
-- Scénario : un bug est signalé — certains employés n'ont pas de salaire.
-- Liste-les (prénom + nom).
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE salaire IS NULL;
.print '====================================================='

-- EX 5 -------------------------------------------------------
-- Scénario : Rosa est une freelance sans département.
-- Trouve tous les employés qui n'ont PAS de département assigné.
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes
WHERE departement_id IS NULL;
.print '====================================================='


-- EX 6 -------------------------------------------------------
-- Scénario : tu dois vérifier qu'aucun email n'est vide.
-- Affiche les employés dont l'email est NULL.
-- ↓ Écris ta requête ici :

SELECT COUNT(*) AS email_manquant FROM employes
WHERE email IS NULL;
.print '====================================================='
-- EX 7 -------------------------------------------------------
-- Scénario : le RH dit que tous les employés ont un manager
-- sauf les directeurs. Vérifie qui n'a PAS de manager.
-- ↓ Écris ta requête ici :
SELECT prenom , nom FROM employes
WHERE manager_id IS NULL;
.print '====================================================='

-- ============================================================
--  PARTIE 3 — Filtrer pour valider un cas de test précis
-- ============================================================


-- EX 8 -------------------------------------------------------
-- Scénario : tu testes le filtre "département Informatique".
-- Affiche tous les employés du département 1 (prénom + nom).
-- ↓ Écris ta requête ici :
SELECT prenom|| ' '||nom AS employe_departement_informatique
FROM employes
WHERE departement_id = 1;
.print '====================================================='

-- EX 9 -------------------------------------------------------
-- Scénario : tu dois vérifier les embauches de l'année 2024.
-- Affiche prénom, nom et date d'embauche.
-- ↓ Écris ta requête ici :
SELECT prenom|| ' ' ||nom AS employes, date_embauche FROM employes
WHERE date_embauche LIKE '2024%';
.print '====================================================='

-- EX 10 ------------------------------------------------------
-- Scénario : tu testes la recherche par prénom.
-- Affiche les employés dont le prénom commence par "C".
-- ↓ Écris ta requête ici :

SELECT prenom, nom FROM employes
WHERE prenom LIKE 'C%';
.print '====================================================='
-- EX 11 ------------------------------------------------------
-- Scénario : tu dois vérifier les salaires dans une fourchette.
-- Affiche les employés avec un salaire entre 50 000 et 70 000 €.
-- ↓ Écris ta requête ici :
SELECT nom, prenom, salaire FROM employes
WHERE salaire BETWEEN 50000 AND 70000;
.print '====================================================='


-- EX 12 ------------------------------------------------------
-- Scénario : tu dois valider les projets actifs.
-- Affiche les projets dont le statut est "En cours" ou "Planifié".
-- ↓ Écris ta requête ici :

SELECT nom FROM projets
WHERE statut IN('En cours','Planifié');
.print '====================================================='

-- ============================================================
--  PARTIE 4 — Compter et résumer (rapports QA simples)
-- ============================================================


-- EX 13 ------------------------------------------------------
-- Scénario : le PO demande combien de projets existent au total.
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_projets FROM projets;
.print '====================================================='

-- EX 14 ------------------------------------------------------
-- Scénario : tu dois vérifier la répartition des employés par poste.
-- Compte le nombre d'employés pour chaque poste.
-- ↓ Écris ta requête ici :
SELECT COUNT(nom) AS nb_employes , poste FROM employes
GROUP BY poste;

.print '====================================================='


-- EX 15 ------------------------------------------------------
-- Scénario : tu dois vérifier combien de ventes par région.
-- Compte le nombre de ventes pour chaque région.
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_ventes, region  FROM ventes
GROUP BY region;
.print '====================================================='


-- EX 16 ------------------------------------------------------
-- Scénario : le client veut savoir le total des ventes en 2024.
-- Calcule la somme de tous les montants dans la table ventes.
-- ↓ Écris ta requête ici :
SELECT SUM(montant) AS total_ventes_2024  FROM ventes
WHERE strftime('%Y',date_vente) = '2024';
.print '====================================================='


-- EX 17 ------------------------------------------------------
-- Scénario : tu dois vérifier le salaire moyen de l'entreprise.
-- ↓ Écris ta requête ici :
SELECT ROUND(AVG(salaire),0) AS salaire_moyen FROM employes;


-- ============================================================
--  PARTIE 5 — Vérifier les doublons
--  (question classique en entretien)
-- ============================================================


-- EX 18 ------------------------------------------------------
-- Scénario : tu dois vérifier qu'il n'y a pas de doublons d'emails.
-- Affiche la liste des emails uniques (sans répétition).
-- ↓ Écris ta requête ici :
SELECT DISTINCT email FROM employes;
.print '====================================='

-- EX 19 ------------------------------------------------------
-- Scénario : combien d'emails distincts vs combien d'employés ?
-- Si les deux chiffres sont différents → il y a un doublon !
-- Écris DEUX requêtes séparées.
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_employes FROM employes;
SELECT COUNT(DISTINCT email) AS nb_email FROM employes;
.print '====================================='

-- ============================================================
--  PARTIE 6 — JOIN simple (2 tables — le max en QA junior)
-- ============================================================


-- EX 20 ------------------------------------------------------
-- Scénario : tu dois vérifier que chaque employé est bien
-- rattaché à un département. Affiche prénom, nom et nom du département.
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT e.prenom|| ' ' ||e.nom AS employe , d.nom AS departement
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id;
.print '====================================='


-- EX 21 ------------------------------------------------------
-- Scénario : tu dois vérifier les ventes par commercial.
-- Affiche le prénom, nom de l'employé et le montant de chaque vente.
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom , v.montant AS montant_ventes  FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id;
.print '====================================='

-- EX 22 ------------------------------------------------------
-- Scénario : tu dois trouver les ventes supérieures à 10 000 €
-- avec le nom du commercial qui les a faites.
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :
SELECT e.prenom, e.nom, v.montant FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
WHERE v.montant > 10000;
.print '====================================='

-- EX 23 ------------------------------------------------------
-- Scénario : combien d'employés par département ?
-- Affiche le nom du département et le nombre d'employés.
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT d.nom AS departement , COUNT(e.id) AS nb_employes
FROM departements d
INNER JOIN employes e
ON d.id =  e.departement_id
GROUP BY d.id, d.nom;
.print '====================================='



-- ============================================================
--  PARTIE 7 — Cas limites (questions pièges en entretien)
-- ============================================================


-- EX 24 ------------------------------------------------------
-- Scénario : quel est l'employé le mieux payé ?
-- Affiche prénom, nom et salaire — un seul résultat.
-- ↓ Écris ta requête ici :

SELECT prenom|| ' ' ||nom AS employe, salaire FROM employes
ORDER BY salaire DESC
LIMIT 1;
.print '====================================='


-- EX 25 ------------------------------------------------------
-- Scénario : quel est le projet le plus cher ?
-- Affiche nom et budget — un seul résultat.
-- ↓ Écris ta requête ici :
SELECT nom, budget FROM projets
ORDER BY budget DESC
limit 1;
.print '====================================='

-- EX 26 ------------------------------------------------------
-- Scénario : combien de ventes ont été faites en janvier 2024 ?
-- (utilise LIKE sur date_vente)
-- ↓ Écris ta requête ici :
SELECT COUNT(*) AS nb_ventes_2024
FROM ventes
WHERE date_vente LIKE '2024-01%';
.print '====================================='


-- EX 27 ------------------------------------------------------
-- Scénario : affiche le produit le plus vendu
-- (celui qui apparaît le plus souvent dans la table ventes).
-- Indice : GROUP BY produit + ORDER BY COUNT DESC + LIMIT 1
-- ↓ Écris ta requête ici :
SELECT produit , COUNT(quantite) AS le_plus_vendu FROM ventes
GROUP BY produit
ORDER BY le_plus_vendu DESC
LIMIT 1;
.print '====================================='

-- EX 28 ★ ----------------------------------------------------
-- Scénario : le manager te demande un mini-rapport :
--   - nombre total d'employés
--   - salaire moyen (arrondi)
--   - salaire minimum
--   - salaire maximum
-- Tout en UNE seule requête.
-- ↓ Écris ta requête ici :

SELECT COUNT(*) AS nb_employes, ROUND(AVG(salaire),0) AS salaire_moyen,
MIN(salaire) AS salaire_minimum, MAX(salaire) AS salaire_maximum
FROM employes;