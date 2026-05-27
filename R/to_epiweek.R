# epiweeks.R
# Epidemiological week utilities for surveillance dates.

#' Extract the CDC epidemiological week number from a date
#'
#' A thin wrapper around lubridate::epiweek() that also handles NA gracefully.
#'
#' @param date  A Date vector.
#' @return Integer vector of epiweek numbers (1–53).
#'
#' @examples
#' to_epiweek(as.Date("2024-01-07"))   # 1
#' to_epiweek(as.Date("2024-12-31"))   # 1  (belongs to epi-year 2025)
to_epiweek <- function(date) {
  lubridate::epiweek(date)
}

#' Extract the CDC epidemiological year from a date
#'
#' @param date  A Date vector.
#' @return Integer vector of epi-years.
#'
#' @examples
#' to_epiyear(as.Date("2024-12-31"))   # 2025
to_epiyear <- function(date) {
  lubridate::epiyear(date)
}
