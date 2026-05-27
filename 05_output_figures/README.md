# 05_output_figures/

Saved plots and maps produced by `scripts/04_visualise.R`.

All figures should be saved programmatically via `ggplot2::ggsave()` — not by clicking
"Export" in the RStudio Plots pane — so they can be reproduced by re-running the script.

## Recommended `ggsave()` settings for reports

```r
ggsave(
  filename = here::here("05_output_figures", "epi_curve_2024.png"),
  plot     = last_plot(),   # or assign the plot to a variable
  width    = 8,
  height   = 5,
  dpi      = 300,
  bg       = "white"
)
```

Use `dpi = 300` for print-quality output; `dpi = 150` is sufficient for HTML reports.

## Naming convention

Use descriptive names that will make sense out of context:

```
epi_curve_gonorrhea_2024.png
age_sex_pyramid_syphilis_2020_2024.png
choropleth_chlamydia_rate_county_2024.png
```

## Files in This Directory

| Filename | Created by | Description |
|----------|-----------|-------------|
| *(add rows as files are created)* | | |
