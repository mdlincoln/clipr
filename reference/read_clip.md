# Read clipboard

Read the contents of the system clipboard into a character vector.

## Usage

``` r
read_clip(allow_non_interactive = Sys.getenv("CLIPR_ALLOW", interactive()))
```

## Arguments

- allow_non_interactive:

  By default, clipr will throw an error if run in a non-interactive
  session. Set the environment variable `CLIPR_ALLOW=TRUE` in order to
  override this behavior.

## Value

A character vector with the contents of the clipboard. If the system
clipboard is empty, returns NULL

## Note

`read_clip()` will not try to guess at how to parse copied text. If you
are copying tabular data, it is suggested that you use
[`read_clip_tbl()`](http://matthewlincoln.net/clipr/reference/read_clip_tbl.md).

## Examples

``` r
if (FALSE) { # \dontrun{
clip_text <- read_clip()
} # }
```
