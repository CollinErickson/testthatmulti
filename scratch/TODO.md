# TODO

* Fix working inside of test_that

* Do nested ttms work?

* ttm_expect_is

* Test coverage

* Don't rerun tests that passed a previous iteration? Need to check that it
still passes (otherwise user would have separated). But current way has variable
test count (can be 2x test count if fails first time then repeats).

* What if they aren't called inside of ttm? Should they give error? Or just run
testthat version?

* Can I remove env mess from exptrue now that env mess is in ttm?
