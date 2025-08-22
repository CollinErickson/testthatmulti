#' Iteration count for ttm()
#'
#' @return int for ttm iteration, starting at 1
#' @export
#'
#' @examples
#' ttm(100, {
#'   x <- runif(1)
#'   cat('ttm i =', ttm_i(), 'n =', ttm_n(), 'x =', x, '\n')
#'   ttm_expect_true(x < 0.1)
#' })
ttm_i <- function() {
  options()$'.ttm_i'
}

#' Max number of attempts for ttm()
#'
#' @return int for ttm number of attempts
#' @export
#'
#' @examples
#' ttm(100, {
#'   x <- runif(1)
#'   cat('ttm i =', ttm_i(), 'n =', ttm_n(), 'x =', x, '\n')
#'   ttm_expect_true(x < 0.1)
#' })
ttm_n <- function() {
  options()$'.ttm_i'
}
