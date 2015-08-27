#' Helper function to read from the OS X clipboard
#' @references https://github.com/jennybc/reprex/blob/master/R/clipboard.R
osx_read_clip <- function() {
  con <- pipe("pbpaste")
  content <- scan(con, what = character(), sep = "\n",
                  blank.lines.skip = FALSE, quiet = TRUE)
  close(con)
  content
}

#' Helper function to write to the OS X clipboard
#' @references https://github.com/jennybc/reprex/blob/master/R/clipboard.R
osx_write_clip <- function(content) {
  con <- pipe("pbcopy")
  cat(content, file = con, sep = "\n")
  close(con)
}