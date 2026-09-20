-- ============================================================
--  SÉRIE 2 — EXERCICES 01 — SELECT de base
--  Notions : SELECT, FROM, *, colonnes, DISTINCT, LIMIT,
--             ORDER BY ASC/DESC, AS (alias), || (concaténation)
-- ============================================================
-- Lancer : ./run.sh exercices-2/01_select_basique.sql
-- ============================================================

-- ★ RAPPEL SYNTAXE DE BASE
--   SELECT [quoi]
--   FROM   [quelle table]
--   ORDER BY [colonne] ASC/DESC
--   LIMIT [nombre]
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche TOUTES les colonnes de la table departements
-- ↓ Écris ta requête ici :
.print 'exo 1'
SELECT * FROM departements;



-- EX 2 -------------------------------------------------------
-- Affiche uniquement le nom et la ville de chaque département
-- ↓ Écris ta requête ici :
.print 'exo 2'
SELECT nom, ville FROM departements;


-- EX 3 -------------------------------------------------------
-- Affiche le nom, le statut et le budget de chaque projet
-- ↓ Écris ta requête ici :
.print 'exo 3'
SELECT nom , statut , budget FROM projets;


-- EX 4 -------------------------------------------------------
-- Affiche les départements triés par budget du plus petit au plus grand
-- ↓ Écris ta requête ici :
.print 'exo 4'
SELECT nom,budget FROM departements
ORDER BY budget ASC;


-- EX 5 -------------------------------------------------------
-- Affiche les 2 projets avec le plus gros budget
-- (nom + budget)
-- ↓ Écris ta requête ici :
.print 'exo 5'
SELECT nom, budget FROM projets
ORDER BY budget DESC
LIMIT 2;



-- EX 6 -------------------------------------------------------
-- Affiche la liste des villes de départements SANS doublon
-- ↓ Écris ta requête ici :
.print 'exo 6'
SELECT DISTINCT ville from departements;



-- EX 7 -------------------------------------------------------
-- Affiche le nom du projet et son statut collés en une seule colonne
-- appelée "projet_statut"
-- Résultat attendu : "Refonte Site Web — Terminé", etc.
-- Astuce : utilise || pour coller du texte
-- ↓ Écris ta requête ici :
.print 'exo 7'
SELECT nom||' - '||statut AS projet_statut FROM projets ;

-- EX 8 -------------------------------------------------------
-- Affiche toutes les ventes triées par montant du plus élevé au plus bas
-- Renomme la colonne montant en "montant_vente"
-- (affiche produit + montant_vente)
-- ↓ Écris ta requête ici :
.print 'exo 8'
SELECT produit , montant AS montant_vente from ventes
ORDER BY montant DESC;


-- EX 9 -------------------------------------------------------
-- Affiche le produit, la quantité et la date de chaque vente
-- triés de la plus ancienne à la plus récente
-- ↓ Écris ta requête ici :
.print 'exo 9'
SELECT produit, quantite, date_vente FROM ventes
ORDER BY date_vente ASC;


-- EX 10 ------------------------------------------------------
-- Affiche le prénom et le nom des employés
-- triés par nom de famille (A → Z), puis par prénom
-- ↓ Écris ta requête ici :
.print 'exo 10'

SELECT prenom, nom FROM employes
ORDER BY nom ASC , prenom ASC;
