consumption <- function(
        mpan,
        serial,
        api_key,
        fuel = c("electricity","gas"),
        from = NULL,
        to = NULL,
        page_size
) {
    
    stopifnot("Specify electricity or gas" = (length(fuel == 1) & fuel %in% c("electricity","gas")))
    
    from <- if(is.null(from)) NULL else format_date(from)
    to <- if(is.null(to)) NULL else format_date(to)
    
    res_list = list()
    
    query <- glue::glue(
        'https://api.octopus.energy/v1/',
        '{fuel}',
        '-meter-points/',
        '{mpan}',
        '/meters/',
        '{serial}',
        '/consumption/',
        '?page_size={as.integer(page_size)}',
        '{if(is.null(from)) "" else paste0("&period_from=",from)}',
        '{if(is.null(to)) "" else paste0("&period_to=",to)}',
        '&order_by=period'
    )
    
    continue = TRUE
    
    i = 1
    
    while (continue) {
        res <- httr::GET(query, httr::authenticate(api_key,''))
        
        detect_error(res)
        
        cont <- httr::content(res)
        
        if (is.null(unlist(cont["next"]))) continue = FALSE else query = unlist(cont["next"])
        
        res_list[[i]] <- do.call(rbind, lapply(cont$results, as.data.frame))
        
        i = i + 1
    }
    
    out <- data.table::rbindlist(res_list)
    
    if (nrow(out) > 0) {
        
    out[, `:=`(
        interval_start = as.POSIXct(as.character(interval_start),format="%Y-%m-%dT%H:%M"),
        interval_end = as.POSIXct(as.character(interval_end),format="%Y-%m-%dT%H:%M")
    )]
    
    out[, .(consumption = sum(consumption)), by = .(interval_start, interval_end)]
    
    }
    
    return(out)
}