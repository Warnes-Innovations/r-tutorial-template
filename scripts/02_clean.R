# 02_clean.R
# Purpose : Recode and clean the raw case data. Derive new variables needed for
#           analysis (age groups, epiweeks, race/ethnicity categories).
# Inputs  : 03_cleaned_data/cases_raw.rds
# Outputs : 03_cleaned_data/cases_clean.rds
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(lubridate)
library(here)

devtools::load_all(here::here())

# ── 1. Load data ───────────────────────────────────────────────────────────

cases <- readRDS(here("03_cleaned_data", "cases_raw.rds"))

# ── 2. Inspect missingness ─────────────────────────────────────────────────
# Review this output and document any meaningful missingness in
# 01_documents/data_dictionary_template.md before proceeding.

missing_summary(cases)

# ── 3. Recode sex ──────────────────────────────────────────────────────────
# Adjust the values below to match your data's coding.

cases <- cases |>
  mutate(
    sex = case_when(
      sex %in% c("M", "Male", "1")   ~ "Male",
      sex %in% c("F", "Female", "2") ~ "Female",
      TRUE                            ~ NA_character_
    ),
    sex = factor(sex, levels = c("Male", "Female"))
  )

# ── 4. Recode race/ethnicity ──────────────────────────────────────────────
# Collapse to CDC standard categories. Adjust mappings to match your data.

cases <- cases |>
  mutate(
    race_eth = case_when(
      race_eth %in% c("White, non-Hispanic", "NH_White") ~ "NH White",
      race_eth %in% c("Black, non-Hispanic", "NH_Black") ~ "NH Black",
      race_eth %in% c("Hispanic", "Latino")              ~ "Hispanic",
      race_eth %in% c("Asian, non-Hispanic", "NH_Asian") ~ "NH Asian",
      race_eth == "AI/AN"                                 ~ "NH AIAN",
      race_eth %in% c("NH_NHPI", "NHPI")                 ~ "NH NHPI",
      race_eth %in% c("Multi", "Multiracial")            ~ "NH Multi",
      TRUE                                                ~ "Unknown"
    ),
    race_eth = factor(race_eth, levels = c(
      "NH Black", "NH White", "Hispanic", "NH Asian",
      "NH AIAN", "NH NHPI", "NH Multi", "Unknown"
    ))
  )

# ── 5. Derive age group ────────────────────────────────────────────────────

cases <- cases |>
  mutate(age_group = age_group_std(age_at_diagnosis))

# ── 6. Derive epiweek and epiyear ──────────────────────────────────────────

cases <- cases |>
  mutate(
    diagnosis_date = as.Date(diagnosis_date),
    epiweek        = to_epiweek(diagnosis_date),
    epiyear        = to_epiyear(diagnosis_date)
  )

# ── 7. Filter to analysis year(s) ─────────────────────────────────────────
# Adjust the year range to match your project scope.

analysis_years <- 2020:2024

cases <- cases |>
  filter(epiyear %in% analysis_years)

message(sprintf("After year filter: %d rows (%d to %d)",
                nrow(cases), min(analysis_years), max(analysis_years)))

# ── 8. Final checks ────────────────────────────────────────────────────────

stopifnot(
  "sex must be Male or Female or NA" =
    all(cases$sex %in% c("Male", "Female") | is.na(cases$sex)),
  "age_group must not be all NA" =
    sum(!is.na(cases$age_group)) > 0
)

# ── 9. Save ────────────────────────────────────────────────────────────────

saveRDS(cases, here("03_cleaned_data", "cases_clean.rds"))
message("Saved: 03_cleaned_data/cases_clean.rds")
