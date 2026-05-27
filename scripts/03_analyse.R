# 03_analyse.R
# Purpose : Compute descriptive statistics: counts, rates, and proportions
#           by key demographics and geography.
# Inputs  : 03_cleaned_data/cases_clean.rds
#           03_cleaned_data/population.rds
# Outputs : 04_output_data/rates_by_year.rds
#           04_output_data/rates_by_county.rds
#           04_output_data/counts_by_age_sex.rds
#           04_output_data/counts_by_race_eth.rds
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(here)

devtools::load_all(here::here())

# ── 1. Load data ───────────────────────────────────────────────────────────

cases  <- readRDS(here("03_cleaned_data", "cases_clean.rds"))
pop    <- readRDS(here("03_cleaned_data", "population.rds"))

# ── 2. Annual case counts and rates ───────────────────────────────────────
# Join annual case counts to population denominators, then compute rates.

annual_counts <- cases |>
  count(epiyear, name = "n_cases")

# Aggregate population to state level (assuming pop is county × year)
annual_pop <- pop |>
  group_by(year) |>
  summarise(population = sum(population, na.rm = TRUE), .groups = "drop")

rates_by_year <- annual_counts |>
  left_join(annual_pop, by = c("epiyear" = "year")) |>
  mutate(rate_per_100k = calc_rate(n_cases, population))

rates_by_year

# ── 3. County-level rates (most recent year) ──────────────────────────────

current_year <- max(cases$epiyear, na.rm = TRUE)

county_counts <- cases |>
  filter(epiyear == current_year) |>
  count(county_fips, name = "n_cases")

county_pop <- pop |>
  filter(year == current_year) |>
  select(county_fips, population)

rates_by_county <- county_counts |>
  left_join(county_pop, by = "county_fips") |>
  mutate(
    rate_per_100k = calc_rate(n_cases, population),
    # Apply small-count suppression before any sharing
    n_cases_public = suppress_counts(n_cases)
  ) |>
  arrange(desc(rate_per_100k))

# ── 4. Counts by age group and sex ────────────────────────────────────────

counts_by_age_sex <- cases |>
  count(age_group, sex, name = "n_cases") |>
  # Suppression for potential output
  mutate(n_cases_public = suppress_counts(n_cases))

# ── 5. Counts by race/ethnicity ───────────────────────────────────────────

counts_by_race_eth <- cases |>
  count(race_eth, name = "n_cases") |>
  mutate(
    pct         = round(n_cases / sum(n_cases) * 100, 1),
    n_cases_public = suppress_counts(n_cases)
  ) |>
  arrange(desc(n_cases))

# ── 6. Save outputs ────────────────────────────────────────────────────────

saveRDS(rates_by_year,     here("04_output_data", "rates_by_year.rds"))
saveRDS(rates_by_county,   here("04_output_data", "rates_by_county.rds"))
saveRDS(counts_by_age_sex, here("04_output_data", "counts_by_age_sex.rds"))
saveRDS(counts_by_race_eth,here("04_output_data", "counts_by_race_eth.rds"))

message("Analysis complete — outputs saved to 04_output_data/")
