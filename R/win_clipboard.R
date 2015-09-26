# Helper function to read from the Windows clipboard
win_read_clip <- function() {
  utils::readClipboard()
}

# Helper function to write to the Windows clipboard
win_write_clip <- function(content, object_type, breaks, eos, return_new, ...) {

  .dots <- list(...)

  # If no custom line separator has been specified, use Windows's default
  # newline character '\r\n'
  breaks <- ifelse(is.null(breaks), '\r\n', breaks)

  # If no custom tab separator for tables has been specified, use Windows's
  # default tab character: '\t'
  .dots$sep <- ifelse(is.null(.dots$sep), '\t', .dots$sep)

  # Pass the object to rendering functions before writing out to the clipboard
  rendered_content <- render_object(content, object_type, breaks, .dots)
  utils::writeClipboard(rendered_content, format = 1)
  if(return_new) {
    rendered_content
  } else {
    content
  }
}
