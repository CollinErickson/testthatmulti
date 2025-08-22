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
    # browser()
    # passes_testthat <- {
    #   isTRUE(object)
    # }
    # Not sure all this is needed, tried to fix some test stuff
    passes_testthat <- {
      isTRUE(
        rlang::eval_tidy(
          rlang::quo_get_expr(enquo_object),
          # env=rlang::caller_env(n=4)
          # env=parent.frame()
          env=rlang::quo_get_env(enquo_object)
        )
      )
    }
    if (passes_testthat) {
      # Use placeholder to avoid randomness (this time could give different result)
      testthat::expect_true(TRUE,
                            info=info, label=label)
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
