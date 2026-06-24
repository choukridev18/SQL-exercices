-- ============================================================
--  SETUP : Base de données "Entreprise TechCorp"
--  Utilisée pour tous les exercices SQL
-- ============================================================

-- Nettoyage si les tables existent déjà
DROP TABLE IF EXISTS ventes;
DROP TABLE IF EXISTS employes_projets;
DROP TABLE IF EXISTS projets;
DROP TABLE IF EXISTS employes;
DROP TABLE IF EXISTS departements;

-- ============================================================
--  TABLE : departements
-- ============================================================
CREATE TABLE departements (
    id          INTEGER PRIMARY KEY,
    nom         TEXT    NOT NULL,
    ville       TEXT    NOT NULL,
    budget      REAL    NOT NULL
);

INSERT INTO departements VALUES
(1, 'Informatique',   'Paris',    500000),
(2, 'Marketing',      'Lyon',     300000),
(3, 'Ressources Humaines', 'Paris', 200000),
(4, 'Finance',        'Bordeaux', 400000),
(5, 'Commercial',     'Marseille',350000);

-- ============================================================
--  TABLE : employes
-- ============================================================
CREATE TABLE employes (
    id              INTEGER PRIMARY KEY,
    prenom          TEXT    NOT NULL,
    nom             TEXT    NOT NULL,
    email           TEXT    UNIQUE,
    salaire         REAL,
    poste           TEXT    NOT NULL,
    departement_id  INTEGER REFERENCES departements(id),
    manager_id      INTEGER REFERENCES employes(id),
    date_embauche   TEXT    NOT NULL
);

INSERT INTO employes VALUES
(1,  'Alice',   'Martin',   'alice.martin@techcorp.fr',   85000, 'Directrice IT',       1, NULL, '2018-03-15'),
(2,  'Bruno',   'Dupont',   'bruno.dupont@techcorp.fr',   72000, 'Développeur Senior',  1, 1,    '2019-06-01'),
(3,  'Camille', 'Bernard',  'camille.b@techcorp.fr',      68000, 'Développeur Senior',  1, 1,    '2020-01-10'),
(4,  'David',   'Petit',    'david.petit@techcorp.fr',    55000, 'Développeur Junior',  1, 2,    '2022-09-05'),
(5,  'Emma',    'Leroy',    'emma.leroy@techcorp.fr',     58000, 'Data Analyst',        1, 1,    '2021-04-20'),
(6,  'Florian', 'Moreau',   'florian.m@techcorp.fr',      90000, 'Directeur Marketing', 2, NULL, '2017-11-01'),
(7,  'Grace',   'Simon',    'grace.simon@techcorp.fr',    62000, 'Chef de Projet Mktg', 2, 6,    '2020-07-15'),
(8,  'Hugo',    'Laurent',  'hugo.laurent@techcorp.fr',   50000, 'Chargé Communication',2, 6,    '2023-01-20'),
(9,  'Inès',    'Michel',   'ines.michel@techcorp.fr',    78000, 'DRH',                 3, NULL, '2016-05-10'),
(10, 'Julien',  'Garcia',   'julien.garcia@techcorp.fr',  52000, 'Chargé RH',           3, 9,    '2021-08-30'),
(11, 'Karen',   'Roux',     'karen.roux@techcorp.fr',     95000, 'Directeur Financier', 4, NULL, '2015-02-28'),
(12, 'Luca',    'Fournier', 'luca.fournier@techcorp.fr',  70000, 'Contrôleur Gestion',  4, 11,   '2019-03-12'),
(13, 'Marie',   'Faure',    'marie.faure@techcorp.fr',    65000, 'Comptable Senior',    4, 11,   '2020-10-05'),
(14, 'Nicolas', 'Blanc',    'nicolas.blanc@techcorp.fr',  88000, 'Directeur Commercial',5, NULL, '2018-08-01'),
(15, 'Océane',  'Girard',   'oceane.girard@techcorp.fr',  60000, 'Commercial Senior',   5, 14,   '2021-02-15'),
(16, 'Paul',    'Bonnet',   'paul.bonnet@techcorp.fr',    53000, 'Commercial Junior',   5, 14,   '2023-05-10'),
(17, 'Quentin', 'Thomas',   'quentin.t@techcorp.fr',      47000, 'Stagiaire Dev',       1, 2,    '2024-02-01'),
(18, 'Rosa',    'Dubois',   'rosa.dubois@techcorp.fr',    NULL,  'Freelance',           NULL, NULL,'2024-06-01');

