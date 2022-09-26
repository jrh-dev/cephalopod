.onLoad = function (libname, pkgname) {
  
  pkg_env = topenv()
  
  pkg_env$`%as%` <- function(lhs, rhs) assign(rhs, loadNamespace(lhs), envir = parent.frame())
  
  pkg_env$._cache <- tools::R_user_dir("cephalopod", "cache")
  
  pkg_env$._config <- tools::R_user_dir("cephalopod", "config")
  
  edat_loc <- paste0(pkg_env$._cache, "/edat.rds")
  
  gdat_loc <- paste0(pkg_env$._cache, "/gdat.rds")
  
  ele_cached <- file.exists(edat_loc)
  
  gas_cached <- file.exists(gdat_loc)
  
  # TODO latest update cached isn't really necessary, strip from other functions
  
  if (ele_cached) {
    pkg_env$edat <- readRDS(edat_loc)
  }  else {
    message("No cache found for electicity data, run get_data().")
  }
  
  if (gas_cached) {
    pkg_env$gdat <- readRDS(gdat_loc)
  }  else {
    message("No cache found for electicity data, run get_data().")
  }
  
  
  
  
  
  return(invisible())
}
  






