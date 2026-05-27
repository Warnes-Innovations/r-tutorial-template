# 03_cleaned_data/

Cleaned and processed data, ready for analysis.

Files here are produced by `scripts/02_clean.R` (and sometimes `01_ingest.R`) from the
raw data in `02_raw_data/`. They are safe to read directly in `scripts/03_analyse.R`
and downstream scripts.

## What belongs here

- Cleaned case-level datasets (recoded variables, validated dates, standardised categories)
- Merged datasets (e.g., cases joined to population denominators)
- Intermediate `.rds` files that are slow to re-create and reused across scripts

## What does NOT belong here

- Raw, unmodified source data → `02_raw_data/`
- Final analytic summary tables → `04_output_data/`

## Naming convention

Use descriptive names that reflect content and, if relevant, the date range covered:

```
cases_clean_2020_2024.rds
cases_pop_merged_2024.rds
```

Prefer `.rds` for R-native objects (preserves factor levels, date types, etc.).
Use `.csv` only when the file needs to be shared with non-R users.

## Files in This Directory

| Filename | Created by | Description |
|----------|-----------|-------------|
| *(add rows as files are created)* | | |
