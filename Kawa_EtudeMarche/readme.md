# README – Nettoyage du fichier dump_kadea.csv

1. **Dates** : Toutes les dates ont été standardisées au format `YYYY-MM-DD` (type DATE). Les formats textuels (`"14 janvier 2024"`) ont été convertis avec un parser robuste.
2. **Mode de paiement** : Normalisé en 4 catégories : `Cash`, `Carte`, `Mobile Money`, `Non spécifié`.
3. **Données manquantes** :
   - `remise_pct` : remplacé par `0` si NULL.
   - `mode_paiement` : remplacé par `"Non spécifié"` pour ~20 lignes.
4. **Doublons** : Aucun doublon détecté sur l’ensemble des champs → toutes les lignes conservées.
5. **Variables calculées ajoutées** :
   - `ca_ligne`
   - `marge_ligne`
   - `taux_marge`
   - `cout_total`
6. **Valeurs aberrantes** : Quelques lignes avec `marge < 0` conservées (à valider métier).
7. **Encodage** : Fichier sauvegardé en UTF-8, séparateur virgule, pas de caractères corrompus.