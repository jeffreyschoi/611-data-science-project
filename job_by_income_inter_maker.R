library(tidyverse)
library(plotly)
library(htmlwidgets)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")
data <- data[order(data$score), ]
data$occupation_plot <- factor(data$title, levels = unique(data$title))

plot <- plot_ly(
  data = data,
  x = ~score,
  y = ~salary_low_usd,
  type = "scatter",
  mode = "markers",
  color = ~risk_level,
  colors = c("Moderate" = "#FFD700", "Low" = "#32CD32", "High" = "#FFA500", "Very High" = "#D7301F"),
  text = ~paste0(
    "<b>", data$title, "</b>",
    "<br>Score: ", round(score, 2)
  ),
  hovertemplate = "%{text}<extra></extra>",
  marker = list(size = 10, opacity = 0.85),
  height = max(500, 24 * nrow(df))
  
) %>%
  plotly::layout(
    title = "Job scores by Income",
    xaxis = list(title = "Score"),
    yaxis = list(title = "", automargin = TRUE),
    legend = list(title = list(text = "Risk label"))
  )

saveWidget(plot, file = "figures/scores_by_income_inter.html", selfcontained = TRUE)

