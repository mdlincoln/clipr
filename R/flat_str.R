# Check object type to determine if it will be handled as a simple table or as a
# character vector
render_object <- function(content, object_type, breaks, .dots) {
  if (object_type == "auto")
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
  .dots$col.names <- ifelse(is.null(.dots$col.names), !is.null(colnames(content)), .dots$col.names)

  # Check if dataframe rownames are anything different than the default numbered names
  numbered_rownames <- all(rownames(content) == as.character(seq_along(rownames(content))))

  .dots$row.names <- ifelse(is.null(.dots$row.names), ifelse(numbered_rownames, FALSE, !is.null(rownames(content))), .dots$row.names)

  # Writing to and reading from a temp file is much faster than using capture.output
  tbl_file <- tempfile()
  .dots$file = tbl_file
  do.call(utils::write.table, .dots)
  read_tbl <- paste0(readLines(tbl_file), collapse = breaks)
  unlink(tbl_file)

  # If row.names = TRUE and col.names = TRUE, add additional sep character to
  # the start of the table
  if (.dots$row.names & .dots$col.names) {
    read_tbl <- paste0(.dots$sep, read_tbl)
  }

  return(read_tbl)
}

# Helper function to flatten content into 1-tuple character vector (i.e. a
# string)
flat_str <- function(content, breaks) {
  if (typeof(content) != "character") {
    warning("Coercing content to character")
    content <- as.character(content)
  }

  if (length(content) < 1) {
    content <- ""
  } else if (length(content) > 1) {
    content <- paste0(content, collapse = breaks)
  } else if (is.na(content)) {
    content <- "NA"
  }

  return(content)
}
