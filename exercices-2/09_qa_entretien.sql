-- ============================================================
--  SÉRIE 2 — EXERCICES 09 — SQL QA Entretien
--  Niveau : bases — ce qu'on te demande vraiment en QA
--
--  Contexte : tu es QA, on te donne une base et tu dois
--  vérifier si les données sont correctes.
-- ============================================================
-- Lancer : ./run.sh exercices-2/09_qa_entretien.sql
-- Schéma : voir schema.md
--
-- IMPORTANT : .print AVANT chaque requête
-- ============================================================


-- ============================================================
--  PARTIE 1 — Les données existent-elles ?
-- ============================================================


-- Q1
-- Combien y a-t-il de ventes en base ?
-- ↓ Ta requête :

.print ''
.print '========== Q1 =========='
SELECT  COUNT(*) AS nb_ventes FROM ventes;


-- Q2
-- Liste tous les statuts de projets DISTINCTS
-- (pour vérifier qu'ils correspondent au cahier des charges).
-- ↓ Ta requête :

.print ''
.print '========== Q2 =========='
SELECT DISTINCT statut AS statut_projets FROM projets;


-- Q3
-- Affiche les 4 employés les moins bien payés
-- (prénom, nom, salaire) — ignore ceux sans salaire.
-- ↓ Ta requête :

.print ''
.print '========== Q3 =========='
SELECT prenom, nom, salaire FROM employes
WHERE salaire IS NOT NULL
ORDER BY salaire ASC
LIMIT 4;

-- ============================================================
--  PARTIE 2 — Données manquantes / incorrectes
-- ============================================================


-- Q4
-- Un bug est signalé : certains projets n'ont pas de date_fin.
-- Liste nom, statut et date_debut de ces projets.
-- ↓ Ta requête :

.print ''
.print '========== Q4 =========='

SELECT nom, statut, date_debut FROM projets
WHERE date_fin IS NULL;



-- Q5
-- Le RH affirme que tous les employés ont un email.
-- Compte les employés dont l'email est NULL.
-- ↓ Ta requête :

.print ''
.print '========== Q5 =========='
SELECT COUNT(*) AS nb_employe_sans_email FROM employes
WHERE email IS NULL; 


-- Q6
-- Trouve les employés qui n'ont ni manager NI département
-- (les deux colonnes à NULL).
-- ↓ Ta requête :

.print ''
.print '========== Q6 =========='
SELECT prenom||' '||nom AS employe FROM employes
WHERE manager_id IS NULL
AND departement_id IS NULL;

-- ============================================================
--  PARTIE 3 — Filtrer un cas de test
-- ============================================================


-- Q7
-- Tu testes le filtre "département Finance" (id = 4).
-- Affiche prénom, nom et poste.
-- ↓ Ta requête :

.print ''
.print '========== Q7 =========='
SELECT e.prenom, e.nom, e.poste FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
WHERE d.nom LIKE '%Finance%';


-- Q8
-- Tu dois vérifier les embauches entre 2018 et 2020 inclus.
-- Affiche prénom, nom, date_embauche, du plus ancien au plus récent.
-- ↓ Ta requête :

.print ''
.print '========== Q8 =========='
SELECT prenom , nom , date_embauche FROM employes
WHERE strftime('%Y',date_embauche) IN ('2018','2019','2020')
ORDER BY date_embauche ASC;


-- Q9
-- Recherche : employés dont le prénom se termine par 'e'
-- (Alice, Grace, etc.).
-- ↓ Ta requête :

.print ''
.print '========== Q9 =========='

SELECT prenom, nom FROM employes
WHERE prenom LIKE '%e';


-- Q10
-- Valide les ventes en région Est ou Nord
-- dont la quantité est supérieure à 1.
-- Affiche produit, quantite, region, montant.
-- ↓ Ta requête :

.print ''
.print '========== Q10 =========='
SELECT produit , quantite , region, montant FROM ventes
WHERE region IN ('Est','Nord')
AND quantite > 1;

-- ============================================================
--  PARTIE 4 — Compter et résumer
-- ============================================================


-- Q11
-- Combien de rôles différents existent dans employes_projets ?
-- (COUNT DISTINCT sur la colonne role)
-- ↓ Ta requête :

.print ''
.print '========== Q11 =========='
SELECT COUNT(DISTINCT role) AS nb_roles FROM employes_projets; 


-- Q12
-- Répartition des projets par statut (statut + nombre).
-- ↓ Ta requête :

.print ''
.print '========== Q12 =========='
SELECT statut ,   COUNT(id) AS nombre_projets FROM projets
GROUP BY statut;


-- Q13
-- Total des ventes réalisées en région Sud.
-- ↓ Ta requête :

.print ''
.print '========== Q13 =========='

SELECT SUM(montant) AS total_des_ventes FROM ventes
WHERE region = 'Sud';

-- Q14
-- Salaire moyen des employés du département 1, arrondi à 0.
-- ↓ Ta requête :

.print ''
.print '========== Q14 =========='

SELECT ROUND(AVG(salaire),0) AS salaire_moyen FROM employes
WHERE departement_id = 1;

-- ============================================================
--  PARTIE 5 — JOIN simple
-- ============================================================


-- Q15
-- Affiche prénom, nom et ville de département de chaque employé.
-- Tables : employes + departements
-- ↓ Ta requête :

.print ''
.print '========== Q15 =========='
SELECT e.prenom , e.nom , d.nom , d.ville  
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id;



-- Q16
-- Affiche toutes les ventes de Océane Girard
-- (produit, montant, date_vente).
-- ↓ Ta requête :

.print ''
.print '========== Q16 =========='
SELECT e.prenom||' '||e.nom AS employe , v.produit , v.montant,
v.date_vente FROM employes e
INNER JOIN ventes v
ON e.id = v.employe_id
WHERE nom = 'Girard'AND prenom = 'Océane';


-- Q17
-- Combien d'employés par département ?
-- Affiche le nom du département et le nombre.
-- ↓ Ta requête :

.print ''
.print '========== Q17 =========='

SELECT COUNT(e.id) AS nb_employes, d.nom
FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
GROUP BY d.nom;

-- ============================================================
--  PARTIE 6 — Questions pièges
-- ============================================================


-- Q18
-- Quel est le projet le moins cher parmi ceux "En cours" ?
-- Un seul résultat (nom + budget).
-- ↓ Ta requête :

.print ''
.print '========== Q18 =========='

SELECT nom, budget FROM projets
WHERE statut = 'En cours'
ORDER BY budget ASC
limit 1;



-- Q19
-- Combien d'unités de Support Premium ont été vendues au total ?
-- (SUM de quantite, pas COUNT)
-- ↓ Ta requête :

.print ''
.print '========== Q19 =========='

SELECT SUM(quantite) AS nb_unités FROM ventes
WHERE produit = 'Support Premium';


-- Q20 ★
-- Mini-rapport sur le département Commercial (id = 5) :
--   nombre d'employés, salaire moyen (arrondi), salaire max.
-- Une seule requête.
-- ↓ Ta requête :

.print ''
.print '========== Q20 =========='

SELECT COUNT(e.id) AS nb_employés, ROUND(AVG(e.salaire),0) AS salaire_moyen,
MAX(e.salaire) AS salaire_maximum FROM employes e
INNER JOIN departements d
ON e.departement_id = d.id
WHERE d.nom = 'Commercial';