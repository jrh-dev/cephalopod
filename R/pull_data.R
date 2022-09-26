source("init.R")

api <- yaml::yaml.load_file("/home/jrh/.config/octopus-api/api-key.yaml")


# move these to .local or similar with error handling on fail
e_latest <- readRDS("cache/e_latest_update.RDS")

g_latest <- readRDS("cache/g_latest_update.RDS")

edat <- readRDS("data/raw/edat.RDS")

gdat <- readRDS("data/raw/gdat.RDS")

e_pull_from <- substr(e_latest,1,16)

g_pull_from <- substr(g_latest,1,16)

new_edat <- consumption(
    mpan = api$electric_mpan,
    serial = api$electric_serial,
    api_key = api$key,
    fuel = "electricity",
    from = e_pull_from,
    page_size = 2500
)

if (nrow(new_edat) > 0) {
    
    edat <- data.table::rbindlist(list(edat, new_edat))
    
    edat <- unique(edat, by = c("interval_start","interval_end"))
    
    saveRDS(edat, "data/raw/edat.RDS")
    
    saveRDS(max(edat$interval_start),"cache/e_latest_update.RDS")
}

new_gdat <- consumption(
    mpan = api$gas_mpan,
    serial = api$gas_serial,
    api_key = api$key,
    fuel = "gas",
    from = g_pull_from,
    page_size = 2500
)

if (nrow(new_gdat) > 0) {
    
    gdat <- data.table::rbindlist(list(gdat, new_gdat))
    
    gdat <- unique(gdat, by = c("interval_start","interval_end"))
    
    saveRDS(gdat, "data/raw/gdat.RDS")
    
    saveRDS(max(gdat$interval_start),"cache/g_latest_update.RDS")
}
