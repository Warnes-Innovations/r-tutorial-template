# 01_ingest.R
# Purpose : Load raw data files, perform structural validation, and save a
#           minimally-processed copy to 03_cleaned_data/ for cleaning.
# Inputs  : 02_raw_data/  (raw case extract and population file)
# Outputs : 03_cleaned_data/cases_raw.rds
#           03_cleaned_data/population.rds
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(haven)
library(here)
library(janitor)

devtools::load_all(here::here())

# ── 1. Load raw case data ──────────────────────────────────────────────────

# Update the filename below to match your actual raw data file.
# Supported formats:
#   CSV          : read_csv(here("02_raw_data", "cases.csv"))
#   Excel        : readxl::read_excel(here("02_raw_data", "cases.xlsx"))
#   SAS (.sas7bdat): haven::read_sas(here("02_raw_data", "cases.sas7bdat"))

cases_raw <- read_csv(
  here("02_raw_data", "cases.csv"),
  col_types = cols(
    case_id      = col_character(),
    report_date  = col_date(format = "%Y-%m-%d"),
    disease      = col_character(),
    county_fips  = col_character(),   # keep as character to preserve leading zeros
    .default     = col_guess()
  )
)

# Standardise column names (lowercase, underscores) — remove if your names are
# already clean and you want to preserve the originals.
cases_raw <- cases_raw |> clean_names()

# ── 2. Structural validation ───────────────────────────────────────────────

# Check expected columns are present
expected_cols <- c("case_id", "report_date", "disease", "county_fips")
missing_cols  <- setdiff(expected_cols, names(cases_raw))
if (length(missing_cols) > 0) {
  stop("Missing expected columns: ", paste(missing_cols, collapse = ", "))
}

# Report row count and date range
message(sprintf(
  "Loaded %d rows | report_date range: %s to %s",
  nrow(cases_raw),
  min(cases_raw$report_date, na.rm = TRUE),
  max(cases_raw$report_date, na.rm = TRUE)
))

# Check for duplicate case IDs
n_dup <- sum(duplicated(cases_raw$case_id))
if (n_dup > 0) {
  warning(sprintf("%d duplicate case_id values found — investigate before proceeding.", n_dup))
}

# ── 3. Load population denominators ───────────────────────────────────────
# Population file should have one row per county × year (or county × year × age group).
# Example: ACS 5-year estimates downloaded from the Census Bureau.

population <- read_csv(
  here("02_raw_data", "population.csv"),
  col_types = cols(
    county_fips = col_character(),
    year        = col_integer(),
    population  = col_double(),
    .default    = col_guess()
  )
)

population <- population |> clean_names()

message(sprintf("Loaded population denominators: %d rows", nrow(population)))

# ── 4. Save to 03_cleaned_data/ ──────────────────────────────────────────────

saveRDS(cases_raw,  here("03_cleaned_data", "cases_raw.rds"))
saveRDS(population, here("03_cleaned_data", "population.rds"))

message("Saved: 03_cleaned_data/cases_raw.rds")
message("Saved: 03_cleaned_data/population.rds")
