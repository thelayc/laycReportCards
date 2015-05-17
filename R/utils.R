# function to check that the OS is windows
check_windows <- function(){
  unname(Sys.info()['sysname']) == 'Windows'
}

assertthat::assert_that(Sys.info()['sysname'] == 'Windows')