-- ============================================================
--  TABLE : projets
-- ============================================================
CREATE TABLE projets (
    id          INTEGER PRIMARY KEY,
    nom         TEXT    NOT NULL,
    budget      REAL    NOT NULL,
    statut      TEXT    NOT NULL CHECK(statut IN ('En cours','Terminé','Annulé','Planifié')),
    date_debut  TEXT    NOT NULL,
    date_fin    TEXT
);

INSERT INTO projets VALUES
(1, 'Refonte Site Web',       120000, 'Terminé',   '2023-01-01', '2023-06-30'),
(2, 'Application Mobile',     250000, 'En cours',  '2024-01-15', NULL),
(3, 'CRM Interne',            180000, 'En cours',  '2023-09-01', NULL),
(4, 'Campagne Réseaux Sociaux', 45000, 'Terminé',  '2023-03-01', '2023-05-31'),
(5, 'Audit RH',                30000, 'Terminé',   '2023-07-01', '2023-09-30'),
(6, 'Système de Paie',        200000, 'Planifié',  '2025-01-01', NULL),
(7, 'Migration Cloud',        300000, 'En cours',  '2024-03-01', NULL),
(8, 'Formation Équipes',       15000, 'Annulé',    '2024-01-01', NULL);

-- ============================================================
--  TABLE : employes_projets  (association)
-- ============================================================
CREATE TABLE employes_projets (
    employe_id  INTEGER REFERENCES employes(id),
    projet_id   INTEGER REFERENCES projets(id),
    role        TEXT    NOT NULL,
    heures      INTEGER NOT NULL,
    PRIMARY KEY (employe_id, projet_id)
);

INSERT INTO employes_projets VALUES
(1,  7, 'Sponsor',           20),
(2,  1, 'Tech Lead',        200),
(2,  2, 'Tech Lead',        350),
(2,  7, 'Architecte',       180),
(3,  1, 'Développeur',      300),
(3,  3, 'Tech Lead',        280),
(4,  2, 'Développeur',      400),
(4,  3, 'Développeur',      200),
(5,  3, 'Data Analyst',     150),
(5,  5, 'Analyste',          60),
(6,  4, 'Sponsor',           10),
(7,  4, 'Chef de Projet',   120),
(8,  4, 'Exécutant',         90),
(9,  5, 'Responsable',       80),
(10, 5, 'Participant',       40),
(11, 6, 'Sponsor',           15),
(12, 6, 'Chef de Projet',    50),
(14, 3, 'Stakeholder',       20),
(15, 3, 'Commercial',        60),
(17, 2, 'Stagiaire Dev',    300);

-- ============================================================
--  TABLE : ventes
-- ============================================================
CREATE TABLE ventes (
    id          INTEGER PRIMARY KEY,
    employe_id  INTEGER REFERENCES employes(id),
    produit     TEXT    NOT NULL,
    montant     REAL    NOT NULL,
    quantite    INTEGER NOT NULL,
    date_vente  TEXT    NOT NULL,
    region      TEXT    NOT NULL
);

INSERT INTO ventes VALUES
(1,  15, 'Licence Pro',     15000, 1, '2024-01-10', 'Sud'),
(2,  15, 'Support Premium', 8000,  1, '2024-01-22', 'Sud'),
(3,  16, 'Licence Basic',   3000,  2, '2024-01-15', 'Est'),
(4,  15, 'Licence Pro',     15000, 1, '2024-02-05', 'Sud'),
(5,  16, 'Formation SQL',   5000,  1, '2024-02-12', 'Est'),
(6,  15, 'Licence Pro',     15000, 1, '2024-02-28', 'Ouest'),
(7,  14, 'Contrat Annuel',  50000, 1, '2024-03-01', 'Paris'),
(8,  15, 'Support Premium', 8000,  1, '2024-03-15', 'Sud'),
(9,  16, 'Licence Basic',   3000,  3, '2024-03-20', 'Est'),
(10, 15, 'Licence Pro',     15000, 2, '2024-04-02', 'Sud'),
(11, 16, 'Formation SQL',   5000,  2, '2024-04-18', 'Nord'),
(12, 14, 'Contrat Annuel',  50000, 1, '2024-05-10', 'Paris'),
(13, 15, 'Licence Pro',     15000, 1, '2024-05-25', 'Sud'),
(14, 16, 'Support Premium', 8000,  1, '2024-06-01', 'Est'),
(15, 15, 'Contrat Annuel',  50000, 1, '2024-06-20', 'Sud');
