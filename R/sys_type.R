# Determine system type
sys_type <- function() {
  return(Sys.info()["sysname"])
}

#' Is the system clipboard available?
#'
#' Checks to see if the system clipboard is writeable/readable.
#'
#' @return boolean
#'
#' @export
is_clipr_available <- function() {
  !inherits(try(write_clip("a"), silent = TRUE), "try-error")
}
