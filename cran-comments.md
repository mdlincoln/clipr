This is a resubmission. I have hopefully fixed a function that 
ought to check for the availability of the system clipboard via xclip/xsel, and 
skip tests if neither utility is installed OR if one is installed but the 
DISPLAY env var is not configured to provide system clipboard functionality.
This ought to allow tests to pass on CRAN.

## Test environments 
* local OS X install, R 3.3.2 
* ubuntu 12.04 (Travis.ci: R oldrel, releaes, and devel)
* win-builder (devel and release)

## R CMD check results 

There were no ERRORs or WARNINGs.

## Downstream dependencies

curlconverter fails because of more stringent clipboard availability checking 
introduced in this new version of clipr. The maintainer has been alerted, and a
patch has been submitted, however the fix depends on a new function introduced
in this version of clipr that checks whether relevant tests should be skipped
when the system clipboard cannot be accessed (as on the X11 platforms on CRAN).
Once this new version of clipr is available, the updated version of
curlconverter should pass.
