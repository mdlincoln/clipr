# Helper function to read from the OS X clipboard
# Adapted from https://github.com/jennybc/reprex/blob/master/R/clipboard.R
osx_read_clip <- function() {
  con <- pipe("pbpaste")
  content <- scan(con, what = character(), sep = "\n",
                  blank.lines.skip = FALSE, quiet = TRUE)
  close(con)
  return(content)
}

# Helper function to write to the OS X clipboard
# Adapted from https://github.com/jennybc/reprex/blob/master/R/clipboard.R
osx_write_clip <- function(content) {
  con <- pipe("pbcopy")
  writeChar(content, con = con)
  close(con)
  return(content)
}
