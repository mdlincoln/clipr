# Check object type to determine if it will be handled as a simple table or as a
# character vector
render_object <- function(content, object_type, breaks, .dots) {
  if(object_type == "auto")
    object_type <- eval_object(content)
  switch(object_type,
       "table" = table_str(content, breaks, .dots),
       "character" = flat_str(content, breaks))
}

eval_object <- function(content) {
  ifelse(is.data.frame(content) | is.matrix(content), "table", "character")
}

# If object is a table, default to a multiline string with tab separators
table_str <- function(content, breaks, .dots) {
  # Take the system-specific collapse out of the list
  .dots$x <- content
  .dots$sep <- .dots$sep
  .dots$quote <- ifelse(is.null(.dots$quote), FALSE, .dots$quote)
  .dots$na <- ifelse(is.null(.dots$na), "", .dots$na)
  .dots$row.names <- ifelse(is.null(.dots$row.names), FALSE, .dots$row.names)
  # If matrix, default to not printing column names
  if(is.matrix(content))
    .dots$col.names <- ifelse(is.null(.dots$col.names), FALSE, .dots$col.names)
  paste0(utils::capture.output(do.call(utils::write.table, .dots)), collapse = breaks)
}

# Helper function to flatten content into 1-tuple character vector (i.e. a string)
flat_str <- function(content, breaks) {
  if(typeof(content) != "character") {
    warning("Coercing content to character")
    content <- as.character(content)
  }
  if (length(content) > 1) {
    content <- paste0(content, collapse = breaks)
  }
  return(content)
}