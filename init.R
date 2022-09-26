library(data.table)
source("R/consumption.R")
source("R/detect_error.R")
source("R/format_date.R")

`%as%` <- function(lhs, rhs) assign(rhs, loadNamespace(lhs), envir = parent.frame())

"data.table" %as% "dt"
"lubridate" %as% "ld"
"plotly" %as% "px"

edat <- readRDS("data/raw/edat.RDS")
gdat <- readRDS("data/raw/gdat.RDS")