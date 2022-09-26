


last_seven <- function(data, txt_color, bar_color, bg_color, y_zl_color) {
  
  cutoff <- Sys.Date() - 7
  
  dt$setDT(data)

  data <- data[interval_start >= cutoff,]
  
  data[, interval_start := as.POSIXct(cut(interval_start, breaks = "days"))]
  
  data[, day := ld$wday(interval_start, label = TRUE, abbr = TRUE)]
  
  data <- data[, .(consumption = sum(consumption)), by = "day"]
  
  data[, day := factor(day, levels = day)]
  
  text <- list(
    family = "Source Sans Pro",
    size = 18,
    color = txt_color)
  
  p1 <- px$plot_ly(
    x = data$day,
    y = data$consumption,
    type = "bar",
    marker = list(
      color = bar_color,
      line = list(color = bar_color,
                  width = 1.5))
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
    showlegend = FALSE
  )
  
  return(list(plot=p1, data = data))
}
