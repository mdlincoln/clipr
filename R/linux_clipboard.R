# Determine if system has 'xclip' installed
has_xclip <- function() {
  nzchar(Sys.which("xclip"))
}

# Determine if system has 'xsel' installed
has_xsel <- function() {
  nzchar(Sys.which("xsel"))
}

# Stop read/write and return an error of missing clipboard software.
notify_no_cb <- function() {
  stop("Clipboard on Unix-like systems requires 'xclip' (recommended) or 'xsel'.",
       call.=FALSE)
}

# Helper function to read from the Linux clipboard
#
# Requires the Linux utility 'xclip' or 'xsel'. This function will stop with an error if neither is found.
# Adapted from: https://github.com/mrdwab/overflow-mrdwab/blob/master/R/readClip.R
#          and: https://github.com/jennybc/reprex/blob/master/R/clipboard.R
linux_read_clip <- function() {
  if (has_xclip()) {
    con <- pipe("xclip -o -selection clipboard")
  } else if (has_xsel()) {
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
linux_write_clip <- function(content, object_type, breaks, eos, return_new, ...) {
  if (has_xclip()) {
    con <- pipe("xclip -i -sel p -f | xclip -i -sel c", "w")
  } else if (has_xsel()) {
    con <- pipe("xsel -b", "w")
  } else {
    notify_no_cb()
  }

  .dots <- list(...)

  # If no custom line separator has been specified, use Unix's default newline
  # character '\n'
  breaks <- ifelse(is.null(breaks), '\n', breaks)

  # If no custom tab separator for tables has been specified, use Unix's default
  # tab character: '\t'
  .dots$sep <- ifelse(is.null(.dots$sep), '\t', .dots$sep)

  # Pass the object to rendering functions before writing out to the clipboard
  rendered_content <- render_object(content, object_type, breaks, .dots)
  writeChar(rendered_content, con = con, eos = eos)
  close(con)
  if(return_new) {
    rendered_content
  } else {
    content
  }
}
