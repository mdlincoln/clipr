#' Read clipboard
#'
#' Read the contents of the system clipboard into a character vector.
#'
#' @return A character vector with the contents of the clipboard. If the system
#'   clipboard is empty, returns NULL
#'
#' @note [read_clip()] will not try to guess at how to parse copied text. If
#'   you are copying tabular data, it is suggested that you use
#'   [read_clip_tbl()].
#'
#' @examples
#' \dontrun{
#' clip_text <- read_clip()
#' }
#'
#' @export
read_clip <- function() {

  # Determine system type
  sys.type <- sys_type()

  # Use the appropriate handler function
  chosen_read_clip <- switch(sys.type,
        "Darwin" = osx_read_clip,
        "Windows" = win_read_clip,
        X11_read_clip
  )

  content <- chosen_read_clip()

  if (length(content) == 0) {
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
#' @param object_type [write_clip()] tries to be smart about writing objects in a
#'   useful manner. If passed a data.frame or matrix, it will format it using
#'   [write.table()] for pasting into an external spreadsheet program.
#'   It will otherwise coerce the object to a character vector. `auto` will
#'   check the object type, otherwise `table` or `character` can be
#'   explicitly specified.
#' @param breaks The separator to be used between each element of the character
#'   vector being written. `NULL` defaults to writing system-specific line
#'   breaks between each element of a character vector, or each row of a table.
#' @param eos The terminator to be written after each string, followed by an
#'   ASCII `nul`. Defaults to no terminator character, indicated by
#'   `NULL`.
#' @param return_new If true, returns the rendered string; if false, returns the
#'   original object
#' @param allow_non_interactive By default, clipr will throw an error if run in
#'   a non-interactive session. Set the environment variable
#'   `CLIPR_ALLOW=TRUE` in order to override this behavior, however see the
#'   advisory below before doing so.
#' @param ... Custom options to be passed to [write.table()] (if `x` is a
#'   table-like). Defaults to sane line-break and tab standards based on the
#'   operating system. By default, this will use `col.names = TRUE` if the table
#'   object has column names, and `row.names = TRUE` if the object has row names
#'   other than `c("1", "2", "3"...)`. Override these defaults by passing
#'   arguments here.
#'
#' @note On X11 systems, [write_clip()] will cause either xclip (preferred) or
#'   xsel to be called. Be aware that, by design, these processes will fork into
#'   the background. They will run until the next paste event, when they will
#'   then exit silently. (See the man pages for
#'   [xclip](https://linux.die.net/man/1/xclip) and
#'   [xsel](http://www.vergenet.net/~conrad/software/xsel/xsel.1x.html#notes)
#'   for more on their behaviors.) However, this means that even if you
#'   terminate your R session after running [write_clip()], those processes will
#'   continue until you access the clipboard via another program. This may be
#'   expected behavior for interactive use, but is generally undesirable for
#'   non-interactive use. For this reason you must not run [write_clip()] on
#'   CRAN, as the nature of xsel [has caused issues in the
#'   past](https://github.com/mdlincoln/clipr/issues/38).
#'
#'   Call [clipr_available()] to safely check whether the clipboard is readable
#'   and writable.
#'
#' @return Invisibly returns the original object
#'
#' @examples
#' \dontrun{
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
#' }
#'
#' @export
write_clip <- function(content, object_type = c("auto", "character", "table"),
                       breaks = NULL, eos = NULL, return_new = FALSE,
                       allow_non_interactive = Sys.getenv("CLIPR_ALLOW", interactive()), ...) {
  if (allow_non_interactive != "TRUE") warn_interactive()

  object_type <- match.arg(object_type)
  # Determine system type
  sys.type <- sys_type()

  # Choose an operating system-specific function (stop with error if not
  # recognized)
  chosen_write_clip <- switch(sys.type,
                          "Darwin" = osx_write_clip,
                          "Windows" = win_write_clip,
                          X11_write_clip
  )

  # Supply the clipboard content to write and options list to this function
  invisible(chosen_write_clip(content, object_type, breaks, eos, return_new, ...))
}

#' Clear clipboard
#'
#' Clear the system clipboard.
#'
#' @param \ldots Pass other options to [write_clip()].
#'
#' @note This is a wrapper function for `write_clip("")`
#'
#' @export
clear_clip <- function(...) {
  write_clip(content = "", ...)
}

#' Write contents of the last R expression to the clipboard
#'
#' @param \ldots Pass other options to [write_clip()].
#'
#' @note This is a wrapper function for `write_clip(.Last.value)`
#' @export
write_last_clip <- function(...) {
  write_clip(.Last.value, ...)
}
