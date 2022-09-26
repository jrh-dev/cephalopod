
vs_last_week <- function(data, txt_color, lw_color, tw_color, bg_color, y_zl_color) {
    
    dat <- copy(data)

    week_catch <- ld$floor_date(max(dat$interval_start), unit = "weeks", week_start = 1) - (7 * 86400)

    dat[, week := ld$floor_date(interval_start, unit = "weeks", week_start = 1)]

    dat <- dat[week >= c(week_catch),]

    dat[, reading := paste0(
        ld$wday(interval_end, label = TRUE, abbr = TRUE),
        "-",
        substr(interval_end, 12, 16)
    )]

    dat[, reading := factor(reading, levels = unique(reading))]

    dat <- dat[, consum := cumsum(consumption), by = "week"]

    dat[, group := .GRP, by = c("week")]

    dat[, group := fcase(group == 1, "Last Week", group == 2, "This Week", default = "Unknown")]

    setorder(dat, reading)

    text <- list(
        family = "Source Sans Pro",
        size = 18,
        color = txt_color)

    p1 <- px$plot_ly(
        type = 'scatter',
        x = dat$reading,
        y = dat$consum,
        mode = 'lines',
        transforms = list(
            list(
                type = 'groupby',
                groups = dat$group,
                styles = list(
                    list(target = "Last Week", value = list(line =list(color = lw_color))),
                    list(target = "This Week", value = list(line =list(color = tw_color)))
                )
            )
        )
    )
    
    p1 <- px$layout(
        p1,
        font = text,
        paper_bgcolor = bg_color,
        plot_bgcolor = bg_color,
        yaxis = list(
            showgrid = FALSE,
            zeroline = FALSE
        ),
        xaxis = list(
            showgrid = FALSE,
            zeroline = FALSE
        ),
        showlegend = TRUE
    )
    
    latest <- max(dat$interval_end)
    yesterday <- latest - 86400
    last_week <- latest - (7 * 86400)
    
    latest <- dat[interval_end == latest]$consum
    yesterday <- dat[interval_end == yesterday]$consum
    last_week <- dat[interval_end == last_week]$consum
    
    return(list(plot=p1, data = dat, last = latest, yest = yesterday, week = last_week))
}






