clipr
=====

[![CRAN status.](http://www.r-pkg.org/badges/version/clipr)](http://www.r-pkg.org/pkg/clipr)
[![Travis-CI Build Status](https://travis-ci.org/mdlincoln/clipr.svg?branch=master)](https://travis-ci.org/mdlincoln/clipr)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/mdlincoln/clipr?branch=master&svg=true)](https://ci.appveyor.com/project/mdlincoln/clipr)

Simple utility functions to read and write from the system clipboards of Windows, OS X, and Unix-like systems (which require either xclip or xsel.)

```R
devtools::install_github("mdlincoln/clipr")
library("clipr")

var <- read_clip()

write_clip(c("Text", "for", "clipboard"), sep = "\n")
```

---
[Matthew Lincoln](http://matthewlincoln.net) | University of Maryland, College Park
