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
  suppressWarnings({
    !(inherits(try(write_clip("a"), silent = TRUE), "try-error") ||
        inherits(try(read_clip(), silent = TRUE), "try-error"))
  })
}
