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

## Using clipr in packages

clipr's functionality, particularly on Linux-based systems, depends on the installation of additional software and, on headless systems like CRAN or other testing infrastructure like Travis, customization of environmental variables.
Therfore, if you want to use clipr in your package, you will want to take some care in constructing your examples and tests:

1. Examples that will try to use `read_clip()` or `write_clip()` ought to be wrapped in `\dontrun{}`
2. Tests calling clipr should be conditionally skipped, calling on `clipr_available()` to check for this availability. This is necessary to pass CRAN checks.
3. If you are using [Travis.ci](https://travis-ci.org/) to check your package build on Linux, consult the [`.travis.yml`](https://github.com/mdlincoln/clipr/blob/master/.travis.yml) for this package, which includes code for setting the `DISPLAY` environment variable, installing `xclip`, and running a pre-build script that will set up `xclip` to run headlessly.

---
[Matthew Lincoln](http://matthewlincoln.net)
