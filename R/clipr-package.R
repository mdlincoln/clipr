#' clipr: Read and Write from the System Clipboard
#'
#' Simple utility functions to read from and write to the Windows, OS X, and X11
#' clipboards.
#'
#' The basic functions [read_clip()] and [write_clip()] wrap
#' platform-specific functions for writing values from R to the system
#' clipboard. [read_clip_tbl()] will attempt to process the clipboard
#' content like a table copied from a spreadsheet program.
#'
#' [clipr_available()] is useful when building packages that
#' depend on clipr functionality.
#'
#' @docType package
#' @name clipr
NULL
