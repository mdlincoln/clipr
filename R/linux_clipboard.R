# Determine if a given utility is installed AND accessible
# Takes a character vector whose first element is the name of the
# utility executable and whose subsequent elements are command-line
# arguments to the utility for the test run.
has_util <- function(util_test) {
  if (nzchar(Sys.which(util_test[1]))) {
    # If utility is accessible, check that DISPLAY can be opened.
    try_res <- tryCatch(system2(util_test[1], util_test[-1], stdout = TRUE, stderr = TRUE),
                        error = function(c) FALSE,
                        warning = function(c) FALSE)

    # In the case of an error/warning on trying the function, then the util is
    # not available
    if (identical(try_res, FALSE)) {
      notify_no_display()
    } else {
      TRUE
    }
  } else {
    notify_no_cb()
  }
}

# Determine if system has 'xclip' installed AND it's accessible
has_xclip <- function() has_util(c("xclip", "-o", "-selection", "clipboard"))

# Determine if system has 'xsel' installed
has_xsel <- function() has_util(c("xsel", "--clipboard"))

# Stop read/write and return an error of missing clipboard software.
notify_no_cb <- function() {
  stop("Clipboard on X11 requires 'xclip' (recommended) or 'xsel'.",
       call. = FALSE)
}

notify_no_display <- function() {
  stop("Clipboard on X11 requires that the DISPLAY envvar be configured.",
       call. = FALSE)
}

# Helper function to read from the X11 clipboard
#
# Requires the utility 'xclip' or 'xsel'. This function will stop with an error
# if neither is found. Adapted from:
# https://github.com/mrdwab/overflow-mrdwab/blob/master/R/readClip.R and:
# https://github.com/jennybc/reprex/blob/master/R/clipboard.R
X11_read_clip <- function() {
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

# Helper function to write to the X11 clipboard
#
# Requires the utility 'xclip' or 'xsel'. This function will stop with an error
# if neither is found. Adapted from
# https://github.com/mrdwab/overflow-mrdwab/blob/master/R/writeClip.R
#
# Targets "primary" and "clipboard" clipboards if using xclip, see:
# http://unix.stackexchange.com/a/69134/89254
X11_write_clip <- function(content, object_type, breaks, eos, return_new, ...) {
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
  if (return_new) {
    rendered_content
  } else {
    content
  }
}
