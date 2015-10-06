#' Read clipboard
#'
#' Read the contents of the system clipboard into a character vector.
#'
#' @return A character vector with the contents of the clipboard. If the system
#'   clipboard is empty, returns NULL
#'
#' @note \code{read_clip} will not try to guess at how to parse copied text. If
#'   you are copying tabular data, it is suggested that you use
#'   \code{\link[readr]{read_delim}} or one of its sibling functions from the
#'   readr package (\url{https://cran.r-project.org/package=readr}) to coax the
#'   text into a data frame.
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
#' @param content An object to be written to the system clipboard.
#' @param object_type write_clip() tries to be smart about writing objects in a
#'   useful manner. If passed a data.frame or matrix, it will format it using
#'   \code{\link{write.table}} for pasting into an external spreasheet program.
#'   It will otherwise coerce the object to a character vector. \code{auto} will
#'   check the object type, otherwise \code{table} or \code{character} can be
#'   explicitly specified.
#' @param breaks The separator to be used between each element of the character
#'   vector being written. \code{NULL} defaults to writing system-specific line
#'   breaks between each element of a character vector, or each row of a table.
#' @param eos The terminator to be written after each string, followed by an
#'   ASCII \code{nul}. Defaults to no terminator character, indicated by
#'   \code{NULL}.
#' @param return_new If true, returns the rendered string; if false, returns the
#'   original object
#' @param ... Custom options to be passed to \code{\link{write.table}} (if the
#'   object is a table-like) Defaults to
#'   sane line-break and tab standards based on the operating system.
#'
#' @return Invisibly returns the original object
#'
#' @examples
#' text <- "Write to clipboard"
#' write_clip(text)
#'
#' multiline <- c("Write", "to", "clipboard")
#' write_clip(multiline)
#' # Write
#' # to
#' # clipboard
#'
#' write_clip(multiline, breaks = ",")
#' # write,to,clipboard
#'
#' tbl <- data.frame(a=c(1,2,3), b=c(4,5,6))
#' write_clip(tbl)
#' @export
write_clip <- function(content, object_type = c("auto", "character", "table"), breaks = NULL, eos = NULL, return_new = TRUE, ...) invisible({
  object_type <- match.arg(object_type)
  # Determine system type
  sys.type <- sys_type()

  # Choose an operating system-specific function (stop with error if not recognized)
  chosen_write_clip <- switch(sys.type,
                          "Darwin" = osx_write_clip,
                          "Windows" = win_write_clip,
                          linux_write_clip
  )

  # Supply the clipboard content to write and options list to this function
  chosen_write_clip(content, object_type, breaks, eos, return_new, ...)
})

#' Clear clipboard
#'
#' Clear the system clipboard.
#'
#' @note This is a simple wrapper function for write_clip("")
#'
#' @export
clear_clip <- function() {
  # pipe() sends a warning when writing an empty string. Since that is exatly
  # what we want it to do, we will suppress that warning
  suppressWarnings(write_clip(""))
}
