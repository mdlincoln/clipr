#' RStudio addin
#'
#' Write the results of the selected expression to the
#' clipboard
#'
#' @note Requires the \href{https://cran.r-project.org/package=rstudioapi}{rstudioapi}
#' package.
#'
#' @export
clipr_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text_expr <- parse(text = context$selection[[1]]$text)
  write_clip(eval(text_expr))
}
