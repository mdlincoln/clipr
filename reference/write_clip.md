# Write clipboard

Write a character vector to the system clipboard

## Usage

``` r
write_clip(
  content,
  object_type = c("auto", "character", "table"),
  breaks = NULL,
  eos = NULL,
  return_new = FALSE,
  allow_non_interactive = Sys.getenv("CLIPR_ALLOW", interactive()),
  ...
)
```

## Arguments

- content:

  An object to be written to the system clipboard.

- object_type:

  `write_clip()` tries to be smart about writing objects in a useful
  manner. If passed a data.frame or matrix, it will format it using
  [`write.table()`](https://rdrr.io/r/utils/write.table.html) for
  pasting into an external spreadsheet program. It will otherwise coerce
  the object to a character vector. `auto` will check the object type,
  otherwise `table` or `character` can be explicitly specified.

- breaks:

  The separator to be used between each element of the character vector
  being written. `NULL` defaults to writing system-specific line breaks
  between each element of a character vector, or each row of a table.

- eos:

  The terminator to be written after each string, followed by an ASCII
  `nul`. Defaults to no terminator character, indicated by `NULL`.

- return_new:

  If true, returns the rendered string; if false, returns the original
  object

- allow_non_interactive:

  By default, clipr will throw an error if run in a non-interactive
  session. Set the environment variable `CLIPR_ALLOW=TRUE` in order to
  override this behavior.

- ...:

  Custom options to be passed to
  [`write.table()`](https://rdrr.io/r/utils/write.table.html) (if `x` is
  a table-like). Defaults to sane line-break and tab standards based on
  the operating system. By default, this will use `col.names = TRUE` if
  the table object has column names, and `row.names = TRUE` if the
  object has row names other than `c("1", "2", "3"...)`. Override these
  defaults by passing arguments here.

## Value

Invisibly returns the original object

## Note

On X11 systems, `write_clip()` will cause either xclip (preferred) or
xsel to be called. Be aware that, by design, these processes will fork
into the background. They will run until the next paste event, when they
will then exit silently. (See the man pages for
[xclip](https://linux.die.net/man/1/xclip) and
[xsel](https://www.vergenet.net/~conrad/software/xsel/xsel.1x.html#notes)
for more on their behaviors.) However, this means that even if you
terminate your R session after running `write_clip()`, those processes
will continue until you access the clipboard via another program. This
may be expected behavior for interactive use, but is generally
undesirable for non-interactive use. For this reason you must not run
`write_clip()` on CRAN, as the nature of xsel [has caused issues in the
past](https://github.com/mdlincoln/clipr/issues/38).

Call
[`clipr_available()`](http://matthewlincoln.net/clipr/reference/clipr_available.md)
to safely check whether the clipboard is readable and writable.

## Examples

``` r
if (FALSE) { # \dontrun{
text <- "Write to clipboard"
write_clip(text)

multiline <- c("Write", "to", "clipboard")
write_clip(multiline)
# Write
# to
# clipboard

write_clip(multiline, breaks = ",")
# write,to,clipboard

tbl <- data.frame(a=c(1,2,3), b=c(4,5,6))
write_clip(tbl)
} # }
```
