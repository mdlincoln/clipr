#' Read clipboard
#'
#' Read the contents of the system clipboard into a character vector.
#'
#' @return A character vector with the contents of the clipboard. If the system
#'   clipboard is empty, returns NULL
#'
#' @examples
#' clip_text <- read_clip()
#'
#' @export
read_clip <- function() {
  # Determine system type
  sys.type <- sys_type()

  # Use the appropriate handler function
  chosen_read_clip <- switch(sys.type,
        "Darwin" = osx_read_clip,
        "Windows" = win_read_clip,
        linux_read_clip
  )

  content <- chosen_read_clip()

  if(length(content) == 0) {
    warning("System clipboard contained no readable text. Returning NULL.")
    return(NULL)
  }

  content
}

#' Write clipboard
#'
#' Write a character vector to the system clipboard
#'
#' @param content A character vector to be written to the system clipboard.
#'                Anything not a character vector will be coerced to one.
#' @param sep A character vector (string) to join each element in content using.
#'            Defaults to the operating system's newline character, indicated by \code{NULL}.
#' @param eos The terminator to be written after each string, followed by an ASCII \code{nul}.
#'            Defaults to no terminator character, indicated by \code{NULL}.
#' @return On successfully writing the input to the clipboard, this function
#'   returns the same input for use in piped operations.
#'
#' @examples
#' text <- "Write to clipboard"
#' write_clip(text)
#'
#' multiline <- c("Write", "to", "clipboard")
#' write_clip(multiline, sep = "\n")
#' @export
write_clip <- function(content, sep = NULL, eos = NULL) invisible({
  # Determine system type
  sys.type <- sys_type()
  # Initialise an empty list to pass options on to OS-specific functions
  wc.opts <- list()
  # If they are non-NULL, they will be stored in the list
  wc.opts$sep <- sep
  wc.opts$eos <- eos

  # Choose an operating system-specific function (stop with error if not recognized)
  chosen_write_clip <- switch(sys.type,
                          "Darwin" = osx_write_clip,
                          "Windows" = win_write_clip,
                          linux_write_clip
                         )

  # Supply the clipboard content to write and options list to this function
  chosen_write_clip(content, wc.opts)
})
