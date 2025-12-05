# README – Nettoyage du fichier dump_kadea.csv

1. **Dates** : Standardisées en format `YYYY-MM-DD` (type DATE) via parsing multi-format (ex: "14 janvier 2024" → "2024-01-14").
2. **Mode de paiement** : Normalisé en 4 valeurs : `Cash`, `Carte`, `Mobile Money`, `Non spécifié`.
3. **Valeurs manquantes** :
   - `remise_pct` → remplacé par `0` si NULL.
   - `mode_paiement` → remplacé par `"Non spécifié"` (21 lignes, soit 0,3 %).
4. **Doublons** : Aucun doublon strict détecté → toutes les lignes conservées.
5. **Variables calculées** :
   - `ca_ligne = quantite * prix_unitaire * (1 - COALESCE(remise_pct, 0)/100)`
   - `cout_total = quantite * cout_unitaire`
   - `marge_ligne = ca_ligne - cout_total`
   - `taux_marge = marge_ligne / NULLIF(ca_ligne, 0)`
6. **Valeurs aberrantes** : 
   - ~0,8 % des lignes avec `cout_unitaire > prix_unitaire` → conservées (à valider métier).
7. **Encodage** : Fichier en UTF-8, séparateur virgule, aucune corruption.