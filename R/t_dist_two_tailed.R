

#' T distribution - two-tailed
#'
#' @param t_score t value
#' @param degrees_of_freedom degrees of freedom
#' @importFrom stats pt
#' @return value

t_dist_two_tailed <- function(t_score, degrees_of_freedom) {
  2 * pt(-abs(t_score), degrees_of_freedom)
}
