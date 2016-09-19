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
  expr_object <- eval(parse(text = context$selection[[1]]$text))
  write_clip(expr_object)
}
