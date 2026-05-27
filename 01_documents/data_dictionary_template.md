# Data Dictionary — [Dataset Name]

**Source:** [e.g., NNDSS annual extract | state surveillance system | EHR pull]  
**File:** `02_raw_data/[filename.csv]`  
**Date received:** [YYYY-MM-DD]  
**Received from:** [e.g., CDC / NNDSS | internal IT | county health dept]  
**Coverage:** [e.g., Reportable cases, [State], 2020–2024]  
**Unit of observation:** One row = one [case | person | visit | ...]

---

## Variables

| Variable Name | Type | Values / Range | Description | Notes |
|---------------|------|----------------|-------------|-------|
| `case_id`     | character | unique | De-identified case identifier | Used as primary key |
| `disease`     | character | see below | Condition reported | |
| `report_date` | date | YYYY-MM-DD | Date case was first reported | |
| `diagnosis_date` | date | YYYY-MM-DD | Date of diagnosis | May differ from report date |
| `epiweek`     | integer | 1–53 | CDC epidemiological week of diagnosis | Derived from `diagnosis_date` |
| `epiyear`     | integer | YYYY | Epidemiological year | |
| `age_at_diagnosis` | integer | 0–120 | Age in years at time of diagnosis | |
| `age_group`   | factor | see below | Standard age group | Derived; see recoding notes |
| `sex`         | character | M / F / U | Sex assigned at reporting | CDC NNDSS coding |
| `race_eth`    | character | see below | Race/ethnicity | Collapsed per OMB/CDC guidance |
| `county_fips` | character | 5-digit FIPS | County of residence | Leading zeros preserved |
| `state_fips`  | character | 2-digit FIPS | State of residence | |

---

## Coded Values

### `disease`

| Code | Label |
|------|-------|
| `GC` | Gonorrhea |
| `CT` | Chlamydia |
| `SY` | Syphilis (all stages) |
| `PS` | Primary & Secondary Syphilis |
| `HIV` | HIV infection |

### `age_group` (standard CDC grouping)

`<15`, `15–19`, `20–24`, `25–29`, `30–34`, `35–44`, `45–54`, `55–64`, `65+`

### `race_eth`

| Code | Label |
|------|-------|
| `NH_White` | Non-Hispanic White |
| `NH_Black` | Non-Hispanic Black or African American |
| `Hispanic` | Hispanic or Latino |
| `NH_Asian` | Non-Hispanic Asian |
| `NH_AIAN`  | Non-Hispanic American Indian or Alaska Native |
| `NH_NHPI`  | Non-Hispanic Native Hawaiian or Other Pacific Islander |
| `NH_Multi` | Non-Hispanic Multiracial |
| `Unknown`  | Unknown / missing |

---

## Known Data Quality Issues

- [ ] Document any known issues here (e.g., high missingness in a specific variable, known
      coding inconsistencies between years, counties with historically under-reported cases)

## Suppression Rules

Per [cite policy/guidance], suppress counts fewer than **5** in any cell before public release.
Flag suppressed cells with `*` in output tables.

## Related Files

- Analysis protocol: `01_documents/analysis_protocol.md`
- Cleaning script: `scripts/02_clean.R`
