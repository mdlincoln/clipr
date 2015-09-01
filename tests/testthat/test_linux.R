context("Linux clipboard interaction")

check_linux <- function() {
  if(sys_type() != "Linux")
    skip("Not on Linux")
}

test_that("Stop if xclip is not installed", {
  check_linux()
})

test_that("Empty clipboard returns NULL with warning", {
  check_linux()
  system("echo off | clip")
  expect_warning(read_clip())
  expect_null(read_clip())
})

test_that("Reads clipboard text successfully", {
  check_linux()
  system("echo 'hello, world!' | clip")
  expect_equal(read_clip(), "hello, world!")
})

test_that("Writes clipboard text successfully", {
  check_linux()
  expect_equal(write_clip("hello, world!"), "hello, world!")
  expect_equal(system("clip"), "hello, world!")
})
