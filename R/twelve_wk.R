source("init.R")

edat <- readRDS("data/raw/edat.RDS")
gdat <- readRDS("data/raw/gdat.RDS")

data = edat
txt_color = '#FFFFFF'
bar_color = '#58508d'
bg_color = '#2e2e2e'
y_zl_color = '#ff6361'

#-------------------------

twelve_wk <- function(data, txt_color, bar_color, bg_color, y_zl_color) {
    
    text <- list(
        family = "Source Sans Pro",
        size = 18,
        color = txt_color
    )    

    cutoff <- as.POSIXct(cut(Sys.Date(), breaks = "weeks")) - (86400 * 7 * 11)

    data <- dt$copy(data)

    data <- data[interval_start >= cutoff, ]

    data[, date := dt$as.IDate(interval_start)]

    by_day <- data[, .(consumption = round(sum(consumption), 2)), by = "date"]

    data[, date := dt$as.IDate(as.POSIXct(cut(date, breaks = "weeks")))]

    by_wk <- data[, .(consumption = round(sum(consumption), 2)), by = "date"]

    p_day <- ._layout(._plot(by_day, bc = bar_color), t = text, bg = bg_color)

    p_wk <- ._layout(._plot(by_wk, bc = bar_color), t = text, bg = bg_color)

    return(list(p_day = p_day, day_dat = by_day, p_wk = p_wk, wk_dat = by_wk))
}

._plot <- function(x, bc) {
    out <- px$plot_ly(
        x = x$date,
        y = x$consumption,
        type = "bar",
        marker = list(
            color = bc,
            line = list(
                color = bc,
                width = 1.5
            )
        )
    )
    return(out)
}

._layout <- function(x, t, bg) {
    out <- px$layout(
        x,
        font = t,
        paper_bgcolor = bg,
        plot_bgcolor = bg,
        yaxis = list(
            showgrid = FALSE,
            zeroline = FALSE
        ),
        xaxis = list(
            showgrid = FALSE,
            zeroline = FALSE
        ),
        showlegend = FALSE
    )
    return(out)
}
