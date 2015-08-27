#' Read clipboard
#'
#' Read the contents of the system clipboard into a character vector
#'
#' @return A character vector with the contents of the clipboard.
#'
#' @export
read_clip <- function() {
  # Determine system type
  stype <- sys_type()

  # Pass to appropriate handler function
  if(stype == "Darwin") {
    osx_read_clip()
  } else if(stype == "Windows") {
    win_read_clip()
  } else if(stype == "Linux") {
    linux_read_clip()
  } else {
    stop("System not recognized!")
  }
}

#' Write clipboard
#'
#' Write a character vector to the system clipboard
#'
#' @param content A character vector to be written to the system clipboard
#' @return On successfully writing the input to the clipboard, this function
#'   returns the same input for use in piped operations.
#' @export
write_clip <- function(content) {
  # Determine system type
  stype <- sys_type()

  # Pass to appropriate handler function
  if(stype == "Darwin") {
    osx_write_clip(content)
  } else if(stype == "Windows") {
    win_write_clip(content)
  } else if(stype == "Linux") {
    linux_write_clip()
  } else {
    stop("System not recognized!")
  }
}
