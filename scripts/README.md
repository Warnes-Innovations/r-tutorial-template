# scripts/

Numbered analysis scripts. Run them **in order** to reproduce the full analysis.

| Script | Purpose | Reads from | Writes to |
|--------|---------|-----------|----------|
| `00_packages.R`  | Install and attach all required packages | — | — |
| `01_ingest.R`    | Load raw data; validate structure and key fields | `02_raw_data/` | `03_cleaned_data/` |
| `02_clean.R`     | Recode variables; handle missing values; derive dates | `03_cleaned_data/` | `03_cleaned_data/` |
| `03_analyse.R`   | Compute counts, rates, proportions, summary tables | `03_cleaned_data/` | `04_output_data/` |
| `04_visualise.R` | Produce epidemic curve, age–sex pyramid, and other figures | `03_cleaned_data/`, `04_output_data/` | `05_output_figures/` |
| `05_report.qmd`  | Parameterised Quarto report; assembles narrative + outputs | `04_output_data/`, `05_output_figures/` | `06_output_docs/` |

## Running scripts

Open this project in RStudio (double-click the `.Rproj` file), then run each script
from the console with `source()` or by opening it and pressing **Ctrl+Shift+Enter**:

```r
source(here::here("scripts", "01_ingest.R"))
source(here::here("scripts", "02_clean.R"))
source(here::here("scripts", "03_analyse.R"))
source(here::here("scripts", "04_visualise.R"))
quarto::quarto_render(here::here("scripts", "05_report.qmd"))
```

## Script conventions

- Each script starts with a comment block describing its purpose, inputs, and outputs.
- **Each script declares its own package dependencies** at the top using `library()` calls.
  This makes dependencies explicit and visible.
- **Each script loads project functions** with `devtools::load_all(here::here())` 
  immediately after the `library()` calls. This ensures all functions in `R/*.R` 
  are available in the script's namespace, regardless of the current working directory.
- Use `here::here()` for all file paths — never hardcode paths like `C:/Users/...`.
- Save outputs explicitly; do not rely on the RStudio environment being present.
