context("Windows clipboard interaction")

check_win <- function() {
  if(sys_type() != "Windows")
    skip("Not on Windows")
}

test_that("Empty clipboard returns NULL with warning", {
  check_win()
  system("echo off | clip")
  expect_warning(read_clip())
  expect_null(read_clip())
})

test_that("Reads clipboard text successfully", {
  check_win()
  system("echo 'hello, world!' | clip")
  expect_equal(read_clip(), "hello, world!")
})

test_that("Writes clipboard text successfully", {
  check_win()
  expect_equal(write_clip("hello, world!"), "hello, world!")
  expect_equal(read_clip(), "hello, world!")
})
