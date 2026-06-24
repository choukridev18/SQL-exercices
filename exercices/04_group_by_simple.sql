-- ============================================================
--  EXERCICES 04 — GROUP BY (une seule table)
--  Notions : GROUP BY, COUNT, SUM, AVG, MIN, MAX, HAVING
--
--  ★ GROUP BY = "fais un paquet pour chaque valeur unique"
--  ★ HAVING   = filtre APRÈS le GROUP BY (comme WHERE mais pour les groupes)
-- ============================================================

-- ★ RAPPEL ORDRE DES CLAUSES (TRÈS IMPORTANT)
--   SELECT
--   FROM
--   WHERE      ← filtre les lignes AVANT de grouper
--   GROUP BY   ← crée les paquets
--   HAVING     ← filtre les paquets APRÈS
--   ORDER BY   ← trie le résultat final
--   LIMIT      ← limite le nombre de lignes

-- ★ RÈGLE PRINCIPALE DU GROUP BY
--   Dans le SELECT, chaque colonne qui n'est PAS dans une fonction
--   (COUNT, SUM...) DOIT être dans le GROUP BY
--   Exemple :
--     SELECT statut, COUNT(*)   → statut doit être dans GROUP BY
--     GROUP BY statut            ✅

-- ============================================================


-- EX 1 -------------------------------------------------------
-- Compte le nombre de projets PAR statut
-- Résultat attendu : une ligne par statut avec le nombre
-- Utilise la table : projets
-- ↓ Écris ta requête ici :

SELECT COUNT(nom) AS nombre_projet, statut FROM projets
GROUP BY statut;

-- EX 2 -------------------------------------------------------
-- Même chose mais trié du statut avec le plus de projets au moins
-- ↓ Écris ta requête ici :
SELECT COUNT(nom) AS nombre_projet, statut FROM projets
GROUP BY statut 
ORDER BY nombre_projet DESC;



-- EX 3 -------------------------------------------------------
-- Compte le nombre d'employés PAR poste
-- Utilise la table : employes
-- ↓ Écris ta requête ici :

SELECT COUNT(nom) AS nombre_employé , poste FROM employes
GROUP BY poste;

-- EX 4 -------------------------------------------------------
-- Affiche le salaire moyen PAR poste (arrondi à 0 décimale)
-- trié du salaire moyen le plus élevé au plus bas
-- ↓ Écris ta requête ici :
SELECT ROUND(AVG(salaire),0) AS salaire_moyen, poste FROM employes
GROUP BY poste
ORDER BY salaire_moyen DESC;



-- EX 5 -------------------------------------------------------
-- Affiche le montant total des ventes PAR région
-- trié du montant le plus élevé au plus bas
-- Utilise la table : ventes
-- ↓ Écris ta requête ici :

SELECT SUM(montant) AS montant_total, region FROM ventes
GROUP BY region
ORDER BY montant_total DESC;

-- EX 6 -------------------------------------------------------
-- Affiche le nombre de ventes et le montant total PAR produit
-- ↓ Écris ta requête ici :

SELECT COUNT(*) AS nombre_vente, SUM(montant) AS somme_total,
produit FROM ventes
GROUP BY produit;


-- EX 7 -------------------------------------------------------
-- Affiche les statuts de projets qui ont PLUS D'UN projet
-- Utilise HAVING
-- ↓ Écris ta requête ici :
SELECT statut , COUNT(*) AS nombre_projets
FROM projets
GROUP BY statut
HAVING COUNT(*) > 1;



-- EX 8 -------------------------------------------------------
-- Affiche les régions dont le total des ventes dépasse 20 000 €
-- Utilise HAVING
-- ↓ Écris ta requête ici :
SELECT region, SUM(montant) FROM ventes
GROUP BY region
HAVING SUM(montant) > 20000;


-- EX 9 -------------------------------------------------------
-- Affiche le nombre de ventes PAR mois en 2024
-- (utilise : strftime('%Y-%m', date_vente) pour extraire le mois)
-- ↓ Écris ta requête ici :

SELECT strftime('%Y-%m', date_vente) AS mois, COUNT(*) AS nb_ventes
FROM ventes
WHERE strftime('%Y', date_vente) = '2024'
GROUP BY mois
ORDER BY mois;






-- EX 10 ★ (un peu plus dur) ----------------------------------
-- Affiche les produits dont le montant moyen par vente dépasse 10 000 €
-- ↓ Écris ta requête ici :

SELECT produit , ROUND(AVG(montant), 0)
FROM ventes
GROUP BY produit
HAVING AVG(montant) > 10000;