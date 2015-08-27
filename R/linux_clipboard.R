# Helper function to read from the Linux clipboard
#
# Requires the Linux utility 'xclip'. This function will stop with an error if xclip is not found.
# Adapted from https://github.com/mrdwab/overflow-mrdwab/blob/master/R/readClip.R
linux_read_clip <- function() {
  if (Sys.which("xclip") == "")
    stop("Clipboard on Linux requires 'xclip'. Try using:\nsudo apt-get install xclip")
  con <- pipe("xclip -o -selection clipboard")
  content <- readLines(con)
  close(con)
  return(content)
}

# Helper function to write to the OS X clipboard

# Requires the Linux utility 'xclip'. This function will stop with an error if xclip is not found.
# Adapted from https://github.com/mrdwab/overflow-mrdwab/blob/master/R/writeClip.R
linux_write_clip <- function(content) {
  if(Sys.which("xclip") == "")
    stop("Clipboard on Linux requires 'xclip'. Try using:\nsudo apt-get install xclip")
  con <- pipe("xclip -i", "w")
  writeLines(content, con=con)
  close(con)
  return(content)
}
