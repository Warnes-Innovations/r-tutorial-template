# 04_output_data/

Analytic results: summary tables, model outputs, and other intermediate datasets
produced during analysis.

Files here are produced by `scripts/03_analyse.R`. They feed into `scripts/04_visualise.R`
and `scripts/05_report.qmd`.

## What belongs here

- Aggregated summary tables (counts, rates, proportions by group)
- Model result objects saved as `.rds`
- Intermediate "wide" tables used to produce multiple figures
- Any dataset a collaborator might want to inspect without re-running the full analysis

## Sensitive Data Notice

Aggregated tables may still contain small counts. Apply suppression rules (counts < 5)
**before** placing anything here that will be shared externally. See
`01_documents/data_dictionary_template.md` for the project suppression policy.

## Naming convention

```
rates_by_county_2024.rds
age_sex_table_2020_2024.csv
logistic_model_results.rds
```

## Files in This Directory

| Filename | Created by | Description |
|----------|-----------|-------------|
| *(add rows as files are created)* | | |
