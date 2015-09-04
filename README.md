clipr
=====

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/0.1.0/active.svg)](http://www.repostatus.org/#active)

[![CRAN status.](http://www.r-pkg.org/badges/version/clipr)](http://www.r-pkg.org/pkg/clipr)

Simple utility functions to read and write from the system clipboards of Windows, OS X, and Unix-like systems (which require either xclip or xsel.)

```R
devtools::install_github("mdlincoln/clipr")
library("clipr")

var <- read_clip()

write_clip(c("Text", "for", "clipboard"), sep = "\n")
```

---
[Matthew Lincoln](http://matthewlincoln.net) | University of Maryland, College Park
