# Setup for all following tests
skip_msg <- "System clipboard is not available - skipping test."

# If not running on cran, set the global envvar that allows clipr to run in non-interactive session
if (Sys.getenv("NOT_CRAN")) {
  message("Not on cran, allowing interactive clipr")
  Sys.setenv(CLIPBOARD_AVAILABLE=FALSE)
}
is_clipr_available <- clipr_available()
message("Is clipr available?: ", is_clipr_available)
