# Helper function to read from the Windows clipboard
win_read_clip <- function() {
  utils::readClipboard()
}

# Helper function to write to the Windows clipboard
win_write_clip <- function(content, wc.opts) {

  # If no custom line separator has been specified, use Linux's default newline character: (\code{\r\n})
  sep <- ifelse(is.null(wc.opts$sep), '\r\n', wc.opts$sep)

  # Note - doesn't appear to be a way to supply eos to writeClipboard

  content <- flat_str(content, sep)
  utils::writeClipboard(content, format = 1)
  return(content)
}
