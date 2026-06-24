-- ============================================================
--  EXERCICES 06 — LEFT JOIN
--  Notions : LEFT JOIN, différence avec INNER JOIN,
--             détecter les lignes sans correspondance (IS NULL)
--
--  ★ LEFT JOIN = affiche TOUT ce qui est à gauche
--    même si la droite n'a pas de correspondance
--    → les colonnes de droite seront NULL dans ce cas
-- ============================================================

-- ★ DIFFÉRENCE INNER vs LEFT
--
--   employes          departements
--   --------          ------------
--   Alice  → dept 1   1 → Informatique  ✅ apparaît dans les deux
--   Rosa   → dept NULL                  ❌ INNER : disparaît
--                                       ✅ LEFT  : apparaît avec NULL
--
-- Règle simple :
--   INNER JOIN → seulement les lignes qui matchent des DEUX côtés
--   LEFT JOIN  → TOUT ce qui est à gauche + ce qui matche à droite

-- ============================================================


-- EX 1 -------------------------------------------------------
-- Affiche TOUS les employés avec le nom de leur département
-- (même ceux sans département)
-- Compare avec un INNER JOIN pour voir la différence
-- Tables : employes + departements
-- ↓ Écris ta requête ici :

SELECT e.prenom, e.nom AS employe, d.nom as departement
FROM employes e 
LEFT JOIN departements d
ON e.departement_id = d.id;


-- EX 2 -------------------------------------------------------
-- Affiche TOUS les employés avec le prénom de leur manager
-- (même les directeurs qui n'ont pas de manager)
-- Pour les directeurs, la colonne manager affichera NULL
-- Tables : employes + employes (self left join)
-- ↓ Écris ta requête ici :

SELECT e.prenom || ' ' || e.nom AS employe, m.nom as manager
FROM employes e
LEFT JOIN employes m
ON e.manager_id = m.id;

-- EX 3 -------------------------------------------------------
-- Affiche les employés qui ne participent à AUCUN projet
-- Astuce : LEFT JOIN sur employes_projets, puis filtre WHERE ... IS NULL
-- Tables : employes + employes_projets
-- ↓ Écris ta requête ici :
SELECT e.prenom , e.nom
FROM employes e
LEFT JOIN employes_projets p
ON e.id = p.employe_id
WHERE p.employe_id IS NULL ;

-- EX 4 -------------------------------------------------------
-- Affiche TOUS les départements avec le nombre d'employés dans chacun
-- (même les départements sans employés → ils afficheront 0)
-- Astuce : LEFT JOIN + COUNT + GROUP BY
-- Tables : departements + employes
-- ↓ Écris ta requête ici :

SELECT  d.nom AS departement,COUNT(e.id) AS nb_employes
FROM departements d 
LEFT JOIN employes e
ON d.id = e.departement_id
GROUP BY d.nom , d.id;


-- EX 5 -------------------------------------------------------
-- Affiche les projets qui n'ont aucun employé assigné
-- Tables : projets + employes_projets
-- ↓ Écris ta requête ici :

SELECT p.nom AS projet
FROM projets p
LEFT JOIN employes_projets ep
ON p.id = ep.projet_id
WHERE ep.projet_id IS NULL;

-- EX 6 -------------------------------------------------------
-- Affiche tous les employés avec leur chiffre d'affaires total
-- (même ceux qui n'ont pas fait de ventes → ils afficheront NULL ou 0)
-- Tables : employes + ventes
-- ↓ Écris ta requête ici :

SELECT e.prenom || ' ' || e.nom AS employe, SUM(v.montant) AS chiffre_affaires
FROM employes e
LEFT JOIN ventes v
ON e.id = v.employe_id
GROUP BY e.id,e.nom, e.prenom
ORDER BY chiffre_affaires DESC;