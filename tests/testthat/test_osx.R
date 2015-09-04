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
  text <- "hello, world!"
  expect_equal(write_clip(text), text)
  expect_equal(system("pbpaste", intern = TRUE), text)
})


test_that("Writes multiline text successfully", {
  check_osx()
  text <- c("This", "is", "multiple", "lines")
  sep_text <- "This is multiple lines"
  expect_equal(write_clip(text), text)
  expect_equal(system("pbpaste", intern = TRUE), text)
  expect_equal(write_clip(text, collapse = " "), text)
  expect_equal(system("pbpaste", intern = TRUE), sep_text)
})

test_that("Writes data.frames with tabs", {
  tbl <- data.frame(a=c(1,2,3), b=c(4,5,6))
  tbl_string <- c("a\tb", "1\t4", "2\t5", "3\t6")
  check_osx()
  expect_equal(write_clip(tbl), tbl)
  expect_equal(system("pbpaste", intern = TRUE), tbl_string)
})

test_that("Writes matricies with tabs", {
  tbl <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
  tbl_string <- c("1\t4", "2\t5", "3\t6")
  check_osx()
  expect_equal(write_clip(tbl), tbl)
  expect_equal(system("pbpaste", intern = TRUE), tbl_string)
})

# Clear the clipboard after tests are complete
system("pbcopy < /dev/null")
