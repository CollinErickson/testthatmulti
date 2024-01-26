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
#' ttm_expect_equal(TRUE, TRUE)
#' ttm_expect_equal(1, 1)
#' ttm_expect_equal(1:5, 1:5)
#' # ttm_expect_equal(1, 2)
ttm_expect_equal <- function(object, expected, ...,
                             tolerance=if (testthat::edition_get() >=
                                           3) testthat::testthat_tolerance(),
                             info = NULL, label = NULL,
                             expected.label = NULL,
                             verbose=0) {
  if (exists("tteedb") && isTRUE(tteedb)) {browser("exists/debug")}
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


    # browser()
    passes_testthat <- {
      # Run guts of expect_true here, but not an actual test

      act <- testthat::quasi_label(rlang::enquo(object), label, arg = "object")
      exp <- testthat::quasi_label(rlang::enquo(expected), expected.label, arg = "expected")
      if (testthat::edition_get() >= 3) {
        try_ewe <- try({
          testthat:::expect_waldo_equal("equal", act, exp, info, ..., tolerance = tolerance)
        }, silent=T)
        !("try-error" %in% class(try_ewe))

        # waldo_compare is bad b/c it thinks 6L and 6 aren't equal
        # comp <- testthat:::waldo_compare(act$val, exp$val, ..., x_arg = "actual",
        #                       y_arg = "expected")
        # (length(comp) < .5)
      } else {
        if (!is.null(tolerance)) {
          comp <- compare(act$val, exp$val, ..., tolerance = tolerance)
        }
        else {
          comp <- compare(act$val, exp$val, ...)
        }
        comp$equal
      }
    }
    if (passes_testthat) {
      testthat::expect_equal(object=!!enquo_object, expected=!!enquo_expected, ...)
    } else {
      # next
      # .ttm_nofails <<- FALSE
      # assign(".ttm_nofails", FALSE, envir=globalenv())
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
