#' Test that multi: expect error
#'
#' See `testthat::expect_error` for details.
#'
#' @param object Object to test.
#' @param info Passed to `testthat::expect_error()`.
#' @param label Passed to `testthat::expect_error()`.
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
#'   ttm_expect_error(stop('error'))
#' })
#'
#' # Fails first ~10 times, then passes
#' ttm(100, {
#'   ttm_expect_error({
#'     print(1)
#'     if (runif(1) < 0.1) {
#'       stop('give error')
#'     }
#'   })
#' })
#'
#' # Will always fail regardless of number of attempts
#' try({
#'   ttm(3, {
#'     ttm_expect_error(1 == 2)
#'   })
#' })
ttm_expect_error <- function(object, info = NULL, label = NULL, verbose=0) {
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
      inherits(
        try(rlang::eval_tidy(enquo_object), silent=TRUE),
        'try-error')
    }
    if (passes_testthat) {
      # Can't rerun enquo_object, just put placeholder
      testthat::expect_error(stop("<testthatmulti::expect_error placeholder>"),
                             info=info, label=label)
    } else {
      options(".ttm_nofails" = FALSE)
    }
  } else {
    stopifnot(.ttm_mode == "mustpass")
    if (verbose >= 1) {
      print('mustpass')
    }
    testthat::expect_error(!!enquo_object, info=info, label=label)
  }
}
