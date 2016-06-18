context("String rendering")

test_that("Render character vectors", {
  single <- "hello, world!"
  expect_equivalent(write_clip(single), single)
})

test_that("Render default multiline vectors", {
  multiline <- c("hello", "world!")
  if(sys_type() == "Windows") {
    expect_equivalent(write_clip(multiline), "hello\r\nworld!")
  } else {
    expect_equivalent(write_clip(multiline), "hello\nworld!")
  }
})

test_that("Render custom multiline vectors", {
  multiline <- c("hello", "world!")
  expect_equivalent(write_clip(multiline, breaks = ", "), "hello, world!")
})

test_that("Render default data.frames", {
  tbl <- data.frame(a=c(1,2,3), b=c(4,5,6))
  if(sys_type() == "Windows") {
    expect_equivalent(write_clip(tbl), "a\tb\r\n1\t4\r\n2\t5\r\n3\t6")
  } else {
    expect_equivalent(write_clip(tbl), "a\tb\n1\t4\n2\t5\n3\t6")
  }
})

test_that("Render custom data.frames", {
  tbl <- data.frame(a=c(1,2,3), b=c(4,5,6))
  if(sys_type() == "Windows") {
    expect_equivalent(write_clip(tbl, sep = ","), "a,b\r\n1,4\r\n2,5\r\n3,6")
  } else {
    expect_equivalent(write_clip(tbl, sep = ","), "a,b\n1,4\n2,5\n3,6")
  }
})


test_that("Render matricies", {
  tbl <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
  if(sys_type() == "Windows") {
    expect_equivalent(write_clip(tbl), "1\t4\r\n2\t5\r\n3\t6")
  } else {
    expect_equivalent(write_clip(tbl), "1\t4\n2\t5\n3\t6")
  }
})

test_that("Render custom matricies", {
  tbl <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
  if(sys_type() == "Windows") {
    expect_equivalent(write_clip(tbl, sep = ","), "1,4\r\n2,5\r\n3,6")
  } else {
    expect_equivalent(write_clip(tbl, sep = ","), "1,4\n2,5\n3,6")
  }
})



test_that("Render tables read from clipboard as data.frames", {
  contents <- c("Sepal.Length\tSepal.Width\tPetal.Length\tPetal.Width",
                "5.1\t3.5\t1.4\t0.2",
                "4.9\t3\t1.4\t0.2")
  expect_equivalent(read_clip_tbl(contents), iris[1:2, 1:4])
})

