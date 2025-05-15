# impactr <img src="https://img.shields.io/badge/M&E-Causal--Ready-blue" alt="badge" align="right" height="25">

> Modular R package for generalized Monitoring & Evaluation (M&E) and Impact Analysis using logic models, KPIs, SDGs, and causal inference.

## 📦 Installation

```r
remotes::install_github("edzai/impactr")
```

---

## 📘 Getting Started

```r
library(impactr)

# Load data and logic model
me_data <- ingest_data(system.file("extdata", "demo_data.csv", package = "impactr"))
logic_model <- load_logic_model(system.file("extdata", "demo_model.yaml", package = "impactr"))
validate_model(logic_model)
```

---

## 📊 KPI Analysis

Use `analyse_kpis()` to compare actual vs. target metrics, and identify performance gaps.

```r
results <- analyse_kpis(me_data, logic_model)
print(results)
```

Output columns:
- `KPI`, `Target`, `Actual`, `PercentAchieved`, `Gap`

---

## 🧠 Causal Inference

Estimate impact using causal forest from the `grf` package:

```r
pred <- infer_impact(me_data, logic_model, method = "causalforest")

# View predicted treatment effects
head(pred$predictions)
```

Note: Categorical variables are auto-encoded using `model.matrix()`.

---

## 📄 Reporting Outputs

Generate reports tailored to different stakeholder groups:

```r
generate_report(me_data, logic_model, audience = "board")
generate_report(me_data, logic_model, audience = "public")
generate_report(me_data, logic_model, audience = "experts")
```

Templates live in `inst/rmd/` and support both HTML and PDF outputs.

---

## 🌍 SDG Mapping

Link indicators to Sustainable Development Goals using rules:

```r
sdg_tags <- map_to_sdgs(me_data$indicators)
DT::datatable(sdg_tags)
```

Visualize:

```r
highcharter::hchart(table(sdg_tags$sdg), type = "column")
```

---

## 🧪 Testing

Unit tests for each module can be found in `tests/testthat/`. Run them via:

```r
devtools::test()
```

---

## 🔗 Documentation

Full site: [https://edzai.github.io/impactr](https://edzai.github.io/impactr)

---

## 📂 Core Functions

| Function | Purpose |
|----------|---------|
| `ingest_data()` | Load .csv, .xlsx, or Google Sheet |
| `load_logic_model()` | Load .yaml or .json logic model |
| `validate_model()` | Ensure required fields are present |
| `analyse_kpis()` | Compare actuals vs. targets |
| `infer_impact()` | Estimate causal effects using GRF |
| `generate_report()` | Produce HTML/PDF for audiences |
| `map_to_sdgs()` | SDG goal alignment |
| `launch_dashboard()` | (Optional) Interactive summary |

---

## 📦 CRAN & DPG Readiness

- Follows R best practices
- Roxygen2 documented
- Unit tested
- GitHub Actions compatible
- License: MIT

---

## © License

MIT — see `LICENSE` file.
