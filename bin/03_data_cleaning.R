# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - DATA CLEANING
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Pulizia e preprocessing del dataset
# =============================================================================

# Carica i dati se non già presenti
if (!exists("raw_data")) {
  load("../result/raw_data.RData")
}

cat("=== ANALISI VALORI MANCANTI ===\n")

# Analisi valori mancanti
missing_summary <- data.frame(
  Variabile = names(raw_data),
  Valori_Mancanti = sapply(raw_data, function(x) sum(is.na(x))),
  Percentuale = round(sapply(raw_data, function(x) sum(is.na(x)) / length(x) * 100), 2),
  stringsAsFactors = FALSE
)
missing_summary <- missing_summary[order(missing_summary$Percentuale, decreasing = TRUE), ]

# Mostra variabili con valori mancanti
print(missing_summary[missing_summary$Valori_Mancanti > 0, ])

# Inizia data cleaning
cleaned_data <- raw_data

# IMPORTANTE: Rimuove righe con Pat. No. mancante (identificativo essenziale)
initial_rows <- nrow(cleaned_data)
cleaned_data <- cleaned_data[!is.na(cleaned_data$`Pat. No.`), ]
removed_rows <- initial_rows - nrow(cleaned_data)
if(removed_rows > 0) {
  cat("RIMOSSI", removed_rows, "pazienti con Pat. No. mancante\n")
}

cat("\n=== STRATEGIA DI TRATTAMENTO VALORI MANCANTI ===\n")
cat("Totale pazienti nel dataset:", nrow(cleaned_data), "\n\n")

# Analizza ogni colonna per determinare la strategia di trattamento
for(col in names(cleaned_data)) {
  missing_pct <- sum(is.na(cleaned_data[[col]])) / nrow(cleaned_data) * 100
  
  if(missing_pct > 50) {
    cat("[RIMOZIONE]", col, ":", round(missing_pct, 1), "% mancanti\n")
  } else if(missing_pct > 20) {
    cat("[IMPUTAZIONE AVANZATA]", col, ":", round(missing_pct, 1), "% mancanti\n")
  } else if(missing_pct > 5) {
    cat("[IMPUTAZIONE SEMPLICE]", col, ":", round(missing_pct, 1), "% mancanti\n")
  } else if(missing_pct > 0) {
    cat("[GESTIONE SPECIFICA]", col, ":", round(missing_pct, 1), "% mancanti\n")
  }
}

# Rimozione variabili con troppi valori mancanti (>50%)
high_missing_vars <- missing_summary$Variabile[missing_summary$Percentuale > 50]
if(length(high_missing_vars) > 0) {
  cleaned_data <- cleaned_data[, !names(cleaned_data) %in% high_missing_vars]
  cat("\nVariabili rimosse:", paste(high_missing_vars, collapse = ", "), "\n")
} else {
  cat("\nNessuna variabile rimossa per eccesso di valori mancanti\n")
}

# Imputazione per variabili numeriche
cat("\n=== IMPUTAZIONE VARIABILI NUMERICHE ===\n")
numeric_vars_clean <- cleaned_data[sapply(cleaned_data, is.numeric)]

# IMPORTANTE: Esclude Pat. No. dall'imputazione (è solo identificativo, non deve essere modificato)
numeric_vars_clean <- numeric_vars_clean[, !names(numeric_vars_clean) %in% c("Pat. No.")]
cat("NOTA: Pat. No. è escluso dall'imputazione (solo identificativo)\n\n")

if(ncol(numeric_vars_clean) > 0) {
  for(col in names(numeric_vars_clean)) {
    if(sum(is.na(cleaned_data[[col]])) > 0) {
      median_val <- median(cleaned_data[[col]], na.rm = TRUE)
      n_imputed <- sum(is.na(cleaned_data[[col]]))
      cleaned_data[[col]][is.na(cleaned_data[[col]])] <- median_val
      cat("[OK] Imputata mediana per", col, ":", median_val, "(", n_imputed, "valori)\n")
    }
  }
}

# Gestione outliers con approccio clinico
cat("\n=== TRATTAMENTO OUTLIERS ===\n")
numeric_vars_final <- cleaned_data[sapply(cleaned_data, is.numeric)]

# IMPORTANTE: Esclude Pat. No. dal trattamento outliers (è solo identificativo)
numeric_vars_final <- numeric_vars_final[, !names(numeric_vars_final) %in% c("Pat. No.")]
cat("NOTA: Pat. No. è escluso dal trattamento outliers (solo identificativo)\n\n")

if(ncol(numeric_vars_final) > 0) {
  outliers_treated <- cleaned_data
  
  for(col in names(numeric_vars_final)) {
    p5 <- quantile(cleaned_data[[col]], 0.05, na.rm = TRUE)
    p95 <- quantile(cleaned_data[[col]], 0.95, na.rm = TRUE)
    
    outliers_before <- sum(cleaned_data[[col]] < p5 | cleaned_data[[col]] > p95, na.rm = TRUE)
    
    outliers_treated[[col]] <- pmax(pmin(cleaned_data[[col]], p95), p5)
    
    if(outliers_before > 0) {
      cat("[OUTLIERS] Outliers trattati per", col, ":", outliers_before, "valori\n")
    }
  }
  
  cleaned_data <- outliers_treated
}

cat("\n[DATASET FINALE]", nrow(cleaned_data), "pazienti x", ncol(cleaned_data), "variabili\n")

# Salva il dataset pulito
save(cleaned_data, file = "../result/cleaned_data.RData")
cat("[OK] Dataset pulito salvato in ../result/cleaned_data.RData\n")