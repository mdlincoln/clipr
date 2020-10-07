This is a resubmission.

This submission repairs system command calls that were causing some newer Linux window managers to hang indefinitely.

## Test environments 
* local OS X install, R 4.0.2
* ubuntu 16.04 (Travis.ci: R oldrel, release, and devel)
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs.

## Downstream dependencies

I have run R CMD check on the 32 downstream dependencies of clipr. (Summary at
<https://github.com/mdlincoln/clipr/tree/master/revdep>)
