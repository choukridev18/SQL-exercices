-- ============================================================
--  EXERCICES 05 — Première jointure (INNER JOIN)
--  Notions : INNER JOIN, ON, alias de table
--
--  ★ JOIN = relier deux tables grâce à une clé commune
--  ★ ON   = définir le lien entre les deux tables
-- ============================================================

-- ★ RAPPEL SYNTAXE
--   SELECT a.colonne, b.colonne
--   FROM   tableA a
--   INNER JOIN tableB b ON a.cle = b.cle
--
--   → a et b sont des alias (surnoms) pour les tables
--   → ON indique comment les deux tables se rejoignent

-- ★ INNER JOIN = n'affiche que les lignes qui ont
--   une correspondance dans LES DEUX tables
--   (les lignes sans correspondance disparaissent)

-- ★ SCHÉMA DES LIENS (voir schema.md)
--   employes.departement_id → departements.id
--   employes.manager_id     → employes.id  (self-join)
--   employes_projets.employe_id → employes.id
--   employes_projets.projet_id  → projets.id
--   ventes.employe_id       → employes.id

-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche le prénom, le nom de chaque employé
-- ET le nom de son département
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT e.prenom,e.nom, d.nom AS département
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id ;



-- EX 2 -------------------------------------------------------
-- Même chose mais affiche aussi la ville du département
-- Tables : employes + departements
-- ↓ Écris ta requête ici :
SELECT e.prenom, e.nom , d.nom AS departement, d.ville 
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id ;


-- EX 3 -------------------------------------------------------
-- Affiche le prénom, nom de l'employé et le nom du projet
-- pour chaque participation (table employes_projets)
-- Tables : employes + employes_projets + projets
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom , p.nom AS nom_projet
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id ;


-- EX 4 -------------------------------------------------------
-- Affiche le prénom, nom de l'employé, le nom du projet
-- ET son rôle sur le projet
-- Tables : employes + employes_projets + projets
-- ↓ Écris ta requête ici :
SELECT e.prenom || ' ' || e.nom AS employé, p.nom AS projet, ep.role
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id
INNER JOIN projets p
ON ep.projet_id = p.id; 

-- EX 5 -------------------------------------------------------
-- Affiche le prénom, nom de l'employé
-- ET le montant de chaque vente qu'il a faite
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom,e.nom , v.montant
FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id;



-- EX 6 -------------------------------------------------------
-- Affiche le prénom, nom, le produit vendu et le montant
-- uniquement pour les ventes supérieures à 10 000 €
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom , v.produit, v.montant
FROM employes e
INNER JOIN ventes v 
ON e.id = v.employe_id
WHERE v.montant > 10000;


-- EX 7 -------------------------------------------------------
-- Affiche le prénom et le nom de l'employé
-- ET le prénom et le nom de son manager
-- (self-join : employes reliée à elle-même)
-- Affiche seulement les employés qui ONT un manager
-- Tables : employes + employes (alias différents)
-- ↓ Écris ta requête ici :

SELECT e.prenom || ' ' || e.nom AS employe, 
m.prenom || ' ' || m.nom AS manager
FROM employes e
INNER JOIN employes m
ON e.manager_id = m.id ;




-- EX 8 -------------------------------------------------------
-- Affiche les employés qui participent au projet "CRM Interne"
-- avec leur rôle
-- Tables : employes + employes_projets + projets
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom , ep.role
FROM employes e
INNER JOIN employes_projets ep
ON e.id = ep.employe_id 
INNER JOIN projets p
ON ep.projet_id = p.id
WHERE p.nom = 'CRM Interne';