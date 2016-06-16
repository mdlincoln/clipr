#' Transforms Output of Read_clip into Data.Frame
#'
#' Transforms Output of Read_clip into Data.Frame
#'
#' @param clip the excel table clip to transform to data.frame
#' @param headers logical for if clip contains colnames or a vector of colnames to use
#' @param stringsAsFactor logical for using stringAsFactors, default is FALSE
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
#' cat_in_the_hat <- xl2df_clip(clip_contents_from_excel_table )
#' print(cat_in_the_hat)
#' #            thingOne        thingTwo
#' # 1 the thing I might the thing I may
#' # 2    become despite coding this way
xl2df_clip <- function (clip = clipr::read_clip(), headers = TRUE, stringsAsFactor = FALSE) {
    out <- t(sapply(clip, function(x) strsplit(x, "\t")[[1]],  USE.NAMES = FALSE))
    if (is.logical(headers)) {
        if (headers) {
            xx <- out[2:nrow(out), ]
            colnames(xx) <- out[1, ]
        }
        else {
            xx <- out
        }
    }
    else {
        xx <- out[2:nrow(out), ]
        colnames(xx) <- headers
    }
    readr::type_convert(as.data.frame(xx, stringsAsFactors = stringsAsFactor))
}

