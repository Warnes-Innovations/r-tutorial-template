# validation.R
# Data validation and quality-check utilities.

#' Print a quick summary of missing values by column
#'
#' @param df A data frame.
#' @return A data frame with columns `variable`, `n_missing`, `pct_missing`,
#'   printed to the console and returned invisibly.
#'
#' @examples
#' missing_summary(mtcars)
missing_summary <- function(df) {
  n <- nrow(df)
  result <- data.frame(
    variable    = names(df),
    n_missing   = sapply(df, function(x) sum(is.na(x))),
    pct_missing = sapply(df, function(x) round(mean(is.na(x)) * 100, 1)),
    row.names   = NULL
  )
  result <- result[order(-result$n_missing), ]
  print(result, row.names = FALSE)
  invisible(result)
}
