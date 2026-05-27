# 06_output_docs/

Rendered reports: HTML, Word (`.docx`), and PDF files produced from `scripts/05_report.qmd`.

Never manually edit files in this directory. They are generated outputs — regenerate
them by re-rendering the Quarto document if changes are needed.

## Rendering the report

From the RStudio console (with the project open):

```r
# Render to the default format(s) specified in the YAML header
quarto::quarto_render("scripts/05_report.qmd")
```

Or click **Render** in the RStudio editor toolbar when `05_report.qmd` is open.

The rendered output will be placed here automatically if you set `output-dir` in the
YAML header:

```yaml
---
format:
  html:
    output-file: "surveillance_report_2024.html"
execute:
  output-dir: "../06_output_docs"
---
```

## Pre-release checklist

Before distributing any file from this directory:

- [ ] Small-count suppression applied to all tables (counts < 5 → `*`)
- [ ] No PII in output (names, addresses, dates of birth)
- [ ] Report reviewed by a second analyst
- [ ] Version / date noted in report header

## Files in This Directory

| Filename | Rendered from | Date | Notes |
|----------|--------------|------|-------|
| *(add rows as files are created)* | | | |
