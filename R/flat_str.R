# Helper function to flatten content into 1-tuple character vector (i.e. a string)
flat_str <- function(content, sep) {
  content <- as.character(content)
  if (length(content) > 1) {
    content <- paste0(content, collapse = sep)
  }
  return(content)
}