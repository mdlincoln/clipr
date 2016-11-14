clipr_result <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  expr_object <- eval(parse(text = context$selection[[1]]$text))
  write_clip(expr_object)
}

clipr_output <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  expr_object <- eval(parse(text = context$selection[[1]]$text))
  write_clip(utils::capture.output(expr_object))
}
