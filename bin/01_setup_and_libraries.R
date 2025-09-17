# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - SETUP E LIBRERIE
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Setup iniziale, caricamento librerie e configurazione ambiente
# =============================================================================

# Setup generale
options(scipen = 999, digits = 4)

# Caricamento librerie necessarie
suppressPackageStartupMessages({
  library(readxl)      # Lettura file Excel
  library(dplyr)       # Manipolazione dati
  library(ggplot2)     # Visualizzazioni
  library(stats)       # Analisi statistiche
  library(utils)       # Utilità generali
  
  # Librerie opzionali (installate se disponibili)
  if(require("corrplot", quietly = TRUE)) library(corrplot)
  if(require("tidyr", quietly = TRUE)) library(tidyr)
  if(require("writexl", quietly = TRUE)) library(writexl)
})

# Configurazione theme ggplot2
theme_set(theme_minimal() + 
          theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
                plot.subtitle = element_text(hjust = 0.5, size = 12),
                axis.title = element_text(size = 11),
                axis.text = element_text(size = 9),
                legend.text = element_text(size = 9)))

# Messaggio di conferma
cat("=== SETUP COMPLETATO ===\n")
cat("Librerie caricate correttamente\n")
cat("Ambiente configurato per l'analisi dei tumori cerebrali pediatrici\n\n")