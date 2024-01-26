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
#' ttm_expect_true(TRUE)
#' ttm_expect_true(FALSE)
ttm_expect_true <- function(object, info = NULL, label = NULL, verbose=0) {
  enquo_object <- rlang::enquo(object)
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

      act <- testthat:::quasi_label(rlang::enquo(object), label, arg = "object")
      act$val <- as.vector(act$val)
      # testthat:::expect_waldo_constant(act, TRUE, info = info)
      constant=TRUE
      comp <- testthat:::waldo_compare(act$val, constant, x_arg = "actual",
                                       y_arg = "expected")
      comp
      length(comp) < .5
    }
    if (passes_testthat) {
      testthat::expect_true(!!enquo_object, info=info, label=label)
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
    testthat::expect_true(!!enquo_object, info=info, label=label)
  } else {
    print(.ttm_mode)
    stop(paste0('Bad .ttm_mode'))
  }
}
