-- Dimension : temps
CREATE TABLE dim_temps (
    date_id DATE PRIMARY KEY,
    annee INT,
    mois INT,
    jour INT,
    mois_nom VARCHAR(10),
    trimestre INT,
    semaine INT
);

-- Dimension : magasin
CREATE TABLE dim_magasin (
    code_magasin CHAR(3) PRIMARY KEY,
    nom_magasin VARCHAR(100)
);

-- Dimension : produit
CREATE TABLE dim_produit (
    produit_id SERIAL PRIMARY KEY,
    nom_produit VARCHAR(100),
    categorie VARCHAR(50)
);

-- Dimension : mode de paiement
CREATE TABLE dim_mode_paiement (
    mode_paiement_id SERIAL PRIMARY KEY,
    mode_paiement_norm VARCHAR(30) UNIQUE
);

-- Table de faits : ventes
CREATE TABLE fait_ventes (
    vente_id SERIAL PRIMARY KEY,
    date_id DATE REFERENCES dim_temps(date_id),
    code_magasin CHAR(3) REFERENCES dim_magasin(code_magasin),
    produit_id INT REFERENCES dim_produit(produit_id),
    mode_paiement_id INT REFERENCES dim_mode_paiement(mode_paiement_id),
    quantite INT,
    prix_unitaire DECIMAL(10,2),
    cout_unitaire DECIMAL(10,2),
    remise_pct DECIMAL(5,2), -- en %, NULL = 0
    type_client VARCHAR(20)
);
