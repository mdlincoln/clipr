# This script contains higher-level wrapper functions that are based on
# read_clip and write_clip.
#
# The verbs in the function names are chosen to be copy/paste instead of
# read/write. This has several benefits:
#
# 1. It distinguishes this set of functions from the lower-level ones that they
# base on.
# 2. It masks the lower-level details of the action. Users don't have to be
# aware that values are "written" to the system clipboard. They just need to
# "copy" it.
#
# For the same reasons, I didn't use "clip" in the names.
#
#
# Another behavior that's different from the lower level functions is that it
# passes arguments explicitly. write_clip needs to work for both character and
# table. And they take different arguments (table takes na, sep, quote, etc).
# write_clip uses dots in order to be flexible in taking arguments, but it masks
# the arguments from users. This can be tricky to figure out. For example, it
# sets col.names implicitly depending on whether class is data.frame or matrix.
#
# Here the frequently used arguments are passed explicitly, with the defaults
# respecting what was set implicitly in render_table and write_clip.
#
# The first argument is named "x" instead of "table" or something else because
# the inherited parameter document from utils::write.table refers to "x".
#
#
#
# Another expectation is that the inverse operation should maintain the same
# structure. E.g. if a table is copied and pasted to another place, and it's
# copied again from that place and pasted back into R, it should render an
# equivalent table as the original table object.
#
# This means row.names
#
#

#' Copy a tabular object
#'
#' This function allows users to copy a tabular object (e.g. \code{data.frame},
#' \code{table}, etc) in R so they can paste it to other software.
#'
#' Since the function is called for its side effect (writing to clipboard), it
#' always silently return the \code{x} argument. This allows it to be used
#' in piped operations.
#'
#' This function is designed to be used interactively in the console. The
#' default values for the \code{x} argument is \code{.Last.Value}, which is
#' an internal R object that stores the value of the last evaluated expression.
#' This allows users to copy the last printed results by simply typing
#' \code{copy_table()}.
#'
#' This function also takes explicit arguments for writing tables instead of
#' taking dots (\code{...}). This allows auto-completion of commonly used
#' argument names, like \code{na}, or \code{col.names}.
#'
#' The combination of these features enables this function to be used in such
#' a workflow:
#' \enumerate{
#'   \item Send script to console or type commands in console until
#'   satisfied with a table output (\code{data.frame}, \code{table}, etc).
#'   \item Call \code{copy_table()} in console to copy the output.
#'   \item Paste it somewhere else, usually a spreadsheet software like Excel.
#'   \item If not satisfied with the output after pasting, come back to R and
#'   re-exexcute \code{copy_table()} with additional
#'   arguments, like \code{na = "."}.
#' }
#'
#' In the last step, the function can be called again with minimal additional
#' typing because the table object is stored in \code{.Last.Value} after the
#' first call to \code{copy_table()}, which is then used for the second call by
#' default.
#'
#' @param x A tabular object to be copied. This can be \code{data.frame},
#' \code{table}, \code{matrix} or other tabular classes. The default is
#' \code{.Last.Value}. See details for a recommended workflow.
#' @inheritParams utils::write.table
#' @param ... Further parameters passed to \code{\link{function}}.
#'
#' @examples
#' \dontrun{
#' # if interactively in the console ...
#' summary(mtcars)
#' copy_table()  # go paste it
#' copy_table(col.names = FALSE)  # try paste it again
#'
#' # copy tables explicitly
#' obj <- summary(mtcars)
#' copy_table(obj)
#' }
#'
#' @export
copy_table <- function(x = .Last.value, quote = FALSE, sep = "\t",
                       na = "", row.names = FALSE, col.names = TRUE, ...) {

  write_clip(x, object_type = "table", quote = quote, sep = sep,
             na = na, row.names = FALSE, col.names = col.names, ...)

  # content is silently returned so it can be captured if needed
  invisible(x)
}


#' Paste delimited tabular data from clipboard as a tibble
#'
#' @inheritParams readr::read_delim
#' @param \dots Other parameters passed to \code{\link[readr]{read_delim}}.
#'
#' @export
paste_table <- function(delim = "\t", quote = "\"",
                        col_names = TRUE, col_types = NULL,
                        na = c("", "NA"), ...) {
  char_vec <- read_clip()

  if (is.null(char_vec) || (length(char_vec) == 1 && char_vec == ""))
    stop("Clipboard is empty.")

  readr::read_delim(char_vec, delim = delim, quote = quote,
                    col_name = col_names, col_types = col_types,
                    na = na, ...)
}







