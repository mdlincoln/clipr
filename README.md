
<!-- README.md is generated from README.Rmd. Please edit that file -->

# clipr

[![CRAN
status.](http://www.r-pkg.org/badges/version/clipr)](http://www.r-pkg.org/pkg/clipr)
![Downloads, grand
total](http://cranlogs.r-pkg.org/badges/grand-total/clipr) [![Travis-CI
Build
Status](https://travis-ci.org/mdlincoln/clipr.svg?branch=master)](https://travis-ci.org/mdlincoln/clipr)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/clipr?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/clipr)
[![Coverage
Status](https://img.shields.io/codecov/c/github/mdlincoln/clipr/master.svg)](https://codecov.io/github/mdlincoln/clipr?branch=master)

Simple utility functions to read and write from the system clipboards of
Windows, OS X, and Unix-like systems (which require either xclip or
xsel.)

## Installation

Install from CRAN

``` r
install.packages("clipr")
```

Or try the development version

``` r
devtools::install_github("mdlincoln/clipr")
```

## Usage

``` r
library("clipr")
#> Welcome to clipr. See ?write_clip for advisories on writing to the clipboard in R.

cb <- read_clip()
```

clipr is pipe-friendly, and will default to returning the same object
that was passed in.

``` r
res <- write_clip(c("Text", "for", "clipboard"))
res
#> [1] "Text"      "for"       "clipboard"
```

To capture the string that clipr writes to the clipboard, specify
`return_new = TRUE`. Character vectors with length \> 1 will be
collapsed with system-appropriate line breaks, unless otherwise
specified

``` r

cb <- write_clip(c("Text", "for", "clipboard"), return_new = TRUE)
cb
#> [1] "Text\nfor\nclipboard"

cb <- write_clip(c("Text", "for", "clipboard"), breaks = ", ", return_new = TRUE)
cb
#> [1] "Text, for, clipboard"
```

`write_clip` also tries to intelligently handle data.frames and
matrices, rendering them with `write.table` so that they can be pasted
into a spreadsheet like Excel.

``` r
tbl <- data.frame(a = c(1, 2, 3), b = c(4, 5, 6))
cb <- write_clip(tbl, return_new = TRUE)
cb
#> [1] "a\tb\n1\t4\n2\t5\n3\t6"
```

`read_clip_tbl` will try to parse clipboard contents from spreadsheets
into data frames directly.

## Developing with clipr

See the “Developing with clipr” vignette included with this package for
advisories on writing code that calls clipr functions.

## Nice uses of clipr

(a non-comprehensive list)

1.  [reprex](https://github.com/jennybc/reprex) by
    [@jennybc](https://github.com/jennybc) takes R code on the clipboard
    and renders a reproducible example from it, ready to then paste on
    to GitHub, Stack Overflow, or the like.
2.  [datapasta](https://github.com/milesmcbain/datapasta) by
    [@milesmcbain](https://github.com/milesmcbain) eases the copying and
    pasting of R objects in and out of different sources (Excel, Google
    Sheets).

-----

[Matthew Lincoln](http://matthewlincoln.net)
