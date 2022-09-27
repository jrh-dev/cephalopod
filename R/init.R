.onLoad = function (libname, pkgname) {
  
  pkg_env = topenv()
  
  pkg_env$`%as%` <- function(lhs, rhs) assign(rhs, loadNamespace(lhs), envir = parent.frame())
  
  pkg_env$._cache <- tools::R_user_dir("cephalopod", "cache")
  
  pkg_env$._config <- tools::R_user_dir("cephalopod", "config")
  
  if (!dir.exists(pkg_env$._cache)) dir.create(pkg_env$._cache)
  
  if (!dir.exists(pkg_env$._config)) dir.create(pkg_env$._config)
  
  edat_loc <- paste0(pkg_env$._cache, "/edat.rds")
  
  gdat_loc <- paste0(pkg_env$._cache, "/gdat.rds")
  
  key_loc <- paste0(pkg_env$._config, "/api-key.yaml")
  
  # TODO latest update cached isn't really necessary, strip from other functions
  
  if (file.exists(edat_loc)) {
    pkg_env$e_cached <- TRUE
  }  else {
    pkg_env$e_cached <- FALSE
    message("No cache found for electicity data, run get_data().")
  }
  
  if (file.exists(gdat_loc)) {
    pkg_env$g_cached <- TRUE
  }  else {
    pkg_env$g_cached <- FALSE
    message("No cache found for gas data, run get_data().")
  }
  
  if (file.exists(key_loc)) {
    pkg_env$key <- yaml::read_yaml(key_loc)
    message("Stored key detail's retrieved.")
  } else {
    message("No stored key details found.")
  }
  
  return(invisible())
}
  






