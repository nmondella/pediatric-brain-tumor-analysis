# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - CARICAMENTO DATI
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Caricamento e prima ispezione del dataset
# =============================================================================

# Caricamento dati
data_path <- "../data/data.xlsx"
cat("Caricamento dataset da:", data_path, "\n")

# Verifica esistenza file
if (!file.exists(data_path)) {
  stop("ERRORE: File non trovato: ", data_path)
}

# Caricamento dataset
raw_data <- read_excel(data_path)

# Informazioni di base sul dataset
cat("\n=== INFORMAZIONI DATASET ===\n")
cat("Dimensioni:", nrow(raw_data), "righe x", ncol(raw_data), "colonne\n")
cat("Nome colonne:\n")
print(names(raw_data))

cat("\nPrime 5 righe del dataset:\n")
print(head(raw_data, 5))

cat("\nStruttura del dataset:\n")
str(raw_data)

cat("\nRiepilogo statistico:\n")
print(summary(raw_data))

# Salva l'oggetto raw_data per gli altri script
save(raw_data, file = "../result/raw_data.RData")
cat("\n[OK] Dataset caricato e salvato in ../result/raw_data.RData\n")