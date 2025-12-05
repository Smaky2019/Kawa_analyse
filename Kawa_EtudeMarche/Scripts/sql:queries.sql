-- 1. CA total par magasin pour le dernier mois disponible
WITH derniers_mois AS (
    SELECT MAX(EXTRACT(YEAR FROM date_vente) * 100 + EXTRACT(MONTH FROM date_vente)) AS yyyymm
    FROM ventes_nettoyees
)
SELECT 
    magasin_nom,
    ROUND(SUM(ca_ligne), 2) AS ca_total
FROM ventes_nettoyees v
JOIN derniers_mois d
  ON EXTRACT(YEAR FROM v.date_vente) * 100 + EXTRACT(MONTH FROM v.date_vente) = d.yyyymm
GROUP BY magasin_nom
ORDER BY ca_total DESC;

-- 2. Top 3 catégories en volume de ventes (quantité) sur les 3 derniers mois complets
SELECT 
    categorie_produit,
    SUM(quantite) AS volume_total
FROM ventes_nettoyees
WHERE date_vente >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '3 months')
GROUP BY categorie_produit
ORDER BY volume_total DESC
LIMIT 3;

-- 3. Marge moyenne (en valeur absolue) par magasin et catégorie
SELECT
    magasin_nom,
    categorie_produit,
    ROUND(AVG(marge_ligne / NULLIF(quantite, 0)), 2) AS marge_moyenne_par_vente,
    ROUND(SUM(marge_ligne), 2) AS marge_totale
FROM ventes_nettoyees
GROUP BY magasin_nom, categorie_produit
ORDER BY magasin_nom, marge_totale DESC;

-- 4. Évolution du CA par mois (derniers 12 mois ou max disponible)
SELECT
    DATE_TRUNC('month', date_vente)::DATE AS mois,
    ROUND(SUM(ca_ligne), 2) AS ca_mensuel
FROM ventes_nettoyees
WHERE date_vente >= (SELECT MAX(date_vente) - INTERVAL '12 months' FROM ventes_nettoyees)
GROUP BY mois
ORDER BY mois;

-- 5. (Optionnel) Part de chaque mode de paiement dans le CA total
SELECT
    mode_paiement,
    ROUND(SUM(ca_ligne), 2) AS ca_mode,
    ROUND(SUM(ca_ligne) * 100.0 / (SELECT SUM(ca_ligne) FROM ventes_nettoyees), 2) AS part_pct
FROM ventes_nettoyees
GROUP BY mode_paiement
ORDER BY ca_mode DESC;