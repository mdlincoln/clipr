#' Transforms Output of Read_clip into Data.Frame
#'
#' Transforms Output of Read_clip into Data.Frame
#'
#' @param x the excel table clip to transform to data.frame
#' @param \ldots list of other readr options
#' @return A data.frame with the contents of the clipboard.
#'        If the system clipboard is empty, returns NULL
#' @export
#' @examples
#' # excel contents
#' #' #            thingOne        thingTwo
#' # 1 the thing I might the thing I may
#' # 2    become despite coding this way
#'
#' # excel contents after read_clip copies
#' clip_contents_from_excel_table <- c(
#' "thingOne\tthingTwo",
#' "the thing I might\tthe thing I may",
#' "become despite\tcoding this way")
#'
#' cat_in_the_hat <- read_clip_tbl(clip_contents_from_excel_table )
#' print(cat_in_the_hat)
#' #            thingOne        thingTwo
#' # 1 the thing I might the thing I may
#' # 2    become despite coding this way
read_clip_tbl <- function(x = read_clip(), ...) {
  readr::read_tsv(paste0(x, collapse = "\n"), ...)
}

