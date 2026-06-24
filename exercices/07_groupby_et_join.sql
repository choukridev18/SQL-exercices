-- ============================================================
--  EXERCICES 07 — GROUP BY + JOIN combinés
--  Notions : JOIN + GROUP BY + HAVING + ORDER BY ensemble
--
--  ★ C'est LA combinaison la plus demandée en entretien !
--  ★ Ordre : JOIN d'abord, GROUP BY ensuite
-- ============================================================

-- ★ STRUCTURE TYPE
--   SELECT   t1.nom, COUNT(t2.id) AS nb
--   FROM     table1 t1
--   JOIN     table2 t2 ON t1.id = t2.fk
--   GROUP BY t1.id, t1.nom
--   HAVING   COUNT(t2.id) > 2
--   ORDER BY nb DESC

-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche le nombre d'employés PAR département
-- (affiche le NOM du département, pas son id)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT COUNT(e.id) AS nb_employes, d.nom AS departement
FROM departements d
INNER JOIN employes e
ON d.id = e.departement_id
GROUP BY d.id;



-- EX 2 -------------------------------------------------------
-- Même chose, trié du département avec le plus d'employés au moins
-- ↓ Écris ta requête ici :
SELECT COUNT(e.id) AS nb_employes, d.nom AS departement
FROM departements d
INNER JOIN employes e
ON d.id = e.departement_id
GROUP BY d.id
ORDER BY nb_employes DESC;


-- EX 3 -------------------------------------------------------
-- Affiche le salaire moyen PAR département
-- (arrondi à 0 décimale, trié du plus élevé au plus bas)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT ROUND(AVG(e.salaire)) AS salaire_moyen, d.nom
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.id , d.nom
ORDER BY salaire_moyen DESC;

-- EX 4 -------------------------------------------------------
-- Affiche les départements qui ont PLUS DE 3 employés
-- (utilise HAVING)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT d.nom AS departement , COUNT(e.id) AS nb_employes
FROM departements d
INNER JOIN employes e
ON d.id = e.departement_id
GROUP BY d.id, d.nom 
HAVING COUNT(e.id) > 3;



-- EX 5 -------------------------------------------------------
-- Affiche le chiffre d'affaires total PAR employé commercial
-- (prénom + nom + total des ventes, trié par CA décroissant)
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :
SELECT  SUM(v.montant) AS chiffre_affaires ,e.prenom || ' ' || e.nom AS employe
FROM ventes v
INNER JOIN employes e
ON v.employe_id = e.id
GROUP by e.id, e.nom, e.prenom
ORDER BY chiffre_affaires DESC;



-- EX 6 -------------------------------------------------------
-- Affiche le nombre d'employés et le total d'heures PAR projet
-- (affiche le NOM du projet)
-- Tables : projets + employes_projets
-- ↓ Écris ta requête ici :
SELECT COUNT(e.id) AS nb_employes, SUM(ep.heures) AS total_heures,p.nom
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id
GROUP BY p.id, p.nom;


-- EX 7 -------------------------------------------------------
-- Affiche les projets qui ont PLUS DE 3 participants
-- Tables : projets + employes_projets
-- ↓ Écris ta requête ici :

SELECT p.nom as projet, COUNT(ep.employe_id) AS nb_participants
FROM projets p
INNER JOIN employes_projets ep
ON p.id = ep.projet_id
GROUP BY p.id, p.nom
HAVING COUNT(ep.employe_id) > 3;


-- EX 8 -------------------------------------------------------
-- Affiche le chiffre d'affaires mensuel en 2024
-- (mois + total des ventes du mois, trié par mois)
-- ↓ Écris ta requête ici :

SELECT SUM(montant) AS chiffre_affaires, 
strftime('%Y-%m',date_vente) AS mois
FROM ventes
WHERE strftime('%Y', date_vente) = '2024'
GROUP BY mois
ORDER BY mois;



-- EX 9 ★ -----------------------------------------------------
-- Affiche les employés qui participent à plus de 2 projets
-- avec le nombre de projets pour chacun
-- Tables : employes + employes_projets
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom AS employe, COUNT(ep.projet_id)
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
GROUP BY e.id, e.prenom , e.nom
HAVING COUNT(ep.projet_id) > 2;

-- EX 10 ★ ----------------------------------------------------
-- Affiche le département avec la masse salariale la plus élevée
-- (un seul résultat)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT d.nom AS departement, SUM(e.salaire) AS masse_salariale
FROM departements d
INNER JOIN employes e
ON d.id = e.departement_id
GROUP BY d.nom, d.id
ORDER BY masse_salariale DESC
LIMIT 1;
