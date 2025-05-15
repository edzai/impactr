# impactr <img src="https://img.shields.io/badge/M&E-Causal--Ready-blue" alt="badge" align="right" height="25">

> Modular R package for generalized Monitoring & Evaluation (M&E) and Impact Analysis using logic models, KPIs, and causal inference.

## 📦 Installation

```r
# Install from GitHub (after public push)
remotes::install_github("edzai/impactr")

# OR install from local ZIP
install.packages("path/to/impactr.zip", repos = NULL, type = "source")
```

## 🧭 User Guide

### 1. Ingest Data

```r
library(impactr)
me_data <- ingest_data("inst/extdata/demo_data.csv")
```

---

### 2. Load and Validate Logic Model

```r
logic_model <- load_logic_model("inst/extdata/demo_model.yaml")
validate_model(logic_model)
```

---

### 3. Analyze KPIs

```r
analyse_kpis(me_data, logic_model)
```

---

### 4. Infer Causal Impact

```r
pred <- infer_impact(me_data, logic_model, method = "causalforest")
```

---

### 5. Generate Stakeholder Reports

```r
generate_report(me_data, logic_model, audience = "board")
generate_report(me_data, logic_model, audience = "public")
generate_report(me_data, logic_model, audience = "experts")
```

---

### 6. SDG Mapping and Dashboards

```r
map_to_sdgs(me_data$indicators)
launch_dashboard(me_data, logic_model)
```

---

## 🔗 Documentation

📘 Full documentation: [https://edzai.github.io/impactr](https://edzai.github.io/impactr)

---

## 🛠 Modules Included

- `ingest_data()`: Import .csv/.xlsx/Google Sheets
- `load_logic_model()`, `validate_model()`: Load and validate M&E logic models
- `analyse_kpis()`: Actual vs. target KPI analysis
- `infer_impact()`: Causal forest-based impact inference
- `generate_report()`: Generate HTML/PDF stakeholder reports
- `map_to_sdgs()`: Rule-based SDG alignment
- `launch_dashboard()`: Interactive visual summaries (Shiny/flexdashboard)

---

## 🧪 Vignettes

- Getting Started
- KPI Analysis
- Causal Inference
- Reporting Outputs
- SDG Mapping

Run:

```r
browseVignettes("impactr")
```

---

## 🌍 Contributing

Issues and PRs welcome. Please include tests and documentation with contributions.

---

## © License

MIT — see `LICENSE` file.
