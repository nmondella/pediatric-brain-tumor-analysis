# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - ANALISI ESPLORATIVA
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Analisi esplorativa e caratteristiche demografiche
# =============================================================================

# Carica i dati puliti
if (!exists("cleaned_data")) {
  load("../result/cleaned_data.RData")
}

cat("=== ANALISI DEMOGRAFICA ===\n")

# Distribuzione per sesso
sex_table <- table(cleaned_data$Sex, useNA = "ifany")
sex_prop <- prop.table(sex_table) * 100

sex_labels <- c("Maschi", "Femmine")
names(sex_table) <- sex_labels
names(sex_prop) <- sex_labels

cat("Distribuzione per sesso:\n")
for(i in 1:length(sex_table)) {
  cat(names(sex_table)[i], ":", sex_table[i], "(", round(sex_prop[i], 1), "%)\n")
}

# Grafico distribuzione per sesso
png("../result/distribuzione_sesso.png", width = 800, height = 600)
par(mfrow = c(1, 2))

pie(sex_table, 
    main = "Distribuzione per Sesso",
    col = c("lightblue", "lightpink"),
    labels = paste(names(sex_table), "\n", round(sex_prop, 1), "%"))

barplot(sex_table,
        main = "Frequenza per Sesso",
        ylab = "Numero di Pazienti",
        col = c("lightblue", "lightpink"),
        las = 1)

par(mfrow = c(1, 1))
dev.off()

# Analisi dell'età
cat("\n=== ANALISI ETA' ===\n")
age_stats <- c(
  "N. Pazienti" = sum(!is.na(cleaned_data$Age)),
  "Media" = round(mean(cleaned_data$Age, na.rm = TRUE), 1),
  "Mediana" = round(median(cleaned_data$Age, na.rm = TRUE), 1),
  "Dev. Standard" = round(sd(cleaned_data$Age, na.rm = TRUE), 1),
  "Minimo" = min(cleaned_data$Age, na.rm = TRUE),
  "Massimo" = max(cleaned_data$Age, na.rm = TRUE),
  "Range" = max(cleaned_data$Age, na.rm = TRUE) - min(cleaned_data$Age, na.rm = TRUE)
)

print(age_stats)

# Grafico distribuzione età
png("../result/distribuzione_eta.png", width = 800, height = 600)
hist(cleaned_data$Age, 
     breaks = 20,
     main = "Distribuzione dell'Anno di Nascita dei Pazienti",
     xlab = "Anno di Nascita",
     ylab = "Frequenza",
     col = "lightsteelblue",
     border = "black")

abline(v = mean(cleaned_data$Age, na.rm = TRUE), col = "red", lwd = 2, lty = 2)
abline(v = median(cleaned_data$Age, na.rm = TRUE), col = "blue", lwd = 2, lty = 2)

legend("topright", 
       legend = c("Media", "Mediana"),
       col = c("red", "blue"),
       lty = 2, lwd = 2)
dev.off()

# Durata dei sintomi
cat("\n=== DURATA SINTOMI PRIMA DIAGNOSI ===\n")
duration_stats <- c(
  "N. Pazienti" = sum(!is.na(cleaned_data$`Duration of sympthoms before diagnosis (days)`)),
  "Media (giorni)" = round(mean(cleaned_data$`Duration of sympthoms before diagnosis (days)`, na.rm = TRUE), 1),
  "Mediana (giorni)" = round(median(cleaned_data$`Duration of sympthoms before diagnosis (days)`, na.rm = TRUE), 1),
  "Dev. Standard" = round(sd(cleaned_data$`Duration of sympthoms before diagnosis (days)`, na.rm = TRUE), 1),
  "Minimo" = min(cleaned_data$`Duration of sympthoms before diagnosis (days)`, na.rm = TRUE),
  "Massimo" = max(cleaned_data$`Duration of sympthoms before diagnosis (days)`, na.rm = TRUE),
  "Q1" = round(quantile(cleaned_data$`Duration of sympthoms before diagnosis (days)`, 0.25, na.rm = TRUE), 1),
  "Q3" = round(quantile(cleaned_data$`Duration of sympthoms before diagnosis (days)`, 0.75, na.rm = TRUE), 1)
)

print(duration_stats)

# Grafico durata sintomi
png("../result/durata_sintomi.png", width = 800, height = 600)
par(mfrow = c(1, 2))

hist(cleaned_data$`Duration of sympthoms before diagnosis (days)`,
     breaks = 30,
     main = "Distribuzione Durata Sintomi",
     xlab = "Giorni",
     ylab = "Frequenza",
     col = "lightgreen",
     border = "black")

boxplot(cleaned_data$`Duration of sympthoms before diagnosis (days)`,
        main = "Box Plot Durata Sintomi",
        ylab = "Giorni",
        col = "lightgreen",
        outline = TRUE)

par(mfrow = c(1, 1))
dev.off()

cat("\n[OK] Analisi esplorativa completata - Grafici salvati in ../result/\n")