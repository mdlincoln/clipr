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
osx_write_clip <- function(content, wc.opts) {
  con <- pipe("pbcopy")
  
  # If no custom line separator has been specified, use Unix's default newline character: (\code{\n})
  sep <- ifelse(is.null(wc.opts$sep), '\n', wc.opts$sep)
  
  # If no custom 'end of string' character is specified, then by default assign \code{eos = NULL},
  # thus sending text to the clipboard without a terminator character.
  eos <- wc.opts$eos
  # Note - works the same as ifelse(is.null,NULL,wc.opts$eos)
  
  content <- flat_str(content, sep)
  writeChar(content, con = con, eos = eos)
  close(con)
  return(content)
}
