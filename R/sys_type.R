#' Determine system type
sys_type <- function() {
  return(Sys.info()["sysname"])
  # OS X will return "Darwin"
  # Ubuntu will return "Linux"
  # Windows will return "Windows" (?)
}
