# Pediatric Brain Tumor Analysis

Complete R workflow for medical dataset analysis featuring advanced data cleaning, exploratory analysis & clinical interpretation. This project provides both standalone R scripts and R Markdown notebooks for comprehensive analysis of pediatric brain tumor datasets.

## 📋 Project Overview

This repository contains a comprehensive statistical analysis pipeline for pediatric brain tumor datasets, including:

- **Data cleaning and preprocessing** with clinical validation
- **Exploratory data analysis** with demographic insights  
- **Advanced statistical analysis** including correlation matrices and survival analysis
- **Automated report generation** in PDF/HTML formats
- **Reproducible research** with documented methodology

## 📁 Repository Structure

```
pediatric-brain-tumor-analysis/
├── README.md                 # This file
├── data/
│   └── data.xlsx            # Raw dataset (Excel format)
├── bin/                     # R scripts and analysis code
│   ├── run_analysis.R       # Master script (run this first)
│   ├── 01_setup_and_libraries.R
│   ├── 02_load_data.R
│   ├── 03_data_cleaning.R
│   ├── 04_exploratory_analysis.R
│   ├── 05_statistical_analysis.R
│   ├── 06_survival_analysis.R
│   ├── 07_export_results.R
│   └── data_analysis.Rmd    # R Markdown notebook (alternative)
└── result/                  # Generated outputs
    ├── dataset_pulito.csv   # Cleaned dataset
    ├── *.png               # Generated plots
    ├── *.RData             # R objects
    └── correlazioni_significative.csv
```

## 🚀 Quick Start

### Prerequisites

Make sure you have R (≥ 4.0) installed with the following packages:

```r
# Required packages
install.packages(c(
  "readxl",      # Excel file reading
  "dplyr",       # Data manipulation
  "ggplot2",     # Visualization
  "corrplot",    # Correlation plots (optional)
  "tidyr",       # Data reshaping (optional)
  "writexl",     # Excel export (optional)
  "rmarkdown",   # For R Markdown reports (optional)
  "knitr"        # For R Markdown reports (optional)
))
```

### Method 1: Run Complete Analysis (Recommended)

```bash
# Clone the repository
git clone https://github.com/nmondella/pediatric-brain-tumor-analysis.git
cd pediatric-brain-tumor-analysis

# Navigate to bin directory and run the complete analysis
cd bin
Rscript run_analysis.R
```

### Method 2: Step-by-Step Execution

```bash
cd bin

# Run individual scripts in sequence
Rscript 01_setup_and_libraries.R
Rscript 02_load_data.R
Rscript 03_data_cleaning.R
Rscript 04_exploratory_analysis.R
Rscript 05_statistical_analysis.R
Rscript 06_survival_analysis.R
Rscript 07_export_results.R
```

### Method 3: R Markdown Notebook

For an interactive analysis with detailed explanations:

```r
# Open R/RStudio and navigate to the project directory
setwd("path/to/pediatric-brain-tumor-analysis/bin")

# Render the R Markdown report
rmarkdown::render("data_analysis.Rmd")
```

## 📊 Analysis Components

### 1. Data Cleaning (`03_data_cleaning.R`)
- **Missing data analysis** with clinical interpretation
- **Outlier detection** using percentile-based approach (5th-95th percentiles)
- **Data validation** ensuring clinical consistency
- **Note**: Patient number (`Pat. No.`) is excluded from statistical normalizations and used only as identifier

### 2. Exploratory Analysis (`04_exploratory_analysis.R`)
- **Demographic distributions** (sex, age, symptom duration)
- **Clinical presentation patterns** (ICP, seizures, neurological deficits)
- **Tumor characteristics** by histotype and location
- **Treatment approaches** (surgery, radiotherapy, chemotherapy)

### 3. Statistical Analysis (`05_statistical_analysis.R`)
- **Correlation analysis** with significance testing (p < 0.005)
- **Multiple comparison corrections** for robust findings
- **Clinical variable associations** with prognostic implications

### 4. Survival Analysis (`06_survival_analysis.R`)
- **Overall survival statistics** with median follow-up
- **Histotype comparisons** (Low-grade vs High-grade gliomas)
- **Location-based analysis** (Supratentorial vs Infratentorial)
- **Statistical significance testing** with clinical interpretation

## 📈 Generated Outputs

The analysis generates the following files in the `result/` directory:

### Data Files
- `dataset_pulito.csv` - Cleaned dataset ready for analysis
- `correlazioni_significative.csv` - Statistically significant correlations
- Various `.RData` files for intermediate results

### Visualizations
- `distribuzione_sesso.png` - Sex distribution analysis
- `distribuzione_eta.png` - Age distribution with statistics
- `durata_sintomi.png` - Symptom duration analysis
- `correlation_matrix.png` - Correlation heatmap
- `survival_analysis.png` - Survival distribution plots

