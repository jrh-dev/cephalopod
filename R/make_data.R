source("init.R")

dash_data <- list(
  e_vs_last_week = vs_last_week(
    data = edat,
    txt_color = '#000000',
    lw_color = '#58508d',
    tw_color = '#bc5090',
    bg_color = '#FFFFFF',
    y_zl_color = '#ff6361'
  ),
  g_vs_last_week = vs_last_week(
    data = gdat,
    txt_color = '#000000',
    lw_color = '#58508d',
    tw_color = '#bc5090',
    bg_color = '#FFFFFF',
    y_zl_color = '#ff6361'
  ),
  e_last_seven = last_seven(
    data = edat,
    txt_color = '#000000',
    bar_color = '#58508d',
    bg_color = '#FFFFFF',
    y_zl_color = '#ff6361'
  ),
  g_last_seven = last_seven(
    data = gdat,
    txt_color = '#000000',
    bar_color = '#58508d',
    bg_color = '#FFFFFF',
    y_zl_color = '#ff6361'
  ),
  e_twelve_wk = twelve_wk(
    data = edat,
    txt_color = '#000000',
    bar_color = '#58508d',
    bg_color = '#FFFFFF',
    y_zl_color = '#ff6361'
  ),
  g_twelve_wk = twelve_wk(
    data = edat,
    txt_color = '#000000',
    bar_color = '#58508d',
    bg_color = '#FFFFFF',
    y_zl_color = '#ff6361'
  )
)

saveRDS(dash_data, "data/output/dash_data.RDS")
