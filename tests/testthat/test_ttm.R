library(testthat)

test_that("ttm expect_true", {
  expect_no_error(
    {
      n16 <- 0
      ttm(1e5, {
        # n16 <<- n16+1
        xx <- runif(1)
        # cat('xx', xx, "\n")
        ttm_expect_true(xx < 1e-3)
      })
      # print(n16)
    }
  )

  expect_error(
    ttm(3, {
      ttm_expect_true(FALSE)
    })
  )
})

test_that("ttm expect_equal", {
  expect_no_error(
    ttm(3, ttm_expect_equal(1, 1))
  )

  expect_error(
    ttm(3, {
      ttm_expect_equal(1, 2)
    })
  )

  expect_no_error({
    ttm(1e2, {
      diceroll <- sample(1:6, 1)
      print(diceroll)
      ttm_expect_equal(diceroll, 6, verbose=1)
    })
  })
})
