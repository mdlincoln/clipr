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

#' RStudio addin
#'
#' Copies the console output (rather than the value) of a selected expression to
#' the system clipboard
#'
#' @note Requires the
#'   \href{https://cran.r-project.org/package=rstudioapi}{rstudioapi} package.
#'
#' @export
clipr_output_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  expr_object <- eval(parse(text = context$selection[[1]]$text))
  write_clip(capture.output(expr_object))
}
