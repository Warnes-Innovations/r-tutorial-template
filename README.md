# [Project Name]

**Disease / Program:** [e.g., Gonorrhea | HIV | Early Syphilis | Chlamydia]  
**Jurisdiction:** [e.g., State Health Department — Division of STD Prevention]  
**Analyst:** [Name]  
**Created:** [YYYY-MM-DD]  
**Last updated:** [YYYY-MM-DD]

---

## Purpose

[One paragraph describing the purpose of this analysis. What question does it answer?
What decision or report will it inform?]

## Data Sources

| Source | File | Date Received | Notes |
|--------|------|---------------|-------|
| [e.g., NNDSS extract] | `02_raw_data/nndss_2024.csv` | [YYYY-MM-DD] | Annual case data |
| [e.g., Census population] | `02_raw_data/pop_2024.csv`   | [YYYY-MM-DD] | ACS 5-year estimates |

## How to Run

Ensure you have R ≥ 4.4 installed. This project uses `{renv}` for reproducible 
package management — see "Setup" below.

**Run scripts in numbered order** from the project root (i.e., with this `.Rproj` file open in RStudio):

| Script | Purpose |
|--------|---------|
| `scripts/01_ingest.R`    | Read raw data; validate; save to `03_cleaned_data/` |
| `scripts/02_clean.R`     | Recode variables; handle missing values; apply date logic |
| `scripts/03_analyse.R`   | Compute rates, proportions, and summary tables |
| `scripts/04_visualise.R` | Produce figures; save to `05_output_figures/` |
| `scripts/05_report.qmd`  | Render final report to `06_output_docs/` |

```r
# Run from the R console (project must be open):
source(here::here("scripts", "01_ingest.R"))
source(here::here("scripts", "02_clean.R"))
# ... etc
```

## Setup

This project uses `{renv}` to manage package versions reproducibly.

**First time on this machine:**
```r
renv::init()
```

**Cloning an existing project:**
```r
renv::restore()
```

After setup, all project functions (in `R/`) are automatically available when you 
open the `.Rproj` file. Individual scripts declare their package dependencies with 
`library()` calls.

## Directory Structure

```
project_name/
├── project_name.Rproj       ← open this first
├── README.md
├── TODO.md
├── 01_documents/            ← protocols, data dictionaries, background
├── 02_raw_data/             ← source data — NEVER MODIFY
├── 03_cleaned_data/           ← cleaned data ready for analysis
├── 04_output_data/          ← summary tables and intermediate results
├── 05_output_figures/       ← saved plots and maps
├── 06_output_docs/          ← rendered reports (HTML, Word, PDF)
├── R/                       ← reusable helper functions (sourced by scripts)
└── scripts/                 ← numbered analysis scripts and report template
```

## Notes

[Important caveats, known data quality issues, suppression decisions, or
methodological choices made during this analysis.]
