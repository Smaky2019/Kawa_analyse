-- 1. Création des séquences (optionnel mais propre)
CREATE SEQUENCE
IF NOT EXISTS seq_date_id START 1;
CREATE SEQUENCE
IF NOT EXISTS seq_magasin_id START 1;
CREATE SEQUENCE
IF NOT EXISTS seq_produit_id START 1;
CREATE SEQUENCE
IF NOT EXISTS seq_paiement_id START 1;

-- 2. Dimensions

-- Dim Temps
CREATE TABLE
IF NOT EXISTS dim_temps
(
    date_id      SERIAL PRIMARY KEY,
    date_vente   DATE NOT NULL UNIQUE,
    annee        INTEGER,
    mois         INTEGER,
    mois_nom     VARCHAR
(10),
    trimestre    INTEGER,
    jour_semaine VARCHAR
(10)
);

-- Dim Magasin
CREATE TABLE
IF NOT EXISTS dim_magasin
(
    magasin_id      SERIAL PRIMARY KEY,
    magasin_code    VARCHAR
(10) NOT NULL UNIQUE,
    magasin_nom     VARCHAR
(100) NOT NULL
);

-- Dim Produit
CREATE TABLE
IF NOT EXISTS dim_produit
(
    produit_id         SERIAL PRIMARY KEY,
    produit_nom        VARCHAR
(100) NOT NULL,
    categorie_produit  VARCHAR
(50) NOT NULL
);

-- Dim Paiement
CREATE TABLE
IF NOT EXISTS dim_paiement
(
    paiement_id    SERIAL PRIMARY KEY,
    mode_paiement  VARCHAR
(30) NOT NULL UNIQUE
);

-- 3. Table de faits
CREATE TABLE
IF NOT EXISTS ventes
(
    id_vente      BIGINT PRIMARY KEY,
    date_id       INTEGER REFERENCES dim_temps
(date_id),
    magasin_id    INTEGER REFERENCES dim_magasin
(magasin_id),
    produit_id    INTEGER REFERENCES dim_produit
(produit_id),
    paiement_id   INTEGER REFERENCES dim_paiement
(paiement_id),
    quantite      INTEGER NOT NULL CHECK
(quantite > 0),
    prix_unitaire NUMERIC
(10,2) NOT NULL CHECK
(prix_unitaire >= 0),
    cout_unitaire NUMERIC
(10,2) NOT NULL CHECK
(cout_unitaire >= 0),
    remise_pct    NUMERIC
(5,2) CHECK
(remise_pct BETWEEN 0 AND 100),
    CA_ligne      NUMERIC
(12,2) NOT NULL CHECK
(CA_ligne >= 0),
    marge_ligne   NUMERIC
(12,2) NOT NULL
);

-- 4. Index pour performance
CREATE INDEX
IF NOT EXISTS idx_ventes_date ON ventes
(date_id);
CREATE INDEX
IF NOT EXISTS idx_ventes_magasin ON ventes
(magasin_id);
CREATE INDEX
IF NOT EXISTS idx_ventes_produit ON ventes
(produit_id);
CREATE INDEX
IF NOT EXISTS idx_ventes_paiement ON ventes
(paiement_id);