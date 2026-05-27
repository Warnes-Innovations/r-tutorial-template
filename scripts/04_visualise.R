# 04_visualise.R
# Purpose : Produce standard surveillance figures and save them to
#           05_output_figures/.
# Inputs  : 03_cleaned_data/cases_clean.rds
#           04_output_data/rates_by_year.rds
#           04_output_data/counts_by_age_sex.rds
# Outputs : 05_output_figures/epi_curve_[disease]_[year].png
#           05_output_figures/age_sex_pyramid_[disease]_[year].png
#           05_output_figures/rate_trend_[disease].png
# ─────────────────────────────────────────────────────────────────────────────

library(tidyverse)
library(lubridate)
library(here)

devtools::load_all(here::here())

# Helper: save the last ggplot to 05_output_figures/
save_fig <- function(filename, width = 8, height = 5, dpi = 300) {
  ggsave(
    filename = here("05_output_figures", filename),
    plot     = last_plot(),
    width    = width,
    height   = height,
    dpi      = dpi,
    bg       = "white"
  )
  message("Saved: 05_output_figures/", filename)
}

# ── Load data ──────────────────────────────────────────────────────────────

cases          <- readRDS(here("03_cleaned_data", "cases_clean.rds"))
rates_by_year  <- readRDS(here("04_output_data", "rates_by_year.rds"))
age_sex        <- readRDS(here("04_output_data", "counts_by_age_sex.rds"))

current_year   <- max(cases$epiyear, na.rm = TRUE)
disease_label  <- "Disease Name"   # ← update to e.g. "Gonorrhea"


# ── Figure 1: Epidemic curve ───────────────────────────────────────────────
# Weekly case counts by diagnosis date, most recent year.

epi_data <- cases |>
  filter(epiyear == current_year, !is.na(diagnosis_date)) |>
  mutate(week_start = floor_date(diagnosis_date, unit = "week", week_start = 7))

ggplot(epi_data, aes(x = week_start)) +
  geom_bar(stat = "count") +
  scale_x_date(date_breaks = "1 month", date_labels = "%b") +
  labs(
    title   = paste(disease_label, "— Weekly Cases,", current_year),
    x       = "Week of Diagnosis",
    y       = "Number of Cases",
    caption = "Source: [Data source]. Week begins Sunday."
  ) +
  theme_minimal()

save_fig(paste0("epi_curve_", tolower(disease_label), "_", current_year, ".png"))


# ── Figure 2: Age–sex pyramid ──────────────────────────────────────────────
# Case counts by age group and sex, most recent year's data.
# Males shown on the left (negative x), females on the right (positive x).

pyramid_data <- cases |>
  filter(epiyear == current_year, !is.na(age_group), !is.na(sex)) |>
  count(age_group, sex, name = "n") |>
  mutate(n_plot = if_else(sex == "Male", -n, n))

ggplot(pyramid_data, aes(x = n_plot, y = age_group, fill = sex)) +
  geom_bar(stat = "identity") +
  scale_x_continuous(labels = function(x) abs(x)) +
  scale_fill_manual(values = c("Male" = "#4E79A7", "Female" = "#F28E2B")) +
  labs(
    title   = paste(disease_label, "Cases by Age and Sex,", current_year),
    x       = "Number of Cases",
    y       = "Age Group",
    fill    = NULL,
    caption = "Source: [Data source]."
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

save_fig(paste0("age_sex_pyramid_", tolower(disease_label), "_", current_year, ".png"),
         width = 7, height = 6)


# ── Figure 3: Rate trend over time ────────────────────────────────────────

ggplot(rates_by_year, aes(x = epiyear, y = rate_per_100k)) +
  geom_line() +
  geom_point(size = 2) +
  scale_x_continuous(breaks = rates_by_year$epiyear) +
  labs(
    title   = paste(disease_label, "Incidence Rate,", min(rates_by_year$epiyear),
                    "–", max(rates_by_year$epiyear)),
    x       = "Year",
    y       = "Cases per 100,000 Population",
    caption = "Source: [Data source]. Rates calculated using [Census] population estimates."
  ) +
  theme_minimal()

save_fig(paste0("rate_trend_", tolower(disease_label), ".png"), height = 4)

message("All figures saved to 05_output_figures/")
