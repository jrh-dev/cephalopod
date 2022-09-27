
set_key <- function(key, acc, electic_mpan, electric_serial, gas_mpan, gas_serial) {
  
  key <- list(key, acc, electic_mpan, electric_serial, gas_mpan, gas_serial)
  
  names(key) <- c("key", "acc", "electic_mpan", "electric_serial", "gas_mpan", "gas_serial")
  
  yaml::write_yaml(key, paste0(pkg_env$._config, "/api-key.yaml"))
  
  return(invisible())
}
