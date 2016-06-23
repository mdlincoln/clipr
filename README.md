clipr
=====

[![CRAN status.](http://www.r-pkg.org/badges/version/clipr)](http://www.r-pkg.org/pkg/clipr)
![Downloads, grand total](http://cranlogs.r-pkg.org/badges/grand-total/clipr)
[![Travis-CI Build Status](https://travis-ci.org/mdlincoln/clipr.svg?branch=master)](https://travis-ci.org/mdlincoln/clipr)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/clipr?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/clipr)

Simple utility functions to read and write from the system clipboards of Windows, OS X, and Unix-like systems (which require either xclip or xsel.)

## Installation

Install from CRAN

```r
install.packages("clipr")
```

Or try the development version

```r
devtools::install_github("mdlincoln/clipr")
```

## Usage

``` r
library("clipr")

cb <- read_clip()

# Character vectors with length > 1 will be collapsed with system-appropriate
# line breaks, unless otherwise specified

cb <- write_clip(c("Text", "for", "clipboard"))
cb
#> [1] "Text\nfor\nclipboard"     # on OS X or Unix-like
#> [1] "Text\r\nfor\r\nclipboard" # on Windows

cb <- write_clip(c("Text", "for", "clipboard"), breaks = ", ")
cb
#> [1] "Text, for, clipboard"
```

`write_clip` also tries to intelligently handle data.frames and matricies, rendering them with `write.table` so that they can be pasted into a spreasheet like Excel.

``` r
tbl <- data.frame(a=c(1,2,3), b=c(4,5,6))
cb <- write_clip(tbl)
cb
#> [1] "a\tb\n1\t4\n2\t5\n3\t6"   # on OS X or Unix-like
#> [1] "a,b\r\n1,4\r\n2,5\r\n3,6" # on Windows
```

`read_clip_tbl` will try to parse clipboard contents from spreadsheets into data frames directly.

---
[Matthew Lincoln](http://matthewlincoln.net) | University of Maryland, College Park
