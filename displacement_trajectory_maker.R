library(tidyverse)
library(plotly)
library(scales)
library(htmlwidgets)

trajectory_data <- read_csv("derived_data/trajectory_data.csv")

quarter_order <- c("Q1 2025", "Q3 2025", "Q1 2026", "Q2 2026", "Q3 2026")

trajectory_data <- trajectory_data %>%
  mutate(quarter = factor(quarter, levels = quarter_order))

average_data <- trajectory_data %>%
  group_by(quarter) %>%
  summarize(score = mean(score), .groups = "drop")

categories <- sort(unique(as.character(trajectory_data$category)))
category_colors <- setNames(hue_pal()(length(categories)), categories)

hover_labels <- trajectory_data %>%
  mutate(quarter_name = as.character(quarter)) %>%
  arrange(match(quarter_name, quarter_order)) %>%
  group_by(title, category) %>%
  summarize(
    hover_text = paste0(
      "<b>", first(title), "</b><br>",
      paste0(quarter_name, ": ", score, collapse = "<br>")
    ),
    .groups = "drop"
  )

plot_data <- trajectory_data %>%
  left_join(hover_labels, by = c("title", "category"))

plot <- plot_ly()
shown_categories <- character(0)

for (job in unique(plot_data$title)) {
  job_data <- plot_data %>% filter(title == job)
  job_category <- as.character(job_data$category[1])
  show_category <- !(job_category %in% shown_categories)
  
  plot <- plot %>%
    add_trace(
      data = job_data,
      x = ~quarter,
      y = ~score,
      type = "scatter",
      mode = "lines+markers",
      name = job_category,
      legendgroup = job_category,
      showlegend = show_category,
      text = ~hover_text,
      hovertemplate = "%{text}<extra></extra>",
      line = list(color = category_colors[[job_category]]),
      marker = list(color = category_colors[[job_category]])
    )
  
  shown_categories <- c(shown_categories, job_category)
}

average_hover <- paste0(
  "<b>Average</b><br>",
  paste0(
    as.character(average_data$quarter), ": ",
    round(average_data$score, 2),
    collapse = "<br>"
  )
)

plot <- plot %>%
  add_trace(
    data = average_data,
    x = ~quarter,
    y = ~score,
    type = "scatter",
    mode = "lines+markers",
    name = "Average",
    text = average_hover,
    hovertemplate = "%{text}<extra></extra>",
    line = list(color = "black", dash = "dash", width = 3),
    marker = list(color = "black"),
    showlegend = TRUE
  ) %>%
  layout(
    title = "AI Displacement Score Over Time",
    xaxis = list(title = "Quarter"),
    yaxis = list(title = "AI displacement score"),
    legend = list(title = list(text = "Occupational category"))
  )

saveRDS(
  plot,
  "figures/displacement_trajectory.rds"
)