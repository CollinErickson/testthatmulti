library(testthat)

# ttm ----
test_that("ttm verbose", {
  expect_no_error(capture.output(ttm(1, {
    ttm_expect_true(1 == 1, verbose = 10)
  }, verbose = 10)))

})

# ttm_expect_true ----
test_that("ttm expect_true", {
  expect_no_error({
    n16 <- 0
    ttm(1e5, {
      # n16 <<- n16+1
      xx <- runif(1)
      # cat('xx', xx, "\n")
      ttm_expect_true(xx < 1e-3)
    })
    # print(n16)
  })

  expect_error(ttm(3, {
    ttm_expect_true(FALSE)
  }))
})

# # i <- 1
# test_that("ttm_expect_true verbose", {
#   expect_no_error({
#     i <- 1
#     ttm(1e5, {
#       capture.output(ttm_expect_true(i > 3, verbose = 10))
#       i <<- i + 1
#     })
#   })
# })
# # rm(i)

test_that(".ttm_mode error", {
  options('.ttm_mode' = 'not good value')
  capture.output(expect_error(ttm_expect_true(1 == 1)))
  options('.ttm_mode' = NULL)
})

test_that("ttm_expect_true edge cases", {
  expect_no_error(ttm_expect_true(1 == 1))
})

# ttm_expect_equal ----
test_that("ttm expect_equal", {
  expect_no_error(ttm(3, ttm_expect_equal(1, 1)))

  expect_no_error(ttm(3, ttm_expect_equal(1, 1, tolerance = NULL)))

  expect_error(ttm(3, {
    ttm_expect_equal(1, 2)
  }))

  expect_no_error({
    ttm(1e2, {
      diceroll <- sample(1:6, 1)
      print(diceroll)
      ttm_expect_equal(diceroll, 6, verbose = 0)
    })
  })
})

test_that("ttm_expect_equal verbose", {
  expect_no_error(capture.output(ttm(1, {
    ttm_expect_equal(1, 1, verbose = 10)
  })))
})


test_that(".ttm_mode error", {
  options('.ttm_mode' = 'not good value')
  capture.output(expect_error(ttm_expect_equal(1, 1)))
  options('.ttm_mode' = NULL)
})

test_that("ttm_expect_true edge cases", {
  expect_no_error(ttm_expect_equal(1, 1))
})
