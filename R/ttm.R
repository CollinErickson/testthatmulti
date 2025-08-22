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
ttm <- function(n, expr, verbose=0) {
  stopifnot(is.numeric(n), length(n)==1, abs(n-round(n))<1e-8, n >= 1)
  n <- round(n)

  on.exit({
    options(.ttm_mode = NULL)
    options(.ttm_nofails = NULL)
    options(.ttm_i = NULL)
    options(.ttm_n = NULL)
  }, add=T, after=T)

  for (i_ttm in 1:n) {
    options(".ttm_nofails" = TRUE)
    options(".ttm_i" = i_ttm)
    options(".ttm_n" = n)

    if (verbose >= 1) {
      cat("i:", i_ttm, "\n")
    }

    if (i_ttm < n) {
      options(".ttm_mode" = "canfail")
    } else {
      options(".ttm_mode" = "mustpass")
    }

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
