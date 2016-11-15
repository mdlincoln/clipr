This is a resubmission of clipr 0.2.2. I have hopefully fixed a function that 
ought to check for the availability of the system clipboard via xclip/xsel, and 
skip tests if neither utility is installed OR if one is installed but the 
DISPLAY env var is not configured to provide system clipboard functionality.
This ought to allow tests to pass on CRAN.

## Test environments 
* local OS X install, R 3.3.2 
* ubuntu 12.04 (Travis.ci), R 3.3.1 
* win-builder (devel and release)

## R CMD check results 

There were no ERRORs or WARNINGs.

## Downstream dependencies

I have run R CMD check on all downstream dependencies of clipr with no problems.
