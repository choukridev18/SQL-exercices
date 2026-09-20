-- ============================================================
--  SÉRIE 2 — EXERCICES 05 — Première jointure (INNER JOIN)
--  Notions : INNER JOIN, ON, alias de table
-- ============================================================
-- Lancer : ./run.sh exercices-2/05_jointures_intro.sql
-- ============================================================

-- ★ RAPPEL SYNTAXE
--   SELECT a.colonne, b.colonne
--   FROM   tableA a
--   INNER JOIN tableB b ON a.cle = b.cle
--
-- ★ INNER JOIN = seulement les lignes qui matchent DES DEUX côtés
--
-- ★ SCHÉMA DES LIENS (voir schema.md)
--   employes.departement_id     → departements.id
--   employes.manager_id         → employes.id
--   employes_projets.employe_id → employes.id
--   employes_projets.projet_id  → projets.id
--   ventes.employe_id           → employes.id


-- EX 1 -------------------------------------------------------
-- Affiche le prénom, le nom de chaque employé
-- ET la ville de son département
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT e.prenom , e.nom , d.ville 
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id;


-- EX 2 -------------------------------------------------------
-- Affiche le prénom, le nom, le nom du département
-- ET le budget de ce département
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT e.prenom , e.nom , d.nom AS departement, d.budget
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id;



-- EX 3 -------------------------------------------------------
-- Affiche le prénom, nom de l'employé, le nom du projet
-- ET le nombre d'heures travaillées
-- Tables : employes + employes_projets + projets
-- ↓ Écris ta requête ici :
.print "exo3"
SELECT e.prenom , e.nom, p.nom AS projet, ep.heures
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id;


-- EX 4 -------------------------------------------------------
-- Affiche uniquement les participations de plus de 100 heures
-- (prénom, nom, projet, heures)
-- Tables : employes + employes_projets + projets
-- ↓ Écris ta requête ici :
.print '__________________________'
SELECT e.prenom, e.nom, p.nom AS projet, ep.heures
FROM employes e 
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id
WHERE ep.heures > 100;



-- EX 5 -------------------------------------------------------
-- Affiche le prénom, nom du commercial, le produit et la région
-- pour chaque vente
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :
SELECT e.prenom||' '||e.nom AS commercial, v.produit, v.region
FROM employes e 
INNER JOIN ventes v
ON e.id = v.employe_id;



-- EX 6 -------------------------------------------------------
-- Affiche les ventes de plus de 15 000 €
-- avec le prénom et le nom du commercial
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :
SELECT e.prenom,e.nom , v.montant
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
WHERE v.montant > 15000;


-- EX 7 -------------------------------------------------------
-- Affiche le prénom et le nom de l'employé
-- ET le prénom et le nom de son manager
-- Seulement les employés qui ONT un manager
-- Tables : employes + employes (self-join)
-- ↓ Écris ta requête ici :
SELECT e.prenom,e.nom , m.prenom||' '||m.nom AS manager
FROM employes e
JOIN employes m
ON m.id = e.manager_id;

-- EX 8 -------------------------------------------------------
-- Affiche les employés qui participent au projet "Migration Cloud"
-- avec leur rôle
-- Tables : employes + employes_projets + projets
-- ↓ Écris ta requête ici :
SELECT e.prenom , e.nom , p.nom AS projet, ep.role
FROM employes e 
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id
WHERE p.nom LIKE '%Migration Cloud%';


-- EX 9 -------------------------------------------------------
-- Affiche les employés du département "Marketing"
-- (prénom, nom, poste)
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT e.prenom , e.nom , e.poste, d.nom
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
WHERE d.nom LIKE '%Marketing%';


-- EX 10 ------------------------------------------------------
-- Affiche les employés embauchés après 2021
-- avec le nom de leur département
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT e.prenom, e.nom, strftime('%Y-%m',e.date_embauche) , d.nom
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id 
WHERE strftime('%Y',e.date_embauche) > '2021';