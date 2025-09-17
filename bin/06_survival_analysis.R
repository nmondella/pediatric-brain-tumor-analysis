# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - ANALISI SOPRAVVIVENZA
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Analisi di sopravvivenza e confronti tra gruppi
# =============================================================================

# Carica i dati puliti
if (!exists("cleaned_data")) {
  load("../result/cleaned_data.RData")
}

cat("=== ANALISI SOPRAVVIVENZA GLOBALE ===\n")

# Statistiche Overall Survival
os_stats <- c(
  "N. Pazienti" = sum(!is.na(cleaned_data$OS)),
  "OS Media (mesi)" = round(mean(cleaned_data$OS, na.rm = TRUE), 1),
  "OS Mediana (mesi)" = round(median(cleaned_data$OS, na.rm = TRUE), 1),
  "Dev. Standard" = round(sd(cleaned_data$OS, na.rm = TRUE), 1),
  "OS Minima (mesi)" = min(cleaned_data$OS, na.rm = TRUE),
  "OS Massima (mesi)" = max(cleaned_data$OS, na.rm = TRUE),
  "Pazienti Vivi" = sum(cleaned_data$`Status OS` == 2, na.rm = TRUE),
  "Pazienti Deceduti" = sum(cleaned_data$`Status OS` == 1, na.rm = TRUE)
)

print(os_stats)

# Grafici sopravvivenza
png("../result/survival_analysis.png", width = 800, height = 600)
par(mfrow = c(1, 2))

hist(cleaned_data$OS,
     breaks = 20,
     main = "Distribuzione Overall Survival",
     xlab = "Mesi di Sopravvivenza",
     ylab = "Frequenza",
     col = "lightcyan",
     border = "black")

status_table <- table(cleaned_data$`Status OS`)
status_labels <- c("Deceduto", "Vivo")
pie(status_table,
    labels = paste(status_labels, "\n", status_table, " pazienti"),
    main = "Status di Sopravvivenza",
    col = c("red", "green"))

par(mfrow = c(1, 1))
dev.off()

# Confronto sopravvivenza tra Gliomi di Alto e Basso Grado
cat("\n=== CONFRONTO LGG vs HGG ===\n")

lgg_patients <- cleaned_data[cleaned_data$LGG == 1, ]
hgg_patients <- cleaned_data[cleaned_data$HGG == 1, ]

if(nrow(lgg_patients) > 3 && nrow(hgg_patients) > 3) {
  
  lgg_os <- lgg_patients$OS[!is.na(lgg_patients$OS)]
  hgg_os <- hgg_patients$OS[!is.na(hgg_patients$OS)]
  
  if(length(lgg_os) > 0 && length(hgg_os) > 0) {
    
    cat("Gliomi Basso Grado (LGG):\n")
    cat("  N. Pazienti:", length(lgg_os), "\n")
    cat("  OS Media:", round(mean(lgg_os), 1), "mesi\n")
    cat("  OS Mediana:", round(median(lgg_os), 1), "mesi\n")
    
    cat("Gliomi Alto Grado (HGG):\n")
    cat("  N. Pazienti:", length(hgg_os), "\n")
    cat("  OS Media:", round(mean(hgg_os), 1), "mesi\n")
    cat("  OS Mediana:", round(median(hgg_os), 1), "mesi\n")
    
    # T-test
    t_test_result <- t.test(lgg_os, hgg_os)
    
    cat("\nRISULTATI T-TEST:\n")
    cat("Statistica t:", round(t_test_result$statistic, 4), "\n")
    cat("p-value:", format(t_test_result$p.value, scientific = TRUE, digits = 3), "\n")
    cat("Significativo (p < 0.005):", ifelse(t_test_result$p.value < 0.005, "SI", "NO"), "\n")
    
    if(t_test_result$p.value < 0.005) {
      cat("Intervallo di confidenza 95%:", round(t_test_result$conf.int, 2), "\n")
    }
  }
} else {
  cat("Campioni troppo piccoli per il confronto\n")
}

# Confronto sopravvivenza per localizzazione
cat("\n=== CONFRONTO PER LOCALIZZAZIONE ===\n")

supra_patients <- cleaned_data[cleaned_data$Localisation == 1, ]
infra_patients <- cleaned_data[cleaned_data$Localisation == 2, ]

if(nrow(supra_patients) > 3 && nrow(infra_patients) > 3) {
  
  supra_os <- supra_patients$OS[!is.na(supra_patients$OS)]
  infra_os <- infra_patients$OS[!is.na(infra_patients$OS)]
  
  if(length(supra_os) > 0 && length(infra_os) > 0) {
    
    cat("Tumori Sopratentoriali:\n")
    cat("  N. Pazienti:", length(supra_os), "\n")
    cat("  OS Media:", round(mean(supra_os), 1), "mesi\n")
    cat("  OS Mediana:", round(median(supra_os), 1), "mesi\n")
    
    cat("Tumori Sottotentoriali:\n")
    cat("  N. Pazienti:", length(infra_os), "\n")
    cat("  OS Media:", round(mean(infra_os), 1), "mesi\n")
    cat("  OS Mediana:", round(median(infra_os), 1), "mesi\n")
    
    # T-test localizzazione
    t_test_location <- t.test(supra_os, infra_os)
    
    cat("\nRISULTATI T-TEST (LOCALIZZAZIONE):\n")
    cat("Statistica t:", round(t_test_location$statistic, 4), "\n")
    cat("p-value:", format(t_test_location$p.value, scientific = TRUE, digits = 3), "\n")
    cat("Significativo (p < 0.005):", ifelse(t_test_location$p.value < 0.005, "SI", "NO"), "\n")
  }
} else {
  cat("Campioni troppo piccoli per il confronto\n")
}

cat("\n[OK] Analisi sopravvivenza completata\n")