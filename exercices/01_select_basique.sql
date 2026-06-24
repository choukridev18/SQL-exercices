-- ============================================================
--  EXERCICES 01 — SELECT de base
--  Notions : SELECT, FROM, *, colonnes, DISTINCT, LIMIT,
--             ORDER BY ASC/DESC, AS (alias), || (concaténation)
-- ============================================================
-- Lancer : ./run.sh exercices/01_select_basique.sql
-- ============================================================

-- ★ RAPPEL SYNTAXE DE BASE
--   SELECT [quoi]
--   FROM   [quelle table]
--   ORDER BY [colonne] ASC/DESC
--   LIMIT [nombre]
-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche TOUTES les colonnes de la table employes
-- ↓ Écris ta requête ici :

SELECT * FROM employes;


-- EX 2 -------------------------------------------------------
-- Affiche uniquement le prénom et le nom des employés
-- ↓ Écris ta requête ici :
SELECT prenom, nom FROM employes;


-- EX 3 -------------------------------------------------------
-- Affiche le prénom, le nom et le salaire des employés
-- ↓ Écris ta requête ici :
select prenom, nom, salaire FROM employes;


-- EX 4 -------------------------------------------------------
-- Affiche les employés triés par salaire du plus élevé au plus bas
-- ↓ Écris ta requête ici :

SELECT prenom, nom , salaire FROM employes
order BY salaire DESC;

-- EX 5 -------------------------------------------------------
-- Affiche les 3 employés les mieux payés
-- ↓ Écris ta requête ici :

SELECT prenom, nom, salaire FROM employes
ORDER BY salaire DESC
LIMIT 3;

-- EX 6 -------------------------------------------------------
-- Affiche la liste des postes SANS doublon
-- (chaque poste ne doit apparaître qu'une seule fois)
-- ↓ Écris ta requête ici :

SELECT DISTINCT poste FROM employes;

-- EX 7 -------------------------------------------------------
-- Affiche le prénom et le nom collés en une seule colonne
-- appelée "nom_complet"
-- Résultat attendu : "Alice Martin", "Bruno Dupont", etc.
-- Astuce : utilise || pour coller du texte
-- ↓ Écris ta requête ici :

SELECT prenom ||' '|| nom AS nom_complet FROM employes;


-- EX 8 -------------------------------------------------------
-- Affiche tous les projets triés par budget du plus grand au plus petit
-- Renomme la colonne budget en "budget_projet"
-- ↓ Écris ta requête ici :

SELECT nom, budget AS budget_projet FROM projets
ORDER BY budget DESC;


-- EX 9 -------------------------------------------------------
-- Affiche le prénom, nom et date d'embauche des employés
-- triés du plus récent au plus ancien
-- ↓ Écris ta requête ici :

SELECT prenom, nom, date_embauche  FROM employes
ORDER BY date_embauche DESC;