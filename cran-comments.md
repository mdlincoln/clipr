## Resubmission
This is a resubmission. In this version I have:

* Removed the check for a "Linux" system. Instead, if system != "Darwin" or "Windows", will assume a Unix-like system

* Reimplemented the check for 'xclip' and/or 'xsel'. The following error will still be thrown if neither program is installed: `Error: Clipboard on Unix-like systems requires 'xclip' (recommended) or 'xsel'.`

## Test environments
* local OS X install, R 3.2.2
* local ubuntu 14.04, R 3.2.2
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs.
