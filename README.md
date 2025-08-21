
<!-- README.md is generated from README.Rmd. Please edit that file -->

# testthatmulti

<!-- badges: start -->

[![R-CMD-check](https://github.com/CollinErickson/testthatmulti/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CollinErickson/testthatmulti/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/CollinErickson/testthatmulti/branch/master/graph/badge.svg)](https://app.codecov.io/gh/CollinErickson/testthatmulti?branch=master)
[![Codecov test
coverage](https://codecov.io/gh/CollinErickson/testthatmulti/graph/badge.svg)](https://app.codecov.io/gh/CollinErickson/testthatmulti)
<!-- badges: end -->

The goal of testthatmulti is to enhance the R package `testthat` so that
noisy tests can be run. If a test fails 1% of the time, it can cause
problems with R packages. By allowing each test multiple attempts to
pass, unexpected and rare test failures can be avoided.

## Installation

You can install the development version of testthatmulti from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("CollinErickson/testthatmulti")
```

## Example

For example, suppose you have a test that passes 99% of the time. This
can happen when tests are run using randomly generated data, such as for
modeling or optimization.

``` r
set.seed(153)
library(testthat)
x <- runif(1)
cat('x is', x, '\n')
#> x is 0.9975921
expect_true(x < .99)
#> Error: x < 0.99 is not TRUE
#> 
#> `actual`:   FALSE
#> `expected`: TRUE
```

This test will usually pass, but could fail occasionally and cause
problems when submitting to CRAN.

To give the test multiple chances to pass, wrap the function `ttm`
around the code for the tests and tell it how many times to run the
tests. It will succeed if all the tests are passed on any single
iteration. In the code for the tests, replace `expect_true` with
`ttm_expect_true` and `expect_equal` with `ttm_expect_equal`.

Below, we run the same test as above, but give it 3 chances to pass. By
giving it 3 attempts to pass the test, the probability of failure drops
from 1% to 0.0001%

``` r
set.seed(153)
library(testthatmulti)
ttm(10, {
  x <- runif(1)
  cat('x is', x, '\n')
  ttm_expect_true(x < .99)
})
#> x is 0.9975921 
#> x is 0.4970875
```
