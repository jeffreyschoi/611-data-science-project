library(tidyverse)
library(plotly)
library(htmlwidgets)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")
data <- data[order(data$score), ]
data$occupation_plot <- factor(data$title, levels = unique(data$title))
data$mean_income <- (data$salary_low_usd + data$salary_high_usd) / 2

plot <- plot_ly(
  data = data,
  x = ~score,
  y = ~mean_income,
  type = "scatter",
  mode = "markers",
  color = ~risk_level,
  colors = c("Moderate" = "#FFD700", "Low" = "#32CD32", "High" = "#FFA500", "Very High" = "#D7301F"),
  text = ~paste0(
    "<b>", title, "</b>",
    "<br>Score: ", round(score, 2),
    "<br>Income: ", mean_income
  ),
  hovertemplate = "%{text}<extra></extra>",
  marker = list(size = 10, opacity = 0.85),
  height = max(500, 24 * nrow(df))
  
) %>%
  plotly::layout(
    title = "Job scores by Income",
    xaxis = list(title = "Score"),
    yaxis = list(title = "Average Income"),
    legend = list(title = list(text = "Risk label"))
  )

saveRDS(
  plot,
  "figures/scores_by_income_inter.rds"
)
