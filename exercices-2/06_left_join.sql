-- ============================================================
--  SÉRIE 2 — EXERCICES 06 — LEFT JOIN
--  Notions : LEFT JOIN, différence avec INNER JOIN,
--             détecter les lignes sans correspondance (IS NULL)
-- ============================================================
-- Lancer : ./run.sh exercices-2/06_left_join.sql
-- ============================================================

-- ★ INNER JOIN → seulement les lignes qui matchent des DEUX côtés
-- ★ LEFT JOIN  → TOUT ce qui est à gauche + ce qui matche à droite
--   (les colonnes de droite seront NULL s'il n'y a pas de match)


-- EX 1 -------------------------------------------------------
-- Affiche TOUS les employés avec le nom de leur département
-- (même Rosa, qui n'a pas de département)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom, d.nom AS departement
FROM employes e
LEFT JOIN departements d
ON e.departement_id = d.id;



-- EX 2 -------------------------------------------------------
-- Affiche TOUS les employés avec le prénom ET le nom de leur manager
-- (même les directeurs → manager = NULL)
-- Tables : employes + employes (self left join)
-- ↓ Écris ta requête ici :
SELECT e.prenom , e.nom , m.prenom|| ' ' ||m.nom AS nom_manager
FROM employes e
LEFT JOIN employes m
ON e.manager_id = m.id;

-- EX 3 -------------------------------------------------------
-- Affiche les employés qui n'ont fait AUCUNE vente
-- Astuce : LEFT JOIN sur ventes, puis WHERE ... IS NULL
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :
SELECT e.prenom, e.nom , v.date_vente 
FROM employes e
LEFT JOIN ventes v
ON e.id = v.employe_id
WHERE v.date_vente IS  NULL;

-- EX 4 -------------------------------------------------------
-- Affiche TOUS les départements avec le nombre d'employés
-- (même s'il n'y en a aucun → afficher 0)
-- Astuce : LEFT JOIN + COUNT(e.id) + GROUP BY
-- Tables : departements + employes
-- ↓ Écris ta requête ici :
SELECT d.nom, COUNT(e.id) AS nbr_employes
FROM departements d 
LEFT JOIN employes e
ON e.departement_id = d.id
GROUP BY d.nom , d.id;


-- EX 5 -------------------------------------------------------
-- Affiche TOUS les projets avec le nombre d'employés assignés
-- (les projets sans personne doivent apparaître avec 0)
-- Tables : projets + employes_projets
-- ↓ Écris ta requête ici :
SELECT p.nom , COUNT(ep.employe_id) AS nbr_employes
FROM projets p
LEFT JOIN employes_projets ep
ON ep.projet_id = p.id
GROUP BY p.nom , p.id;

-- EX 6 -------------------------------------------------------
-- Affiche les départements qui n'ont AUCUN employé
-- (s'il n'y en a pas, le résultat sera vide — c'est normal)
-- Tables : departements + employes
-- ↓ Écris ta requête ici :
.print 'exo 6'
SELECT d.nom FROM departements d
LEFT JOIN employes e
ON d.id = e.departement_id
WHERE e.id IS NULL;



-- EX 7 -------------------------------------------------------
-- Affiche TOUS les employés avec le nombre de projets auxquels
-- ils participent (0 s'ils n'en ont aucun)
-- Tables : employes + employes_projets
-- ↓ Écris ta requête ici :
SELECT e.prenom, e.nom , COUNT(ep.projet_id) AS nbr_projets
FROM employes e 
LEFT JOIN employes_projets ep
ON e.id = ep.employe_id
GROUP BY e.nom,e.id;


-- EX 8 ★ -----------------------------------------------------
-- Affiche TOUS les employés avec leur chiffre d'affaires
-- (SUM des montants). Ceux sans vente doivent apparaître
-- avec 0 (utilise COALESCE(SUM(...), 0))
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom , e.nom , COALESCE(SUM(v.montant),0) AS chiffre_affaires 
FROM employes e
LEFT JOIN ventes v
ON e.id = v.employe_id
GROUP BY e.id, e.prenom,  e.nom;
