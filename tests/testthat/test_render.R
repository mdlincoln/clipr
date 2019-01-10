context("Clipr read and write")

test_that("single NA vectors don't cause error", {
  skip_if_not(is_clipr_available, skip_msg)

  expect_equivalent(write_clip(NA_character_), "NA")
  expect_warning(write_clip(NA))
  expect_warning(write_clip(NA_integer_))
  expect_warning(write_clip(NA_real_))
  expect_warning(write_clip(NA_complex_))
})

test_that("empty character in write_clip() causes no erroneous warning", {
  skip_if_not(is_clipr_available, skip_msg)

  expect_equivalent(write_clip(""), "")
  expect_warning(null_res <- write_clip(NULL))
  expect_equivalent(null_res, "")
  expect_equivalent(write_clip(character(0)), "")
  expect_warning(empty_res <- write_clip(integer(0)))
  expect_equivalent(empty_res, "")
  expect_silent(clear_clip())
})

test_that("Render character vectors", {
  skip_if_not(is_clipr_available, skip_msg)

  single <- "hello, world!"
  expect_equivalent(write_clip(single), single)
})

test_that("Render default multiline vectors", {
  skip_if_not(is_clipr_available, skip_msg)

  multiline <- c("hello", "world!")
  inv_out <- write_clip(multiline)
  if (sys_type() == "Windows") {
    expect_equivalent(inv_out, "hello\r\nworld!")
  } else {
    expect_equivalent(inv_out, "hello\nworld!")
  }
  expect_equivalent(read_clip(), multiline)
})

test_that("Render custom multiline vectors", {
  skip_if_not(is_clipr_available, skip_msg)

  multiline <- c("hello", "world!")
  inv_out <- write_clip(multiline, breaks = ", ")
  expect_equivalent(inv_out, "hello, world!")
  expect_equivalent(read_clip(), inv_out)
})

test_that("Render default data.frames", {
  skip_if_not(is_clipr_available, skip_msg)

  tbl <- data.frame(a = c(1,2,3), b = c(4,5,6))
  inv_out <- write_clip(tbl)
  if (sys_type() == "Windows") {
    expect_equivalent(inv_out, "a\tb\r\n1\t4\r\n2\t5\r\n3\t6")
  } else {
    expect_equivalent(inv_out, "a\tb\n1\t4\n2\t5\n3\t6")
  }
  expect_equal(read_clip_tbl(), tbl)
})

test_that("Render custom data.frames", {
  skip_if_not(is_clipr_available, skip_msg)

  tbl <- data.frame(a = c(1,2,3), b = c(4,5,6))
  inv_out <- write_clip(tbl, sep = ",")
  if (sys_type() == "Windows") {
    expect_equivalent(inv_out, "a,b\r\n1,4\r\n2,5\r\n3,6")
  } else {
    expect_equivalent(inv_out, "a,b\n1,4\n2,5\n3,6")
  }
  expect_equivalent(read_clip(), c("a,b", "1,4", "2,5", "3,6"))
})

test_that("Render matricies", {
  skip_if_not(is_clipr_available, skip_msg)

  tbl <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3, ncol = 2)
  inv_out <- write_clip(tbl)
  if (sys_type() == "Windows") {
    expect_equivalent(inv_out, "1\t4\r\n2\t5\r\n3\t6")
  } else {
    expect_equivalent(inv_out, "1\t4\n2\t5\n3\t6")
  }
  expect_equivalent(read_clip(), c("1\t4", "2\t5", "3\t6"))
})

test_that("Render custom matricies", {
  skip_if_not(is_clipr_available, skip_msg)

  tbl <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3, ncol = 2)
  inv_out <- write_clip(tbl, sep = ",")
  if (sys_type() == "Windows") {
    expect_equivalent(inv_out, "1,4\r\n2,5\r\n3,6")
  } else {
    expect_equivalent(inv_out, "1,4\n2,5\n3,6")
  }
  expect_equivalent(read_clip(), c("1,4", "2,5", "3,6"))
})

test_that("Render tables read from clipboard as data.frames", {
  skip_if_not(is_clipr_available, skip_msg)

  inv_out <- write_clip(iris[1:2, 1:4])
  expect_equivalent(read_clip_tbl(), iris[1:2, 1:4])
})

test_that("Tables written with rownames add extra space for column names", {
  skip_if_not(is_clipr_available, skip_msg)

  d <- matrix(1:4, 2)
  rownames(d) <- c('a','b')
  colnames(d) <- c('c','d')
  df <- data.frame(c = c(1, 2), d = c(3, 4))
  rownames(df) <- c('a', 'b')

  mat_rnames_out <- write_clip(d, row.names = TRUE, col.names = FALSE)
  df_rnames_out <- write_clip(df, row.names = TRUE, col.names = FALSE)
  if (sys_type() == "Windows") {
    expect_equivalent(mat_rnames_out, "a\t1\t3\r\nb\t2\t4")
    expect_equivalent(df_rnames_out, "a\t1\t3\r\nb\t2\t4")
  } else {
    expect_equivalent(mat_rnames_out, "a\t1\t3\nb\t2\t4")
    expect_equivalent(df_rnames_out, "a\t1\t3\nb\t2\t4")
  }

  mat_bnames_out <- write_clip(d, row.names = TRUE, col.names = TRUE)
  df_bnames_out <- write_clip(df, row.names = TRUE, col.names = TRUE)
  if (sys_type() == "Windows") {
    expect_equivalent(mat_bnames_out, "\tc\td\r\na\t1\t3\r\nb\t2\t4")
    expect_equivalent(df_bnames_out, "\tc\td\r\na\t1\t3\r\nb\t2\t4")
  } else {
    expect_equivalent(mat_bnames_out, "\tc\td\na\t1\t3\nb\t2\t4")
    expect_equivalent(df_bnames_out, "\tc\td\na\t1\t3\nb\t2\t4")
  }
})
