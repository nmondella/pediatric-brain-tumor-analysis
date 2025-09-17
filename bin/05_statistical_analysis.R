# =============================================================================
# ANALISI TUMORI CEREBRALI PEDIATRICI - ANALISI STATISTICA
# =============================================================================
# Autore: Nicholas Mondella 859673
# Descrizione: Analisi statistiche, correlazioni e test di significatività
# =============================================================================

# Carica i dati puliti
if (!exists("cleaned_data")) {
  load("../result/cleaned_data.RData")
}

cat("=== ANALISI CORRELAZIONI ===\n")

# Prepara variabili numeriche per analisi correlazioni
numeric_vars_final <- cleaned_data[sapply(cleaned_data, is.numeric)]
# IMPORTANTE: Esclude Pat. No. dalle correlazioni (è solo un identificativo, NON deve essere normalizzato)
numeric_vars_final <- numeric_vars_final[, !names(numeric_vars_final) %in% c("Pat. No.")]

cat("Variabili incluse nell'analisi di correlazione:\n")
cat("NOTA: Pat. No. è escluso dall'analisi (solo identificativo)\n\n")
for(i in seq_along(names(numeric_vars_final))) {
  cat(i, ".", names(numeric_vars_final)[i], "\n")
}

# Calcola matrice di correlazione
cor_matrix <- cor(numeric_vars_final, use = "complete.obs")

# Visualizzazione matrice di correlazione
png("../result/correlation_matrix.png", width = 1000, height = 800)
if(require("corrplot", quietly = TRUE) && !any(is.na(cor_matrix)) && nrow(cor_matrix) > 1) {
  corrplot(cor_matrix, 
           method = "color",
           type = "upper",
           order = "original",
           tl.cex = 0.7,
           tl.col = "black",
           tl.srt = 45,
           addCoef.col = "black",
           number.cex = 0.6,
           title = "Matrice di Correlazione delle Variabili Numeriche",
           mar = c(0,0,1,0))
} else {
  image(1:nrow(cor_matrix), 1:ncol(cor_matrix), cor_matrix,
        main = "Matrice di Correlazione",
        xlab = "", ylab = "",
        axes = FALSE,
        col = heat.colors(20))
  axis(1, at = 1:nrow(cor_matrix), labels = rownames(cor_matrix), las = 2, cex.axis = 0.7)
  axis(2, at = 1:ncol(cor_matrix), labels = colnames(cor_matrix), las = 2, cex.axis = 0.7)
}
dev.off()

# Test di significatività delle correlazioni (p < 0.005)
cat("\n=== TEST SIGNIFICATIVITA' CORRELAZIONI (p < 0.005) ===\n")
significant_correlations <- data.frame()

for(i in 1:(ncol(numeric_vars_final)-1)) {
  for(j in (i+1):ncol(numeric_vars_final)) {
    var1 <- names(numeric_vars_final)[i]
    var2 <- names(numeric_vars_final)[j]
    
    tryCatch({
      test_result <- cor.test(numeric_vars_final[[i]], numeric_vars_final[[j]])
      
      if(!is.na(test_result$estimate) && !is.na(test_result$p.value)) {
        result_row <- data.frame(
          Variabile_1 = var1,
          Variabile_2 = var2,
          Correlazione = round(test_result$estimate, 4),
          p_value = test_result$p.value,
          Significativa = ifelse(test_result$p.value < 0.005, "SI", "NO"),
          stringsAsFactors = FALSE
        )
        significant_correlations <- rbind(significant_correlations, result_row)
      }
    }, error = function(e) {})
  }
}

if(nrow(significant_correlations) > 0) {
  sig_corr_005 <- significant_correlations[significant_correlations$Significativa == "SI", ]
  
  if(nrow(sig_corr_005) > 0) {
    sig_corr_005 <- sig_corr_005[order(abs(as.numeric(sig_corr_005$Correlazione)), decreasing = TRUE), ]
    
    cat("CORRELAZIONI SIGNIFICATIVE TROVATE:\n")
    print(sig_corr_005)
    
    # Salva correlazioni significative
    write.csv(sig_corr_005, "../result/correlazioni_significative.csv", row.names = FALSE)
  } else {
    cat("NESSUNA correlazione statisticamente significativa trovata con p < 0.005\n")
  }
} else {
  cat("IMPOSSIBILE calcolare correlazioni significative\n")
}

# Salva matrice di correlazione
save(cor_matrix, file = "../result/correlation_matrix.RData")
cat("\n[OK] Analisi correlazioni completata\n")