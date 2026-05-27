# Project Checklist

Use this list when starting a new project. Check off each item as you complete it.

## Day 1 — Set Up

- [ ] Rename the `.Rproj` file to match your project name
- [ ] Update `README.md`: fill in disease/program, jurisdiction, analyst name, and purpose
- [ ] Place raw data files in `02_raw_data/` and document them in the README table
- [ ] Add a data dictionary to `01_documents/` (use `data_dictionary_template.md` as a starting point)
- [ ] Run `scripts/00_packages.R` to install required packages
- [ ] Verify the project opens cleanly: File → Open Project → select your `.Rproj`

## During Analysis

- [ ] **Never edit files in `02_raw_data/`** — raw data is read-only
- [ ] Save all cleaned/processed data to `03_cleaned_data/`
- [ ] Save analytic result tables to `04_output_data/`
- [ ] Save all figures to `05_output_figures/` via `ggsave()`
- [ ] Move any reusable helper functions into `R/utils.R` (or a new `.R` file in `R/`)
- [ ] Document suppression decisions: record any counts < 5 suppressed and why

## Before Sharing / Archiving

- [ ] Confirm that no personally identifiable information (PII) is in `06_output_docs/`
- [ ] Confirm small-count suppression has been applied to all output tables and figures
- [ ] Update `README.md` with the date last updated and any important caveats
- [ ] Verify all scripts run top-to-bottom without errors in a clean R session
- [ ] Add any one-off notes or decisions to the **Notes** section of `README.md`

## Optional (Intermediate / Advanced)

- [ ] Initialise a Git repository: `usethis::use_git()`
- [ ] Add a `renv.lock` file to record exact package versions: `renv::init()`
- [ ] Parameterise `05_report.qmd` to run for multiple jurisdictions or diseases
