This submission fixes some minor bugs related to NA/NULL/empty vectors passed to
`write_clip()`

## Test environments 
* local OS X install, R 3.3.2 
* ubuntu 12.04 (Travis.ci: R oldrel, release, and devel)
* win-builder (devel and release)

## R CMD check results 

There were no ERRORs or WARNINGs.

## Downstream dependencies

I have run R CMD check on the 3 downstream dependencies of clipr.
(Summary at <https://github.com/mdlincoln/clipr/tree/master/revdep>)

All passed with no errors or warnings.
