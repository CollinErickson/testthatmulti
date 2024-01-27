#' Test that with multiple attempts
#'
#' @param n Maximum number of attempts
#' @param expr Expression to evaluate
#' @param verbose Amount that should be printed
#'
#' @return Nothing
#' @export
#'
#' @examples
#'
#' ttm(20, {
#'   xx <- runif(1)
#'   cat('xx', xx, "\n")
#'   ttm_expect_true(xx < .2)
#' })
ttm <- function(n, expr, verbose=0) {
  # if (exists("dbttm") && isTRUE(dbttm)) {browser("exists/debug")}

  stopifnot(is.numeric(n), length(n)==1, abs(n-round(n))<1e-8, n >= 1)
  n <- round(n)

  on.exit({
    # rm(.ttm_nofails, envir=globalenv())
    # rm(.ttm_mode, envir=globalenv())
    options(.ttm_mode = NULL)
  }, add=T, after=T)

  for (i_ttm in 1:n) {
    # .ttm_nofails <- TRUE
    # assign(".ttm_nofails", TRUE, envir=globalenv())
    options(".ttm_nofails" = TRUE)

    if (verbose >= 1) {
      cat("i:", i_ttm, "\n")
    }
    # browser()
    if (i_ttm < n) {
      # .ttm_mode <- "canfail"
      # assign(".ttm_mode", "canfail", envir=globalenv())
      options(".ttm_mode" = "canfail")
      # ttm_expect_true <- function(x, ...) {
      #   print('in fake ttmet')
      #   if (isTRUE(x)) {
      #     testthat::expect_true(x, ...)
      #   } else {
      #     # next
      #     .ttm_nofails <<- FALSE
      #   }
      # }
    } else {
      # .ttm_mode <- "mustpassepic"
      # assign(".ttm_mode", "mustpass", envir=globalenv())
      options(".ttm_mode" = "mustpass")
      #   ttm_expect_true <- testthat::expect_true
    }
    # print(ttm_expect_true)
    # eval expr now
    # expr
    # rlang::locally(expr)
    # rlang::with_env(rlang::current_env(), expr)
    # rlang::with_env(globalenv(), expr)
    eval(substitute(expr))

    .ttm_nofails <- getOption(".ttm_nofails")
    stopifnot(length(.ttm_nofails) == 1, is.logical(.ttm_nofails),
              (.ttm_nofails == TRUE) || (.ttm_nofails == FALSE))
    if (verbose >= 1) {
      cat(i_ttm, '.ttm_nofails is', .ttm_nofails, "\n")
    }
    if (.ttm_nofails) {
      break;
    }
  }
  # All tests passed before end
  return(invisible())
}
if (F) {
  ttm(2, {
    xx <- runif(1)
    cat('xx', xx, "\n")
    ttm_expect_true(xx < .2)
  })


  {
    n16 <- 0
    ttm(1e6, {
      n16 <<- n16+1
      xx <- runif(1)
      # cat('xx', xx, "\n")
      ttm_expect_true(xx < 1e-5)
    })
    print(n16)
  }
}
