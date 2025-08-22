#' Test that multi: expect no error
#'
#' See `testthat::expect_no_error` for details.
#'
#' @param object Object to test.
#' @param message Passed to `testthat::expect_no_error()`.
#' @param class Passed to `testthat::expect_no_error()`.
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
#'   ttm_expect_no_error(1)
#' })
#'
#' # Fails first ~10 times, then passes
#' ttm(100, {
#'   ttm_expect_no_error({
#'     if (runif(1) > 0.1) {
#'       print(1)
#'       stop('give error')
#'     }
#'   })
#' })
#'
#' # Will always fail regardless of number of attempts
#' try({
#'   ttm(3, {
#'     ttm_expect_no_error(stop('error'))
#'   })
#' })
ttm_expect_no_error <- function(object, message = NULL, class = NULL, verbose=0) {
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
      !inherits(
        try(rlang::eval_tidy(enquo_object), silent=TRUE),
        'try-error')
    }
    if (passes_testthat) {
      testthat::expect_no_error("<testthatmulti::expect_error placeholder",
                                message=message, class=class)
    } else {
      options(".ttm_nofails" = FALSE)
    }
  } else if (.ttm_mode == "mustpass") {
    if (verbose >= 1) {
      print('mustpass')
    }
    testthat::expect_no_error(!!enquo_object, message=message, class=class)
  } else {
    print(.ttm_mode)
    stop(paste0('Bad .ttm_mode'))
  }
}
