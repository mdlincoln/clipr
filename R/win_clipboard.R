# Helper function to read from the Windows clipboard
win_read_clip <- function() {
  utils::readClipboard()
}

# Helper function to write to the Windows clipboard
win_write_clip <- function(content) {
  utils::writeClipboard(content, format = 1)
  return(content)
}
