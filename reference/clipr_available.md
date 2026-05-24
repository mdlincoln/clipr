# Is the system clipboard available?

Checks to see if the system clipboard is write-able/read-able. This may
be useful if you are developing a package that relies on clipr and need
to ensure that it will skip tests on machines (e.g. CRAN, Travis) where
the system clipboard may not be available.

## Usage

``` r
clipr_available(...)

dr_clipr(...)
```

## Arguments

- ...:

  Pass other options to
  [`write_clip()`](http://matthewlincoln.net/clipr/reference/write_clip.md).
  Generally only used to pass the argument
  `allow_non_interactive_use = TRUE`.

## Value

`clipr_available` returns a boolean value.

Prints an informative message to the console with software and system
configuration requirements if clipr is not available (invisibly returns
the same string)

## Note

This will automatically return `FALSE`, without even performing the
check, if you are running in a non-interactive session. If you must call
this non-interactively, be sure to call using
`clipr_available(allow_non_interactive = TRUE)`, or by setting the
environment variable `CLIPR_ALLOW=TRUE`. **Do not attempt to run clipr
non-interactively on CRAN; this will result in a failed build!**

## Examples

``` r
if (FALSE) { # \dontrun{
# When using testthat:
library(testthat)
skip_if_not(clipr_available())
} # }
```
