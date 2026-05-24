This submission fixes `read_clip_tbl()` error with trailing newline and quote 
characters, checks for `wl-copy` non-destructively on Wayland systems, and skips
tests when clipr is not available (e.g. on CRAN build servers without a display).

## Test environments 
* local OS X install, R 4.x
* ubuntu 20.04 (GitHub Actions: R oldrel, release, and devel)
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs.

## Downstream dependencies

I have run R CMD check on the downstream dependencies of clipr. (Summary at
<https://github.com/mdlincoln/clipr/tree/master/revdep>)
