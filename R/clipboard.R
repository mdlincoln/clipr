#' Read clipboard
#'
#' Read the contents of the system clipboard into a character vector
#' @export
read_clip <- function() {
  # Determine system type
  stype <- sys_type()

  # Pass to appropriate handler function
  if(stype == "Darwin") {
    osx_read_clip()
  } else {
    stop("System not recognized!")
  }
}

#' Write clipboard
#'
#' Write a character vector to the system clipboard
#' @export
write_clip <- function(content) {
  # Determine system type
  stype <- sys_type()

  # Pass to appropriate handler function
  if(stype == "Darwin") {
    osx_write_clip(content)
  } else {
    stop("System not recognized!")
  }
}
