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
osx_write_clip <- function(content, object_type, breaks, eos, return_new, ...) {
  .dots <- list(...)
  con <- pipe("pbcopy")

  write_nix(content, object_type, breaks, eos, return_new, con, .dots)
}

# The same content rendering and writing steps are used in both OS X and Linux,
# just with different connection objects
write_nix <- function(content, object_type, breaks, eos, return_new, con, .dots) {
  # If no custom line separator has been specified, use Unix's default newline
  # character '\n'
  breaks <- ifelse(is.null(breaks), '\n', breaks)

  # If no custom tab separator for tables has been specified, use Unix's default
  # tab character: '\t'
  .dots$sep <- ifelse(is.null(.dots$sep), '\t', .dots$sep)

  # Pass the object to rendering functions before writing out to the clipboard
  rendered_content <- render_object(content, object_type, breaks, .dots)

  # Suppress pipe() warning when writing an empty string with a NULL string
  # ending.
  if (identical(rendered_content, "")) {
    suppressWarnings(writeChar(rendered_content, con = con, eos = eos))
  } else {
    writeChar(rendered_content, con = con, eos = eos)
  }

  close(con)

  if (return_new) {
    rendered_content
  } else {
    content
  }
}
