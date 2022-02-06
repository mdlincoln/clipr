# Determine if a given utility is installed AND accessible
# Takes a character vector whose first element is the name of the
# utility executable and whose subsequent elements are command-line
# arguments to the utility for the test run.
has_util <- function(util_test) {
  if (nzchar(Sys.which(util_test[1]))) {
    # If utility is accessible, check that DISPLAY can be opened.
    try_res <- tryCatch(system2(util_test[1], util_test[-1], stdout = TRUE, stderr = TRUE),
                        error = function(c) {
                          print(c)
                          return(FALSE)
                        },
                        warning = function(c) {
                          print(c)
                          return(FALSE)
                        }
    )

    # In the case of an error/warning on trying the function, then the util is
    # not available
    if (identical(try_res, FALSE)) {
      notify_no_display()
    } else {
      TRUE
    }
  } else {
    FALSE
  }
}

# Determine if system has 'xclip' installed AND it's accessible
has_xclip <- function() has_util(c("xclip", "-o", "-selection", "clipboard"))

# Determine if system has 'xsel' installed
has_xsel <- function() has_util(c("xsel", "--clipboard", "--output"))

# Determine if system has both 'wl-paste' and 'wl-copy' installed
has_wl_clipboard <- function() has_wl_paste() & has_wl_copy()

# Determine if system has 'wl-paste' installed
has_wl_paste <- function() has_util(c("wl-paste", "--primary"))

# Determine if system has 'wl-paste' installed
has_wl_copy <- function() has_util(c("wl-copy", "--primary"))

# Stop read/write and return an error of missing clipboard software.
notify_no_cb <- function() {
  stop(msg_no_clipboard(), call. = FALSE)
}

notify_no_display <- function() {
  stop(msg_no_display(), call. = FALSE)
}

# Helper function to read from the X11 clipboard
#
# Requires the utility 'xclip' or 'xsel' when using X11, or 'wl-paste' when
# using Wayland. This function will stop with an error if neither is found.
# Adapted from:
# https://github.com/mrdwab/overflow-mrdwab/blob/master/R/readClip.R and:
# https://github.com/jennybc/reprex/blob/master/R/clipboard.R
X11_read_clip <- function() {
  if (has_xclip()) {
    con <- pipe("xclip -o -selection clipboard")
  } else if (has_xsel()) {
    con <- pipe("xsel --clipboard --output")
  } else if (has_wl_paste()) {
    con <- pipe("wl-paste")
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
# Requires the utility 'xclip' or 'xsel' when using X11, or 'wl-copy' when using
# Wayland. This function will stop with an error if neither is found. Adapted
# from https://github.com/mrdwab/overflow-mrdwab/blob/master/R/writeClip.R
#
# Targets "primary" and "clipboard" clipboards if using xclip, see:
# http://unix.stackexchange.com/a/69134/89254
X11_write_clip <- function(content, object_type, breaks, eos, return_new, ...) {
  if (has_xclip()) {
    con <- pipe("xclip -i -sel p -f | xclip -i -sel c", "w")
  } else if (has_xsel()) {
    con <- pipe("xsel --clipboard --input", "w")
  } else if (has_wl_copy()) {
    con <- pipe("wl-copy", "w")
  } else {
    notify_no_cb()
  }

  .dots <- list(...)

  write_nix(content, object_type, breaks, eos, return_new, con, .dots)
}
