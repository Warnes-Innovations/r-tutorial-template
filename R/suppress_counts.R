# suppression.R
# Small-count suppression for data privacy.

#' Suppress small counts for public release
#'
#' Replaces counts below a threshold with NA (or a display string). Use before
#' publishing any table that contains case counts to prevent re-identification.
#'
#' @param x         Numeric vector of counts.
#' @param threshold Suppress counts strictly less than this value. Default 5
#'   (per CDC guidance).
#' @param replace   Value to substitute for suppressed cells. Default NA_integer_.
#'   Use "*" for display tables.
#'
#' @return Vector of the same length as x with small values replaced.
#'
#' @examples
#' suppress_counts(c(0, 3, 5, 12, NA))          # NA  NA   5  12  NA
#' suppress_counts(c(0, 3, 5, 12), replace = "*") # "*" "*"  "5" "12"
suppress_counts <- function(x, threshold = 5, replace = NA_integer_) {
  ifelse(!is.na(x) & x < threshold, replace, x)
}
