
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

cb <- read_clip()

# Character vectors with length > 1 will be collapsed with system-appropriate
# line breaks, unless otherwise specified

cb <- write_clip(c("Text", "for", "clipboard"))
cb
#> [1] "Text\nfor\nclipboard"

cb <- write_clip(c("Text", "for", "clipboard"), breaks = ", ")
cb
#> [1] "Text, for, clipboard"
```

`write_clip` also tries to intelligently handle data.frames and
matrices, rendering them with `write.table` so that they can be pasted
into a spreadsheet like Excel.

``` r
tbl <- data.frame(a = c(1, 2, 3), b = c(4, 5, 6))
cb <- write_clip(tbl)
cb
#> [1] "a\tb\n1\t4\n2\t5\n3\t6"
```

`read_clip_tbl` will try to parse clipboard contents from spreadsheets
into data frames directly.

## Developing with clipr

### Interactive & non-interactive use

If you use clipr in your own package, you should not call it in
non-interactive sessions, as this goes against [CRAN repository
policy](https://cran.r-project.org/web/packages/policies.html):

> Packages should not write in the user’s home filespace (including
> clipboards), nor anywhere else on the file system apart from the R
> session’s temporary directory (or during installation in the location
> pointed to by TMPDIR: and such usage should be cleaned up). Installing
> into the system’s R installation (e.g., scripts to its bin directory)
> is not allowed.
> 
> Limited exceptions may be allowed in interactive sessions if the
> package obtains confirmation from the user.

### Linux utility availability

clipr’s functionality on X11-based systems depends on the installation
of additional software. Therefore, if you want to use clipr in your
package, you will want to take some care in how you call it, and make
sure that your package will respond gracefully if clipboard
functionality is not working as expected. You can use the function
`clipr_available()` to check if the clipboard is readable and writable
by the current R session.

### Testing on CRAN and CI

A few best practices will also help you responsibly test your
clipr-using package on headless systems like CRAN or other testing
infrastructure like Travis:

1.  Examples that will try to use `read_clip()` or `write_clip()` ought
    to be wrapped in `\dontrun{}`
2.  Tests calling clipr should be conditionally skipped, based on the
    output of `clipr_available()`. This is necessary to pass CRAN
    checks.
3.  If you are using [Travis.ci](https://travis-ci.org/) to check your
    package build on Linux, consult the
    [`.travis.yml`](https://github.com/mdlincoln/clipr/blob/master/.travis.yml)
    for this package, which includes code for setting the `DISPLAY`
    environment variable, installing `xclip` and `xsel`, and running a
    pre-build script that will set up `xclip`/`xsel` to run headlessly.
4.  If you wish to display system requirements and configuration
    messages to X11 users, `dr_clipr()` provides these.

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
3.  [curlconverter](https://github.com/hrbrmstr/curlconverter) by
    [@hrbrmstr](https://github.com/hrbrmstr/curlconverter) translates
    cURL command lines into [httr](https://github.com/hadley/httr)
    calls.

-----

[Matthew Lincoln](http://matthewlincoln.net)
