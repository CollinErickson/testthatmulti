#' Test that multi: expect true
#'
#' See `testthat::expect_true` for details.
#'
#' @param object Object to test.
#' @param info Passed to `testthat::expect_true()`.
#' @param label Passed to `testthat::expect_true()`.
#' @param verbose Amount of info that should be printed.
#'
#' @return Test result
#' @export
#'
#' @examples
#' set.seed(0)
#'
#' # 1 attempt, all pass
#' ttm(1, {
#'   ttm_expect_true(TRUE)
#'   ttm_expect_true(1 == 1)
#'   ttm_expect_true(all(1:5 == 1:5))
#' })
#'
#' # Fails first 10 times, then passes
#' ttm(100, {
#'   x <- runif(1)
#'   print(x)
#'   ttm_expect_true(x < 0.1)
#' })
#'
#' # Will always fail regardless of number of attempts
#' try({
#'   ttm(3, {
#'     ttm_expect_true(1 == 2)
#'   })
#' })
ttm_expect_true <- function(object, info = NULL, label = NULL, verbose=0) {
  enquo_object <- rlang::enquo(object)
  .ttm_mode <- getOption(".ttm_mode")
  if (is.null(.ttm_mode)) {
    .ttm_mode <- "mustpass"
  }
  if (.ttm_mode == "canfail") {
    if (verbose >= 1) {
      print('in fake mode canfail')
    }

    passes_testthat <- {
      isTRUE(object)
    }
    if (passes_testthat) {
      testthat::expect_true(!!enquo_object, info=info, label=label)
    } else {
      options(".ttm_nofails" = FALSE)
    }
  } else if (.ttm_mode == "mustpass") {
    if (verbose >= 1) {
      print('mustpass')
    }
    testthat::expect_true(!!enquo_object, info=info, label=label)
  } else {
    print(.ttm_mode)
    stop(paste0('Bad .ttm_mode'))
  }
}
