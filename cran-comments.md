This submission adds clipboard handlers for systems using Wayland, and modifies 
calls on Windows with R>=4.2 to work with UTF-8 native encoding.

## Test environments 
* local OS X install, R 4.1.2
* ubuntu 20.04 (GitHub Actions: R oldrel, release, and devel)
* win-builder (devel and release)

## R CMD check results

There were no ERRORs or WARNINGs.

## Downstream dependencies

I have run R CMD check on the 47 downstream dependencies of clipr. (Summary at
<https://github.com/mdlincoln/clipr/tree/master/revdep>)
