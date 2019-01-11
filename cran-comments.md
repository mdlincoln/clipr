This submission prevents write_clip from accessing the clipboard in
non-interactive sessions, and skips all tests that write to the clipboard on
CRAN. It adds further documentation on the behavior of X11 clipboard utilities.

## Test environments 
* local OS X install, R 3.5.1
* ubuntu 12.04 (Travis.ci: R oldrel, release, and devel)
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs.

## Downstream dependencies

I have run R CMD check on the 14 downstream dependencies of clipr. (Summary at
<https://github.com/mdlincoln/clipr/tree/master/revdep>)
