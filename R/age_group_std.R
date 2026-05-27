# ages.R
# Age group categorization for surveillance.

#' Assign standard CDC age groups for STD/HIV surveillance
#'
#' Breaks match those used in CDC STD Surveillance Reports.
#'
#' @param age Integer or numeric vector of ages in years.
#'
#' @return Ordered factor with levels:
#'   "<15", "15-19", "20-24", "25-29", "30-34", "35-44", "45-54", "55-64", "65+"
#'
#' @examples
#' age_group_std(c(14, 17, 22, 30, 45, 67))
age_group_std <- function(age) {
  breaks <- c(0, 15, 20, 25, 30, 35, 45, 55, 65, Inf)
  labels <- c("<15", "15-19", "20-24", "25-29", "30-34",
              "35-44", "45-54", "55-64", "65+")
  cut(age, breaks = breaks, labels = labels, right = FALSE, include.lowest = TRUE)
}
