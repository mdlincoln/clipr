# Determine system type
sys_type <- function() {
  return(Sys.info()["sysname"])
}

#' Is the system clipboard available?
#'
#' Checks to see if the system clipboard is writeable/readable. This may be
#' useful if you are developing a package that relies on \link{clipr} and need
#' to ensure that it will skip tests on machines (e.g. CRAN, Travis) where
#' the system clipboard may not be available.
#'
#' @return boolean
#'
#' @examples
#' \dontrun{
#' # When using testthat:
#' library(testthat)
#' skip_if_not(clipr_available())
#' }
#'
#' @export
clipr_available <- function() {
  suppressWarnings(
    read_attempt <- try(read_clip(), silent = TRUE)
  )
  if (inherits(read_attempt, "try-error")) {
    return(FALSE)
  }
  suppressWarnings(
    write_attempt <- try(write_clip(read_attempt), silent = TRUE)
  )
  if (inherits(write_attempt, "try-error")) {
    return(FALSE)
  }
  TRUE
}
