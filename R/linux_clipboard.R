# Function to stop the read/write and return an error of missing clipboard software.
notify_no_cb <- function() {
  stop("Clipboard on Linux requires 'xclip' (recommended) or 'xsel'. Try using:\nsudo apt-get install xclip",
       call.=FALSE)
}

# Helper function to read from the Linux clipboard
#
# Requires the Linux utility 'xclip' or 'xsel'. This function will stop with an error if neither is found.
# Adapted from: https://github.com/mrdwab/overflow-mrdwab/blob/master/R/readClip.R
#          and: https://github.com/jennybc/reprex/blob/master/R/clipboard.R
linux_read_clip <- function() {
  if (Sys.which("xclip") != "") {
    con <- pipe("xclip -o -selection clipboard")
  } else if (Sys.which("xsel") != "") {
    con <- pipe("xsel --clipboard")
  } else {
    notify_no_cb()
  }
  content <- scan(con, what = character(), sep = "\n",
                  blank.lines.skip = FALSE, quiet = TRUE) 
  close(con)
  return(content)
}

# Helper function to write to the Linux clipboard
#
# Requires the Linux utility 'xclip' or 'xsel'. This function will stop with an error if neither is found.
# Adapted from https://github.com/mrdwab/overflow-mrdwab/blob/master/R/writeClip.R
#
# Targets "primary" and "clipboard" clipboards if using xclip, see: http://unix.stackexchange.com/a/69134/89254
linux_write_clip <- function(content, wc.opts) {
  if (Sys.which("xclip") != "") {
    con <- pipe("xclip -i -sel p -f | xclip -i -sel c", "w")
  } else if (Sys.which("xsel") != "") {
    con <- pipe("xsel -b", "w")
  } else {
    notify_no_cb()
  }
  
  # If no custom line separator has been specified, use Unix's default newline character: (\code{\n})
  sep <- ifelse(is.null(wc.opts$sep), '\n', wc.opts$sep)
  
  # If no custom 'end of string' character is specified, then by default assign \code{eos = NULL}
  # Text will be sent to the clipboard without a terminator character.
  eos <- wc.opts$eos
  # Note - works the same as ifelse(is.null,NULL,wc.opts$eos)
  
  content <- flat_str(content, sep)
  writeChar(content, con = con, eos = eos)
  close(con)
  return(content)
}