### Reports
- `data_analysis.pdf` - Comprehensive analysis report (from R Markdown)

## 🔬 Key Statistical Findings

The analysis implements rigorous statistical methodology:

- **Significance threshold**: p < 0.005 (conservative approach)
- **Missing data strategy**: Clinical context-informed imputation
- **Outlier treatment**: Percentile-based winsorization (5%-95%)
- **Survival analysis**: Comparative testing between tumor subtypes

## 📋 Data Quality Notes

- **Patient identifiers** (`Pat. No.`) are preserved but excluded from statistical normalizations
- **Missing data patterns** are analyzed for clinical relevance before imputation
- **Outlier detection** uses medically appropriate thresholds
- **Data integrity checks** ensure consistency across clinical variables

## 🛠 Troubleshooting

### Common Issues

1. **Missing packages**: Install required packages using the code above
2. **File paths**: Ensure you're running scripts from the `bin/` directory
3. **Memory issues**: Large datasets may require increased R memory limits
4. **Excel file reading**: Verify that `data.xlsx` is in the correct format

### R Session Information

To check your R setup:
```r
sessionInfo()
R.version
```

### Package Installation Issues

If you encounter package installation problems:
```r
# Try installing from different repository
install.packages("package_name", repos = "https://cloud.r-project.org/")

# For compilation issues on macOS/Linux
install.packages("package_name", type = "binary")
```

## 📖 Methodology

This analysis follows best practices for medical data analysis:

1. **Clinical validation** of all preprocessing steps
2. **Transparent methodology** with documented decisions
3. **Reproducible pipeline** with version control
4. **Conservative statistics** to minimize false positives
5. **Clinical interpretation** of all significant findings

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes with appropriate documentation
4. Submit a pull request with detailed description

## 📄 License

This project is available for academic and research purposes. Please cite appropriately if used in publications.

## 📧 Contact

For questions or collaborations:
- Author: Nicholas Mondella
- Student ID: 859673
- Institution: [Your Institution Name]

---

**Note**: This analysis pipeline can be adapted for other pediatric tumor datasets by modifying the variable names and clinical interpretations in the respective scripts.

## Autore
**Nicholas Mondella 859673**

## Descrizione del Progetto

Questo progetto presenta un'analisi completa di un dataset clinico contenente informazioni su **174 pazienti pediatrici** affetti da tumori cerebrali. L'analisi include:

- **Data Cleaning**: Identificazione e correzione di problematiche nei dati
- **Analisi Esplorativa**: Caratteristiche demografiche e cliniche
- **Analisi Statistica**: Correlazioni significative (p < 0.005)
- **Analisi di Sopravvivenza**: Overall survival e confronti tra gruppi
- **Interpretazione Clinica**: Insights per supportare decisioni mediche

## Struttura del Repository

```
pediatric-brain-tumor-analysis/
├── README.md                          # Questo file
├── data/
│   └── data.xlsx                      # Dataset originale
├── bin/                               # Codice R eseguibile
│   ├── run_analysis.R                 # Script principale per eseguire tutto
│   ├── 01_setup_and_libraries.R      # Setup e caricamento librerie
│   ├── 02_load_data.R                 # Caricamento dati
│   ├── 03_data_cleaning.R             # Pulizia e preprocessing
│   ├── 04_exploratory_analysis.R     # Analisi esplorativa
│   ├── 05_statistical_analysis.R     # Analisi statistiche e correlazioni
│   ├── 06_survival_analysis.R        # Analisi sopravvivenza
│   ├── 07_export_results.R           # Export risultati finali
│   └── data_analysis.Rmd              # Report R Markdown (opzionale)
└── result/                            # Output dell'analisi
    ├── dataset_pulito.csv             # Dataset dopo data cleaning
    ├── dataset_pulito.xlsx            # Dataset pulito in formato Excel
    ├── correlazioni_significative.csv # Correlazioni statisticamente significative
    ├── *.png                          # Grafici generati
    ├── *.RData                        # Oggetti R salvati
    └── analisi_tumore_cerebrali.pdf   # Report finale (se generato da Rmd)
```

## Requisiti del Sistema

### Software Necessario
- **R** (versione 4.0 o superiore)
- **RStudio** (consigliato per sviluppo)
- **Pandoc** (per generazione PDF da R Markdown)
- **LaTeX** (per output PDF di alta qualità)

### Pacchetti R Richiesti

#### Pacchetti Essenziali
```r
install.packages(c(
  "readxl",      # Lettura file Excel
  "dplyr",       # Manipolazione dati
  "ggplot2",     # Visualizzazioni
  "stats",       # Analisi statistiche di base
  "utils"        # Utilità generali
))
```

