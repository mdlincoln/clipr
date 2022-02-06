.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Welcome to clipr. See ?write_clip for advisories on writing to the clipboard in R.")
}

# Determine system type
sys_type <- function() {
  return(Sys.info()["sysname"])
}

#' Is the system clipboard available?
#'
#' Checks to see if the system clipboard is write-able/read-able. This may be
#' useful if you are developing a package that relies on clipr and need to
#' ensure that it will skip tests on machines (e.g. CRAN, Travis) where the
#' system clipboard may not be available.
#'
#' @note This will automatically return `FALSE`, without even performing the
#'   check, if you are running in a non-interactive session. If you must call
#'   this non-interactively, be sure to call using
#'   `clipr_available(allow_non_interactive = TRUE)`, or by setting the
#'   environment variable `CLIPR_ALLOW=TRUE`. **Do not attempt to run
#'   clipr non-interactively on CRAN; this will result in a failed build!**
#'
#' @param \ldots Pass other options to [`write_clip()`]. Generally only used to
#'   pass the argument `allow_non_interactive_use = TRUE`.
#'
#' @return `clipr_available` returns a boolean value.
#'
#' @examples
#' \dontrun{
#' # When using testthat:
#' library(testthat)
#' skip_if_not(clipr_available())
#' }
#'
#' @export
clipr_available <- function(...) {
  clipr_results_check(clipr_available_handler(...))
}

#' @rdname clipr_available
#'
#' @return Prints an informative message to the console with
#'   software and system configuration requirements if clipr is not available
#'   (invisibly returns the same string)
#'
#' @export
dr_clipr <- function(...) {
  res <- clipr_available_handler(...)

  if (clipr_results_check(res)) {
    msg <- msg_clipr_available()
  } else {
    msg <- attr(res$write, which = "condition", exact = TRUE)$message
  }

  message(msg)
  invisible(msg)
}

clipr_available_handler <- function(...) {
  # Do not even do a check unless user has explicitly set CLIPR_ALLOW
  if (!interactive()) {
    clipr_allow <- as.logical(Sys.getenv("CLIPR_ALLOW", "FALSE"))
    if (!clipr_allow) {
      fake_write_attempt <- try(stop("CLIPR_ALLOW has not been set, so clipr will not run interactively"), silent = TRUE)
      return(list(write = fake_write_attempt))
    }
  }
  suppressWarnings({
    read_attempt <- try(read_clip(...), silent = TRUE)
    write_attempt <- try(write_clip(read_attempt, ...), silent = TRUE)
  })
  return(list(read = read_attempt, write = write_attempt))
}

clipr_results_check <- function(res) {
  if (inherits(res$write, "try-error")) return(FALSE)
  if (inherits(res$read, "try-error")) return(FALSE)
  TRUE
}

msg_clipr_available <- function() "clipr has read/write access to the system clipboard!"

msg_no_clipboard <- function() "Clipboard on X11 requires 'xclip' (recommended) or 'xsel'; Clipboard on Wayland requires 'wl-copy' and 'wl-paste'."

msg_no_display <- function() "Clipboard on X11 requires that the DISPLAY envvar be configured."

msg_interactive <- function() "To run write_clip() in non-interactive mode, either call write_clip() with allow_non_interactive = TRUE, or set the environment variable CLIPR_ALLOW=TRUE"

error_interactive <- function() {
  stop(msg_interactive())
}
