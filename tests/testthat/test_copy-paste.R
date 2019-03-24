context("check if an object equals an copied-then-pasted object")


test_that("numeric data.frame without row.names", {
  skip_if_not(is_clipr_available, skip_msg)
  tbl <- data.frame(a = c(1,2,3), b = c(4,5,6))

  copy_table(tbl)
  after_paste <- paste_table()

  expect_equal(tbl, after_paste)
})


test_that("numeric data.frame with other separaters", {
  skip_if_not(is_clipr_available, skip_msg)
  tbl <- data.frame(a = c(1,2,3), b = c(4,5,6))

  # space
  copy_table(tbl, sep = " ")
  after_paste <- paste_table(sep = " ")
  expect_equal(tbl, after_paste)

  # comma
  copy_table(tbl, sep = ",")
  after_paste <- paste_table(sep = ",")
  expect_equal(tbl, after_paste)
})


test_that("numeric data.frame with row.names", {
  skip_if_not(is_clipr_available, skip_msg)
  tbl <- data.frame(a = c(1,2,3), b = c(4,5,6), row.names = c("A", "B", "C"))

  copy_table(tbl, row.names = TRUE)
  after_paste <- paste_table(row.names = 1)

  expect_equal(tbl, after_paste)
})


test_that("numeric data.frame with missing values", {
  skip_if_not(is_clipr_available, skip_msg)
  tbl <- data.frame(a = c(1,2,3), b = c(NA,5,6))

  # Two cases can be read by paste_table() by default
  copy_table(tbl)
  after_paste <- paste_table()
  expect_equal(tbl, after_paste)

  copy_table(tbl, na = "NA")
  after_paste <- paste_table()
  expect_equal(tbl, after_paste)

  # Customized na string
  copy_table(tbl, na = "missing")
  after_paste <- paste_table(na.strings = "missing")
  expect_equal(tbl, after_paste)
})


test_that("data.frame with quoted characters", {
  skip_if_not(is_clipr_available, skip_msg)
  tbl <- data.frame(a = c(1,2,3), b = c("\'a\'","\"b\"","c"),
                    stringsAsFactors = FALSE)

  # quoted text works by default
  copy_table(tbl)
  after_paste <- paste_table()
  expect_equal(tbl, after_paste)

  # if the column itself is quoted, needs to set quote in paste_table
  copy_table(tbl, quote = TRUE)
  after_paste <- paste_table(quote = "\"")
  expect_equal(tbl, after_paste)
})


