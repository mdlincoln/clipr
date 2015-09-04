# Helper function to read from the Windows clipboard
win_read_clip <- function() {
  utils::readClipboard()
}

# Helper function to write to the Windows clipboard
win_write_clip <- function(content, object_type, eos, ...) {

  .dots <- list(...)

  # If no custom line separator has been specified, use Windows's default
  # newline character '\r\n'
  .dots$collapse <- ifelse(is.null(.dots$collapse), '\r\n', .dots$collapse)

  # If no custom tab separator for tables has been specified, use Windows's
  # default tab character: '\t'
  .dots$sep <- ifelse(is.null(.dots$sep), '\t', .dots$sep)

  # Pass the object to rendering functions before writing out to the clipboard
  rendered_content <- render_object(content, object_type, .dots)
  utils::writeClipboard(content, format = 1)
  return(content)
}
