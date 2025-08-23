# TODO

* Fix working inside of test_that

* Do nested ttms work?

* ttm_expect_is

* Test coverage

* ttm_counter(): to get the iteration

* Allow for referring to outside vars

* Don't rerun tests that passed a previous iteration? Need to check that it
still passes (otherwise user would have separated). But current way has variable
test count (can be 2x test count if fails first time then repeats).

* If I use a var named expr/n/verbose/i_ttm, does it cause issue? If yes,
rename them to be very obscure and unlikely to clash.
