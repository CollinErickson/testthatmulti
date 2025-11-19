# Works in testthat
testthat::test_that("Refer to vars in previous expects", {
  expect_no_error({x <- 10})
  expect_equal(x, 10)
})

# Doesn't work in ttm
testthatmulti::ttm(10, {
  ttm_expect_no_error({x <- 10})
  ttm_expect_equal(x, 10)
})

# Bad hack since it can affect
testthatmulti::ttm(10, {
  ttm_expect_no_error({x <<- 10})
  ttm_expect_equal(x, 10)
  print(x)
  rm(x, pos=".GlobalEnv") # Can't just rm
})
