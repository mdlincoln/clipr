# Helper function to read from the Windows clipboard
win_read_clip <- function() {
  # On R >= 4.2 (built with UCRT), the default encoding is UTF-8 even on Windows.
  # To avoid the encoding mismatch garbles texts, use 13 (CF_UNICODETEXT),
  format <- if (identical(R.version$crt, "ucrt")) 13 else 1

  utils::readClipboard(format = format)
}

# Helper function to write to the Windows clipboard
win_write_clip <- function(content, object_type, breaks, eos, return_new, ...) {
  format <- if (identical(R.version$crt, "ucrt")) 13 else 1

  .dots <- list(...)

  # If no custom line separator has been specified, use Windows's default
  # newline character '\r\n'
  breaks <- ifelse(is.null(breaks), '\r\n', breaks)

  # If no custom tab separator for tables has been specified, use Windows's
  # default tab character: '\t'
  .dots$sep <- ifelse(is.null(.dots$sep), '\t', .dots$sep)

  # Pass the object to rendering functions before writing out to the clipboard
  rendered_content <- render_object(content, object_type, breaks, .dots)
  utils::writeClipboard(rendered_content, format = format)
  if (return_new) {
    rendered_content
  } else {
    content
  }
}
