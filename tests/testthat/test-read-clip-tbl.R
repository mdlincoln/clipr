test_that("read_clip_tbl preserves hashes in pasted cells", {
  input <- "Header1\tHeader2\n#N/A\tVeryImportant\nR2C1\t#ff0000"
  default_comment <- formals(utils::read.table)$comment.char
  expect_equal(
    read_clip_tbl(input),
    data.frame(
      Header1 = c("#N/A", "R2C1"),
      Header2 = c("VeryImportant", "#ff0000"),
      stringsAsFactors = FALSE
    )
  )
  expect_identical(formals(utils::read.table)$comment.char, default_comment)
})

test_that("read_clip_tbl honors an explicit comment character", {
  input <- "Header1\tHeader2\n#comment row\nR2C1\tR2C2 # comment"
  expected <- data.frame(Header1 = "R2C1", Header2 = "R2C2", stringsAsFactors = FALSE)
  expect_equal(read_clip_tbl(input, comment.char = "#"), expected)
  expect_equal(read_clip_tbl(input, comment = "#"), expected)
})
