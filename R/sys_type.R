# Determine system type
sys_type <- function() {
  return(Sys.info()["sysname"])
}
