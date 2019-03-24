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
# Another functionality I want to have is that I want the default copy and
# paste operation to be the inverse of each other.
# E.g. if a table is copied and pasted to another place, and it's
# copied again from that place and pasted back into R, it should render an
# equivalent table as the original table object.
# This is not there in the utils::read(write).csv function. The csv file will
# be different because of row names.
# I have added some tests for this one in test_copy-paste.R





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
#' @param x A tabular object to be copied. This can be either \code{data.frame},
#' \code{table}, or other tabular classes. The default is
#' \code{.Last.Value}. See details for a recommended workflow.
#' @inheritParams utils::write.table
#' @param \dots Further parameters passed to \code{\link{write_clip}}.
#'
#' @seealso \code{\link{paste_table}} for pasting a table into R.
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
                       na = "", row.names = FALSE, col.names = TRUE,
                       qmethod = "double", ...) {

  write_clip(x, object_type = "table", quote = quote, sep = sep,
             na = na, row.names = row.names, col.names = col.names,
             qmethod = qmethod, ...)

  # content is silently returned so it can be captured if needed
  invisible(x)
}


#' Paste a table from clipboard as a data.frame
#'
#' This function reads tabular data from clipboard using \code{read.table} and
#' returns a data.frame.
#'
#' @param x A character vector that contains tabular data. The default is to
#' call \code{\link{read_clip}} and read the system clipboard, so this argument
#' doesn't need to be specified in most cases. Note that all other parameters
#' below are inherited from \code{\link[utils]{read.table}}, and the "file"
#' referenced in the argument description is referring to this character vector
#' in this context.
#' @inheritParams utils::read.table
#' @param \dots Other parameters passed to \code{\link[utils]{read.table}}.
#'
#' @seealso \code{\link{copy_table}} for copying an object from R. Also see
#' \code{\link[readr]{read_delim}} for how \code{readr} functions read
#' clipboard tables into R.
#'
#' @examples
#' \dontrun{
#' # paste returns the same object as what was copied
#' tbl <- data.frame(a = c(1,2,3), b = c(4,5,6))
#' copy_table(tbl)
#' paste_table()
#'
#' # row.names are ignored by default, use row.names to turn it on
#' tbl <- data.frame(a = c(1,2,3), b = c(4,5,6), row.names = c("A", "B", "C"))
#' copy_table(tbl, row.names = TRUE)
#' paste_table(row.names = 1)
#'
#' # empty and "NA" can be pasted as missing value by default
#' tbl <- data.frame(a = c(1,2,3), b = c(NA,5,6))
#' copy_table(tbl)
#' paste_table()
#'
#' copy_table(tbl, na = "NA")
#' paste_table()
#'
#' # Customized na string
#' copy_table(tbl, na = "missing")
#' paste_table(na.strings = "missing")
#' }
#'
#'
#' @export
paste_table <- function(x = read_clip(),
                        header = TRUE, sep = "\t", quote = "",
                        na.strings = c("NA", ""), row.names,
                        stringsAsFactors = FALSE, ...) {

  if (is.null(x) || (length(x) == 1 && x == ""))
    stop("Clipboard is empty.")

  utils::read.table(header = header, sep = sep, quote = quote,
                    na.strings = na.strings, row.names = row.names,
                    stringsAsFactors = stringsAsFactors, text = x, ...)
}







