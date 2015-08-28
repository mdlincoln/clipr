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
linux_write_clip <- function(content) {
  if (Sys.which("xclip") != "") {
    con <- pipe("xclip -i -sel p -f | xclip -i -sel c", "w")
  } else if (Sys.which("xsel") != "") {
    con <- pipe("xsel -b", "w")
  } else {
    notify_no_cb()
  }
  writeChar(content, con = con)
  close(con)
  return(content)
}
