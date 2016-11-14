#' clipr: Read and Write from the System Clipboard
#'
#' Simple utility functions to read from and write to the Windows, OS X, and X11
#' clipboards.
#'
#' The basic functions \code{\link{read_clip}} and \code{\link{write_clip}} wrap
#' platform-specific functions for writing values from R to the system
#' clipboard. \code{\link{read_clip_tbl}} will attempt to process the clipboard
#' content like a table copied from a spreadsheet program.
#'
#' \code{\link{clipr_available}} is useful when buildling packages that
#' depend on \link{clipr} functionality.
#'
#' @docType package
#' @name clipr
NULL
