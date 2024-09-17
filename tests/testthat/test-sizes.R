context("board size limits")

mirror <- function(length) {
  longstr <- paste0(sample(letters, length, replace = TRUE), collapse = "")
  invisible(write_clip(longstr))
  readstr <- read_clip()
  expect_equal(readstr, longstr)
  return(TRUE)
}

test_that("large sizes of content can be copied losslessly", {
  lapply(10^(1:8), mirror)
})
