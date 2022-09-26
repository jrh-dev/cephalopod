source("init.R")

api_path <- paste0(
  "/home/",
  Sys.info()["user"],
  "/.config/octopus-api/api-key.yaml"
)

file.exists(api_path)

api <- yaml::yaml.load_file("/home/jrh/.config/octopus-api/api-key.yaml")

edat <- consumption(
    mpan = api$electric_mpan,
    serial = api$electric_serial,
    api_key = api$key,
    fuel = "electricity",
    from = "2020-10-25 00:00",
    page_size = 2500
)

saveRDS(edat, "data/raw/edat.RDS")

saveRDS(max(edat$interval_start),"cache/e_latest_update.RDS")

gdat <- consumption(
    mpan = api$gas_mpan,
    serial = api$gas_serial,
    api_key = api$key,
    fuel = "gas",
    from = "2020-10-25 00:00",
    page_size = 2500
)

saveRDS(gdat, "data/raw/gdat.RDS")

saveRDS(max(gdat$interval_start),"cache/g_latest_update.RDS")
