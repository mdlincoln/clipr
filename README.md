clipr
=====

[![Project Status: Wip - Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/0.1.0/wip.svg)](http://www.repostatus.org/#wip)

Simple utility functions to read and write from the system clipboards of Windows, OS X, and Linux.

```R
devtools::install_github("mdlincoln/clipr")
library("clipr")

var <- read_clip()

write_clip(c("Text", "for", "clipboard"), sep = "\n")
```

---
[Matthew Lincoln](http://matthewlincoln.net) | University of Maryland, College Park
