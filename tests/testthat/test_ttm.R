library(testthat)

# ttm ----
test_that("ttm verbose", {
  expect_no_error(capture.output(ttm(1, {
    ttm_expect_true(1 == 1, verbose = 10)
  }, verbose = 10)))
})


test_that("ttm references", {
  aa <- 1
  expect_no_error(ttm(1, {
    aa
  }))
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

# Referring to other objects in tests from other environments
# causes issues
aa <- TRUE
test_that("ttm_expect_true - refer to outside obj", {
  # Refer to an object outside of ttm
  bb <- TRUE

  # Works using ttm
  expect_no_error({
    ttm(5, {
      cc <- TRUE
      ttm_expect_true(aa && bb && cc)
      rm(cc)
    })
  })

  # Works using tt (need to test both)
  expect_no_error({
    ttm(1, {
      cc <- TRUE
      aa && bb && cc
      ttm_expect_true(aa && bb && cc)
      rm(cc)
    })
  })

  rm(bb)
})
rm(aa)

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

test_that("ttm_expect_equal edge cases", {
  expect_no_error(ttm_expect_equal(1, 1))
})


# Referring to other objects in tests from other environments
# causes issues
aa <- TRUE
test_that("ttm_expect_equal - refer to outside obj", {
  # Refer to an object outside of ttm
  bb <- TRUE

  # Works using ttm
  expect_no_error({
    ttm(5, {
      cc <- TRUE
      ttm_expect_equal(aa && bb, cc)
      rm(cc)
    })
  })

  # Works using tt (need to test both)
  expect_no_error({
    ttm(1, {
      cc <- TRUE
      aa && bb && cc
      ttm_expect_equal(aa && bb, cc)
      rm(cc)
    })
  })

  rm(bb)
})
rm(aa)


# ttm_expect_error ----
test_that("ttm_expect_error", {
  expect_no_error(
    ttm(1, {
      ttm_expect_error(stop('error'))
    })
  )

  expect_error(
    ttm(1, {
      ttm_expect_error(('error'))
    })
  )

  expect_no_error(
    ttm(100, {

      ttm_expect_error(
      if (runif(1) > 0.1) {stop('error')}
      )
    })
  )
})


# Referring to other objects in tests from other environments
# causes issues
aa <- TRUE
test_that("ttm_expect_error - refer to outside obj", {
  # Refer to an object outside of ttm
  bb <- TRUE

  # Works using ttm
  expect_no_error({
    ttm(5, {
      cc <- TRUE
      ttm_expect_error(if ((aa && bb && cc)) {stop('aabbcc')})
      rm(cc)
    })
  })

  # Works using tt (need to test both)
  expect_no_error({
    ttm(1, {
      cc <- TRUE
      aa && bb && cc
      ttm_expect_error(if ((aa && bb && cc)) {stop('aabbcc')})
      rm(cc)
    })
  })

  rm(bb)
})
rm(aa)


# ttm_expect_no_error ----
test_that("ttm_expect_no_error", {
  expect_no_error(
    ttm(1, {
      ttm_expect_no_error(('error'))
    })
  )

  expect_error(
    ttm(1, {
      ttm_expect_no_error(stop('error'))
    })
  )

  expect_no_error(
    ttm(100, {

      ttm_expect_no_error(
        if (runif(1) < 0.1) {stop('error')}
      )
    })
  )
})

# Referring to other objects in tests from other environments
# causes issues
aa <- TRUE
test_that("ttm_expect_no_error - refer to outside obj", {
  # Refer to an object outside of ttm
  bb <- TRUE

  # Works using ttm
  expect_no_error({
    ttm(5, {
      cc <- TRUE
      ttm_expect_no_error(aa && bb && cc)
      rm(cc)
    })
  })

  # Works using tt (need to test both)
  expect_no_error({
    ttm(1, {
      cc <- TRUE
      aa && bb && cc
      ttm_expect_no_error(aa && bb && cc)
      rm(cc)
    })
  })

  rm(bb)
})
rm(aa)


# ttm_i and ttm_n ----
test_that('ttm_i and ttm_n', {
  # iii <- 0 # Can't get iii to work properly with testthat
  ttm(100, {
    # iii <<- iii + 1
    # expect_equal(iii, ttm_i())
    expect_true(ttm_i() <= 21)
    expect_equal(100, ttm_n())
    # cat('ttm i =', ttm_i(), 'n =', ttm_n(), 'iii =', iii, '\n')
    ttm_expect_true(ttm_i() > 20)
  })
})
# rm(iii)
