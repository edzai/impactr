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
data <- ingest_data("data/monitoring_data.xlsx")
```

Supports `.csv`, `.xlsx`, and Google Sheets.

---

### 2. Load Logic Model

```r
logic_model <- load_logic_model("data/logic_model.yaml")
validate_model(logic_model)
```

Accepts `.yaml`, `.json`, or `data.frame`.

---

### 3. Analyze KPIs

```r
analyse_kpis(data, logic_model)
```

Returns actual vs. target, % achieved, and performance gaps.

---

### 4. Infer Causal Impact

```r
predictions <- infer_impact(data, logic_model, method = "causalforest")
```

Uses `grf::causal_forest()` to estimate treatment effects.

---

### 5. Generate Reports

```r
generate_report(data, logic_model, audience = "board")
generate_report(data, logic_model, audience = "public")
generate_report(data, logic_model, audience = "experts")
```

Auto-generates stakeholder-specific PDF/HTML reports.

---

### 6. Visual Dashboards

```r
launch_dashboard(data, logic_model)  # Shiny app
generate_flexdashboard(data, logic_model)
```

Interactive KPIs, SDG alignment, and logic model summaries.

---

### 7. SDG Mapping

```r
map_to_sdgs(data$indicators)
```

Aligns indicators to UN Sustainable Development Goals.

---

## 🔗 Documentation

📘 Full documentation: [https://edzai.github.io/impactr](https://edzai.github.io/impactr)

---

## 🛠 Dev Notes

- Modular structure
- Roxygen2 documentation
- Vignettes + pkgdown site
- CI-ready (GitHub Actions)
- MIT License

---

## 🌍 Contributing

We welcome issues, ideas, and pull requests! Please open a discussion before submitting large changes.

---

## © License

MIT — see `LICENSE` file.
