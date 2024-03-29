% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expect_true.R
\name{ttm_expect_true}
\alias{ttm_expect_true}
\title{Test that multi: expect true}
\usage{
ttm_expect_true(object, info = NULL, label = NULL, verbose = 0)
}
\arguments{
\item{object}{Object to test.}

\item{info}{Passed to `testthat::expect_true()`.}

\item{label}{Passed to `testthat::expect_true()`.}

\item{verbose}{Amount of info that should be printed.}
}
\value{
Test result
}
\description{
See `testthat::expect_true` for details.
}
\examples{
set.seed(0)

# 1 attempt, all pass
ttm(1, {
  ttm_expect_true(TRUE)
  ttm_expect_true(1 == 1)
  ttm_expect_true(all(1:5 == 1:5))
})

# Fails first 10 times, then passes
ttm(100, {
  x <- runif(1)
  print(x)
  ttm_expect_true(x < 0.1)
})

# Will always fail regardless of number of attempts
try({
  ttm(3, {
    ttm_expect_true(1 == 2)
  })
})
}
