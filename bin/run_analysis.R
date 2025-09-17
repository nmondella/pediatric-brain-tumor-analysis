# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - SCRIPT PRINCIPALE
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Script master per eseguire l'intera analisi
# =============================================================================

cat("=====================================\n")
cat("ANALISI TUMORI CEREBRALI PEDIATRICI\n")
cat("Autore: Nicholas Mondella 859673\n")
cat("=====================================\n\n")

# Registra tempo di inizio
start_time <- Sys.time()

# Verifica directory di lavoro
cat("Directory di lavoro:", getwd(), "\n")

# Crea cartella result se non esiste
if (!dir.exists("../result")) {
  dir.create("../result", recursive = TRUE)
  cat("Creata cartella ../result/\n")
}

# Esegue tutti gli script in sequenza
scripts <- c(
  "01_setup_and_libraries.R",
  "02_load_data.R", 
  "03_data_cleaning.R",
  "04_exploratory_analysis.R",
  "05_statistical_analysis.R",
  "06_survival_analysis.R",
  "07_export_results.R"
)

cat("\n=== ESECUZIONE PIPELINE ANALISI ===\n")

for(i in seq_along(scripts)) {
  script_name <- scripts[i]
  cat("\n", i, "/", length(scripts), " - Eseguendo:", script_name, "\n")
  cat(paste(rep("-", 50), collapse = ""), "\n")
  
  tryCatch({
    source(script_name)
    cat("[OK] ", script_name, " completato\n")
  }, error = function(e) {
    cat("[ERRORE] in ", script_name, ": ", e$message, "\n")
    stop("Analisi interrotta a causa di errore")
  })
}

# Calcola tempo totale
end_time <- Sys.time()
total_time <- difftime(end_time, start_time, units = "mins")

cat("\n", paste(rep("=", 50), collapse = ""), "\n")
cat("ANALISI COMPLETATA CON SUCCESSO!\n")
cat("Tempo totale di esecuzione:", round(as.numeric(total_time), 2), "minuti\n")
cat("File di output salvati in: ../result/\n")
cat(paste(rep("=", 50), collapse = ""), "\n")