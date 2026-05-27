# formatting.R
# Output formatting utilities for reports.

#' Format a confidence interval as a character string
#'
#' @param est   Point estimate (numeric).
#' @param lower Lower bound (numeric).
#' @param upper Upper bound (numeric).
#' @param digits Number of decimal places. Default 1.
#' @param sep   Separator between bounds. Default " – ".
#'
#' @return Character string, e.g. "18.0 (12.3 – 25.4)".
#'
#' @examples
#' fmt_ci(18.0, 12.3, 25.4)
fmt_ci <- function(est, lower, upper, digits = 1, sep = "\u2013") {
  fmt <- function(x) formatC(round(x, digits), format = "f", digits = digits)
  paste0(fmt(est), " (", fmt(lower), " ", sep, " ", fmt(upper), ")")
}