#### Pacchetti Opzionali (ma raccomandati)
```r
install.packages(c(
  "corrplot",    # Visualizzazione matrici di correlazione
  "tidyr",       # Riorganizzazione dati
  "writexl",     # Scrittura file Excel
  "knitr",       # Per R Markdown
  "rmarkdown"    # Per generazione report
))
```

## Come Eseguire l'Analisi

### Metodo 1: Esecuzione Completa (Raccomandato)

1. **Clona il repository** o scarica i file
```bash
git clone https://github.com/nmondella/pediatric-brain-tumor-analysis.git
cd pediatric-brain-tumor-analysis
```

2. **Apri R o RStudio** e imposta la directory di lavoro:
```r
setwd("path/to/pediatric-brain-tumor-analysis/bin")
```

3. **Esegui lo script principale**:
```r
source("run_analysis.R")
```

Questo script eseguirà automaticamente tutti i passaggi dell'analisi in sequenza.

### Metodo 2: Esecuzione Step-by-Step

Per eseguire i singoli moduli:

```r
# 1. Setup
source("01_setup_and_libraries.R")

# 2. Caricamento dati
source("02_load_data.R")

# 3. Data cleaning
source("03_data_cleaning.R")

# 4. Analisi esplorativa
source("04_exploratory_analysis.R")

# 5. Analisi statistiche
source("05_statistical_analysis.R")

# 6. Analisi sopravvivenza
source("06_survival_analysis.R")

# 7. Export risultati
source("07_export_results.R")
```

### Metodo 3: Generazione Report PDF

Per generare il report completo in PDF:

```r
# Da R/RStudio, nella cartella bin/
rmarkdown::render("data_analysis.Rmd")
```

Oppure da terminale:
```bash
cd bin
Rscript -e "rmarkdown::render('data_analysis.Rmd')"
```

## Output Generati

Dopo l'esecuzione, troverai nella cartella `result/`:

### Dataset
- `dataset_pulito.csv` - Dataset dopo data cleaning
- `dataset_pulito.xlsx` - Stesso dataset in formato Excel

### Analisi Statistiche
- `correlazioni_significative.csv` - Correlazioni con p < 0.005
- `correlation_matrix.RData` - Matrice di correlazione

### Visualizzazioni
- `distribuzione_sesso.png` - Grafici distribuzione per sesso
- `distribuzione_eta.png` - Distribuzione età pazienti  
- `durata_sintomi.png` - Analisi durata sintomi
- `survival_analysis.png` - Grafici analisi sopravvivenza
- `correlation_matrix.png` - Matrice di correlazione visualizzata

### Report (se generato)
- `analisi_tumore_cerebrali.pdf` - Report completo con interpretazione clinica

## Caratteristiche dell'Analisi

### Data Quality
- **Gestione valori mancanti** con strategie clinicamente informate
- **Trattamento outliers** utilizzando percentili (5°-95°)
- **Validazione integrità** dei dati medici

### Analisi Statistiche
- **Soglia rigorosa** p < 0.005 per significatività
- **Test t** per confronti tra gruppi (LGG vs HGG)
- **ANOVA** per confronti multipli tra istotipi
- **Analisi correlazioni** con test di significatività

### Visualizzazioni
- Grafici di **distribuzione demografica**
- **Box plots** e istogrammi per variabili continue
- **Matrice di correlazione** colorata
- Grafici di **sopravvivenza** per gruppi

## Interpretazione Clinica

Il progetto include interpretazioni cliniche dettagliate per:
- **Fattori prognostici** identificati
- **Correlazioni clinicamente rilevanti**
- **Differenze tra istotipi** tumorali
- **Implicazioni terapeutiche** dei risultati

## Troubleshooting

### Problemi Comuni

1. **Errore "Pacchetto non trovato"**:
```r
# Installa pacchetti mancanti
install.packages("nome_pacchetto")
```

2. **Errore path file**:
```r
# Verifica directory di lavoro
getwd()
# Imposta directory corretta
setwd("path/corretto/bin")
```

3. **Errore generazione PDF**:
```r
# Installa tinytex per LaTeX
install.packages("tinytex")
tinytex::install_tinytex()
```

### Supporto

Per problemi o domande:
- Controlla che tutti i pacchetti siano installati
- Verifica che il file `data.xlsx` sia presente in `../data/`
- Assicurati di essere nella cartella `bin/` quando esegui gli script

## Licenza

Questo progetto è destinato all'uso accademico e di ricerca. Per utilizzi commerciali, contattare l'autore.

---

**Nota**: Questo progetto analizza dati medici sensibili. Assicurarsi di rispettare tutte le normative sulla privacy e protezione dei dati applicable.
