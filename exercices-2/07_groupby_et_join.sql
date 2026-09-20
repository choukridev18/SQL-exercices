-- ============================================================
--  SÉRIE 2 — EXERCICES 07 — GROUP BY + JOIN combinés
--  Notions : JOIN + GROUP BY + HAVING + ORDER BY ensemble
--
--  ★ C'est LA combinaison la plus demandée en entretien
-- ============================================================
-- Lancer : ./run.sh exercices-2/07_groupby_et_join.sql
-- ============================================================

-- ★ STRUCTURE TYPE
--   SELECT   t1.nom, COUNT(t2.id) AS nb
--   FROM     table1 t1
--   JOIN     table2 t2 ON t1.id = t2.fk
--   GROUP BY t1.id, t1.nom
--   HAVING   COUNT(t2.id) > 2
--   ORDER BY nb DESC


-- EX 1 -------------------------------------------------------
-- Affiche le nombre d'employés PAR ville de département
-- (affiche la ville, pas l'id)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT  d.ville,  COUNT(e.id) AS nb_employes
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.ville;


-- EX 2 -------------------------------------------------------
-- Affiche le salaire moyen PAR ville
-- (arrondi à 0, trié du plus élevé au plus bas)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT d.ville , ROUND(AVG(e.salaire),0) AS salaire
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.ville
ORDER BY salaire DESC;



-- EX 3 -------------------------------------------------------
-- Affiche les villes qui ont PLUS DE 3 employés
-- Utilise HAVING
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT d.ville , COUNT(e.id) AS employes
FROM departements d
INNER JOIN employes e
ON e.departement_id = d.id
GROUP BY d.ville
HAVING COUNT(e.id) > 3;



-- EX 4 -------------------------------------------------------
-- Affiche le chiffre d'affaires total PAR commercial
-- (prénom + nom + total), trié par CA décroissant
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom , SUM(v.montant) AS chiffre_affaires 
FROM employes e
INNER JOIN ventes v
ON v.employe_id = e.id
GROUP BY e.id, e.prenom, e.nom
ORDER BY chiffre_affaires  DESC;



-- EX 5 -------------------------------------------------------
-- Affiche le nombre de ventes ET le total PAR commercial
-- uniquement pour ceux qui ont fait AU MOINS 3 ventes
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom , e.nom, COUNT(v.date_vente) AS nb_ventes,
SUM(v.montant) AS total
FROM employes e
INNER JOIN ventes v
ON v.employe_id = e.id
GROUP BY e.prenom , e.nom
HAVING nb_ventes >= 3;



-- EX 6 -------------------------------------------------------
-- Affiche le nombre d'employés et le total d'heures PAR projet
-- (affiche le NOM du projet), trié par heures décroissantes
-- Tables : projets + employes_projets
-- ↓ Écris ta requête ici :

SELECT p.nom, COUNT(ep.employe_id) AS nb_employés, SUM(ep.heures) AS total_heure
FROM projets p
INNER JOIN employes_projets ep
ON p.id = ep.projet_id
GROUP BY p.id
ORDER BY total_heure DESC;



-- EX 7 -------------------------------------------------------
-- Affiche les projets dont le total d'heures dépasse 200
-- Tables : projets + employes_projets
-- ↓ Écris ta requête ici :

SELECT p.nom, SUM(ep.heures) AS total_heure
FROM projets p 
INNER JOIN employes_projets ep
ON ep.projet_id = p.id 
GROUP BY p.id, p.nom
HAVING total_heure > 200;




-- EX 8 -------------------------------------------------------
-- Pour chaque région, affiche le nombre de commerciaux distincts
-- qui y ont vendu (COUNT(DISTINCT employe_id))
-- Table : ventes
-- ↓ Écris ta requête ici :
SELECT region , COUNT(DISTINCT employe_id) AS nb_commerciaux
FROM ventes 
GROUP BY region;





-- EX 9 ★ -----------------------------------------------------
-- Affiche les employés qui ont travaillé PLUS DE 300 heures
-- au total (toutes participations confondues)
-- avec leur prénom, nom et total d'heures
-- Tables : employes + employes_projets
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom , SUM(ep.heures) AS heure_travaille
FROM employes e
INNER JOIN employes_projets ep
ON ep.employe_id = e.id
GROUP BY e.id, e.prenom, e.nom
HAVING heure_travaille > 300;


-- EX 10 ★ ----------------------------------------------------
-- Affiche le département avec le salaire moyen le plus élevé
-- (un seul résultat : nom du département + salaire moyen arrondi)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT d.nom, ROUND(AVG(e.salaire),0) AS salaire
FROM employes e 
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.id, d.nom
ORDER BY salaire DESC
LIMIT 1;


-- EX 11 ★ ----------------------------------------------------
-- Pour chaque département, affiche :
--   nom, nombre d'employés, masse salariale, salaire moyen (arrondi)
-- trié par masse salariale décroissante
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT d.nom AS departement , COUNT(e.id) AS nb_employes,
SUM(e.salaire) AS masse_salariale,
ROUND(AVG(e.salaire),0) AS salaire_moyen
FROM departements d
INNER JOIN employes e
ON e.departement_id = d.id
GROUP BY d.nom
ORDER BY masse_salariale DESC;