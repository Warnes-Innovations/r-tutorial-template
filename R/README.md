# R/

Reusable R functions used across multiple scripts in this project.

## R/ vs scripts/: what's the difference?

| `R/`  | `scripts/` |
|-------|-----------|
| **Functions** — reusable building blocks | **Scripts** — one-time analysis steps |
| Loaded once per session via `devtools::load_all()` | Run in numbered order to produce outputs |
| No side effects (doesn't read/write files) | Reads inputs, writes outputs |
| Short, focused, well-named | Longer; tells the story of the analysis |

A good rule of thumb: if you find yourself copying and pasting the same block of code
into two different scripts, extract it into a function here.

## File Organization

Each file is named after its primary function:

| File | Function(s) | Purpose |
|------|-------------|---------|
| `calc_rate.R` | `calc_rate()` | Incidence rate calculation |
| `suppress_counts.R` | `suppress_counts()` | Small-count suppression for data privacy |
| `age_group_std.R` | `age_group_std()` | Standard CDC age group categorization |
| `to_epiweek.R` | `to_epiweek()`, `to_epiyear()` | Epidemiological week extraction |
| `fmt_ci.R` | `fmt_ci()` | Confidence interval formatting |
| `missing_summary.R` | `missing_summary()` | Data validation: missing value summary |
| `utils.R` | (none) | Orchestrator file; loaded by `devtools::load_all()` |

## How to use these functions

Each script in `scripts/` loads project functions explicitly at the top:

```r
library(tidyverse)
library(here)

# Load all functions from R/*.R
devtools::load_all(here::here())

# Now call functions directly in your analysis:
df <- df |>
  mutate(
    rate    = calc_rate(n_cases, population),
    age_grp = age_group_std(age)
  )
```

This pattern makes it explicit when and where functions are loaded, and works 
consistently whether you're running scripts interactively in RStudio or in 
non-interactive environments.
