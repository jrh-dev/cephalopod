format_date <- function(date) {
    
    out <- paste0(gsub(" ","T",substr(as.character(as.POSIXct(date)),1,16)),"Z")
    
    if (length(out) < 17) out = paste0(substr(out,1,10),"T00:00Z")
    
    return(out)
}
