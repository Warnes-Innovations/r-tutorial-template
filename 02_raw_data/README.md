# 02_raw_data/

**⚠️ READ-ONLY — Do not edit, rename, or delete any file in this directory.**

This directory holds original source data exactly as received. Preserving raw data
without modification is the foundation of a reproducible analysis: if you ever need
to re-run the project from scratch, you need to know you are starting from the same
inputs.

## Rules

1. **Never overwrite a raw file.** If you receive an updated extract, add it with a
   new filename (e.g., `nndss_2024_v2.csv`) and update `README.md`.
2. **Never clean data here.** All transformations happen in `scripts/02_clean.R`;
   cleaned data is saved to `03_cleaned_data/`.
3. **Document every file** in the table below when you add it.

## Files in This Directory

| Filename | Source | Date Received | Description |
|----------|--------|---------------|-------------|
| `cases.csv` | Synthetic (course exercise data) | 2026-05-25 | 850 STD/HIV case records, NC counties, 2020–2024. Includes intentional data quality issues for cleaning exercises: duplicate case IDs, missing dates, mixed sex coding, impossible ages. |
| `population.csv` | Synthetic (ACS-approximate) | 2026-05-25 | County × year population denominators for 15 NC counties, 2020–2024. Used for rate calculations. |
| `county_reference.csv` | Synthetic | 2026-05-25 | County FIPS → county name → region lookup table for 15 NC counties. |

### Data Schema: `cases.csv`

| Column | Type | Notes |
|--------|------|-------|
| `case_id` | character | Unique case identifier (`NC` + 7 digits). **⚠️ Contains ~7 intentional duplicates for deduplication exercise.** |
| `county_fips` | character | 5-digit FIPS (leading zero preserved). 15 NC counties. |
| `disease` | character | Gonorrhea, Chlamydia, Syphilis - Primary/Secondary/Early Latent, HIV |
| `diagnosis_date` | date (YYYY-MM-DD) | **⚠️ 8 missing values** to discover and handle. |
| `report_date` | date (YYYY-MM-DD) | Date case reported. Always ≥ diagnosis_date (0–21 day lag). |
| `age_at_diagnosis` | numeric | **⚠️ 3 impossible values** (5, -1, 130) for outlier detection exercise. |
| `sex` | character | **⚠️ Mixed coding**: "M", "Male", "F", "Female", "Unknown", NA — requires recoding. |
| `race_eth` | character | CDC-adjacent codes: NH_Black, NH_White, Hispanic, NH_Asian, AI/AN, Multi, Unknown. |
| `provider_zip` | character | 5-digit NC ZIP code of reporting provider. |
| `test_type` | character | NAAT, Culture, Serology, Rapid, NA. |

## Common Sources

- **NNDSS extracts**: received from CDC as `.csv` or `.sas7bdat`; use `haven::read_sas()` to read SAS files
- **CDC NCHHSTP Atlas**: downloadable as `.csv` from <https://gis.cdc.gov/grasp/nchhstpatlas/main.html>
- **Census population estimates**: American Community Survey 5-year tables via `tidycensus` or downloaded `.csv`
- **State surveillance system exports**: coordinate with IT for extract format and field definitions

## Sensitive Data Notice

Case-level surveillance data likely contains **protected health information (PHI)**.
Confirm with your data governance officer before committing this directory to a
shared repository. The default `.gitignore` excludes all files in `02_raw_data/`
except this README.
