# rates.R
# Incidence rate calculation.

#' Calculate an incidence rate per 100,000 population
#'
#' @param n_cases  Numeric vector of case counts.
#' @param pop      Numeric vector of population denominators (must be same length as n_cases).
#' @param per      Rate multiplier; default 100000 (cases per 100,000 population).
#'
#' @return Numeric vector of rates, rounded to 1 decimal place. Returns NA where
#'   pop is zero or NA.
#'
#' @examples
#' calc_rate(45, 250000)          # 18.0
#' calc_rate(c(10, 0, 5), c(50000, 50000, 50000))
calc_rate <- function(n_cases, pop, per = 100000) {
  rate <- ifelse(pop > 0 & !is.na(pop), (n_cases / pop) * per, NA_real_)
  round(rate, 1)
}
