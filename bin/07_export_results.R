# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - EXPORT RISULTATI
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Esportazione dataset pulito e salvataggio risultati
# =============================================================================

# Carica i dati puliti
if (!exists("cleaned_data")) {
  load("../result/cleaned_data.RData")
}

cat("=== EXPORT DATASET PULITO ===\n")

# Salva dataset pulito in formato CSV
output_path_csv <- "../result/dataset_pulito.csv"
write.csv(cleaned_data, output_path_csv, row.names = FALSE)
cat("[OK] Dataset pulito salvato in CSV:", output_path_csv, "\n")

# Salva dataset pulito in formato Excel se disponibile
if(require("writexl", quietly = TRUE)) {
  output_path_excel <- "../result/dataset_pulito.xlsx"
  writexl::write_xlsx(cleaned_data, output_path_excel)
  cat("[OK] Dataset pulito salvato in Excel:", output_path_excel, "\n")
}

# Statistiche finali
cat("\n=== STATISTICHE FINALI ===\n")
cat("Pazienti totali:", nrow(cleaned_data), "\n")
cat("Variabili totali:", ncol(cleaned_data), "\n")
cat("Valori mancanti rimanenti:", sum(is.na(cleaned_data)), "\n")
cat("Pazienti con OS completa:", sum(!is.na(cleaned_data$OS)), "\n")
cat("Follow-up mediano (mesi):", round(median(cleaned_data$OS, na.rm = TRUE), 1), "\n")

# Riepilogo variabili del dataset finale
cat("\nVariabili nel dataset finale:\n")
for(i in seq_along(names(cleaned_data))) {
  cat(sprintf("%2d. %s\n", i, names(cleaned_data)[i]))
}

# Verifica integrità dati
cat("\n=== VERIFICA INTEGRITA' DATI ===\n")
cat("Duplicati per Pat. No.:", sum(duplicated(cleaned_data$`Pat. No.`)), "\n")
cat("Range età (anni nascita):", min(cleaned_data$Age, na.rm = TRUE), "-", max(cleaned_data$Age, na.rm = TRUE), "\n")
cat("Range OS (mesi):", min(cleaned_data$OS, na.rm = TRUE), "-", max(cleaned_data$OS, na.rm = TRUE), "\n")

# Lista dei file generati
cat("\n=== FILE GENERATI ===\n")
result_files <- list.files("../result/", pattern = "\\.(csv|xlsx|png|RData)$", full.names = FALSE)
if(length(result_files) > 0) {
  for(file in result_files) {
    cat("- ../result/", file, "\n")
  }
} else {
  cat("Nessun file trovato nella cartella result/\n")
}

cat("\n[OK] Export completato con successo!\n")