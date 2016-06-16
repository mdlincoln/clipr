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

`xl2df_clip` allows clips from spreadsheets containing matrices to be read in as data.frames directly. It can be exactly like `read_clip`, directly after the copy step, and also after the output of read_clip has been assigned to a variable.

Take the example of a spreadsheet containing the Cat-in-the-Hat-like nursery rhyme from Thing One and Thing Two.

``` r
# spreadsheet containing 3 variables
# line           thingOne         thingTwo
#    1  the thing I might  the thing I may
#    2     become despite  coding this way
```

You could copy it from the spreadsheet and then paste directly to data.frame via `cat_in_the_hat <- xl2df()`. It automatically handles type conversion on your dataframe.

Or, if you have already assigned the contents to a variable like below:
``` r
# excel contents after read_clip copies are inside c()
clip_contents_from_excel_table <- read_clip()
print(clip_contents_from_excel_table)

[1] "line\tthingOne\tthingTwo"  "1\tthe thing I might\tthe thing I may" "2\tbecome despite\tcoding this way"
```

You can still reassign `clip_contents_from_excel_table` through `xl2df()` to get a quick transformation to data.frame.

``` r
cat_in_the_hat <- xl2df_clip(clip_contents_from_excel_table )
str(cat_in_the_hat)
# 'data.frame':	2 obs. of  3 variables:
#  $ line    : int  1 2
#  $ thingOne: chr  "the thing I might" "become despite"
#  $ thingTwo: chr  "the thing I may" "coding this way"
```

It also allows header handling through the `header` parameter. Declare `TRUE` or `FALSE` for whether the clip already contains a header. If you supply `header` a vector of column names, then it assumes there are headers that you would like to override. If the clip does not contain headers and you would like to assign headers, then assign then after using `xl2df()` to assign the dataframe. The `cat_in_the_hat` clip above could have had its colnames changed in the assignment step, as below:

``` r
cat_in_the_hat <- xl2df_clip(headers=c("", "you", "me")
# 'data.frame':	2 obs. of  3 variables:
#  $ V1 : int  1 2
#  $ you: chr  "the thing I might" "become despite"
#  $ me : chr  "the thing I may" "coding this way"
```
---
[Matthew Lincoln](http://matthewlincoln.net) | University of Maryland, College Park
