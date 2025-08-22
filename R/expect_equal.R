#' Test that multi: expect equal
#'
#' @param object Object to check if equal to expected
#' @param expected Expected value
#' @param ... Args passed to testthat::expect_equal()
#' @param tolerance Passed to `testthat::expect_true()`.
#' @param info Passed to `testthat::expect_true()`.
#' @param label Passed to `testthat::expect_true()`.
#' @param expected.label Passed to `testthat::expect_true()`.
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
#'   ttm_expect_equal(TRUE, TRUE)
#'   ttm_expect_equal(1, 1)
#'   ttm_expect_equal(1:5, 1:5)
#' })
#'
#' # Fails first 6 times, then passes
#' ttm(100, {
#'   x <- sample(1:6, 1)
#'   print(x)
#'   ttm_expect_equal(x, 3)
#' })
#'
#' # Will always fail regardless of number of attempts
#' try({
#'   ttm(3, {
#'     ttm_expect_equal(1, 2)
#'   })
#' })
ttm_expect_equal <- function(object, expected, ...,
                             tolerance=if (testthat::edition_get() >=
                                           3) testthat::testthat_tolerance(),
                             info = NULL, label = NULL,
                             expected.label = NULL,
                             verbose=0) {
  enquo_object <- rlang::enquo(object)
  enquo_expected <- rlang::enquo(expected)
  .ttm_mode <- getOption(".ttm_mode")
  if (is.null(.ttm_mode)) {
    # stop(".ttm_mode is NULL")
    .ttm_mode <- "mustpass"
  }
  if (.ttm_mode == "canfail") {
    if (verbose >= 1) {
      print('in fake mode canfail')
    }


    passes_testthat <- {
      ttc <- if (!is.null(tolerance)) {
        testthat::compare(object, expected, ..., tolerance=tolerance)}
      else {
        testthat::compare(object, expected, ...)
      }
      ttc$equal
    }
    if (passes_testthat) {
      # Can't use same object since there could be randomness
      testthat::expect_equal(
        object=  "<testthatmulti::expect_true placeholder>",
        expected="<testthatmulti::expect_true placeholder>",
        ...)
      # testthat::expect_equal(object=!!enquo_object, expected=!!enquo_expected, ...)
    } else {
      options(".ttm_nofails" = FALSE)
    }
  } else if (.ttm_mode == "mustpass") {
    if (verbose >= 1) {
      print('mustpass')
    }
    testthat::expect_equal(object=!!enquo_object, expected=!!enquo_expected, ...)
  } else {
    print(.ttm_mode)
    stop(paste0('Bad .ttm_mode'))
  }
}
