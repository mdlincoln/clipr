# Helper function to read from the Windows clipboard
win_read_clip <- function() {
  readClipboard()
}

# Helper function to write to the Windows clipboard
win_write_clip <- function(content) {
  writeClipboard(object, format = 1)
  return(content)
}
