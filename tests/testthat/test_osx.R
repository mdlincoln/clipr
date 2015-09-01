context("OS X clipboard interaction")

check_osx <- function() {
  if(sys_type() != "Darwin")
    skip("Not on OS X")
}

test_that("Empty clipboard returns NULL with warning", {
  check_osx()
  system("pbcopy < /dev/null")
  expect_warning(read_clip())
  expect_null(read_clip())
})

test_that("Reads clipboard text successfully", {
  check_osx()
  system("echo 'hello, world!' | pbcopy")
  expect_equal(read_clip(), "hello, world!")
})

test_that("Writes clipboard text successfully", {
  check_osx()
  expect_equal(write_clip("hello, world!"), "hello, world!")
  expect_equal(system("pbpaste", intern = TRUE), "hello, world!")
})
