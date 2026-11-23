library(tidyverse)
library(plotly)
library(stats)
library(htmlwidgets)

data <- read_csv("derived_data/clustered_data.csv")

subscore_data <- data %>% select(c("sub_task_automation", "sub_tool_maturity", "sub_adoption", "sub_agentic_exposure"))

X <- scale(subscore_data)

pca <- prcomp(X, center = FALSE, scale. = FALSE)
variance_explained <- (pca$sdev^2) / sum(pca$sdev^2)

pca_points <- data.frame(
  title = data$title,
  category = data$category,
  salary_low_usd = data$salary_low_usd,
  salary_high_usd = data$salary_high_usd,
  score = data$score,
  risk_level = data$risk_level,
  cluster = data$cluster,
  PC1 = pca$x[, 1],
  PC2 = pca$x[, 2]
)

pca_points$hover_text <- paste0(
  "<b>", pca_points$title, "</b>",
  "<br>Title: ", pca_points$category,
  "<br>Risk Level: ", pca_points$risk_level,
  "<br>Overall Score: ", pca_points$score
)

pca_plot <- plot_ly(
  data = pca_points,
  x = ~PC1,
  y = ~PC2,
  type = "scatter",
  mode = "markers",
  color = ~cluster,
  text = ~hover_text,
  hovertemplate = "%{text}<extra></extra>",
  marker = list(size = 9, opacity = 0.8),
  height = 650
) %>% 
  layout(
    title = "Job clusters based on Subscores",
    xaxis = list(
      title = paste0("PC1 (", round(variance_explained[1] * 100, 1), "%)")
    ),
    yaxis = list(
      title = paste0("PC2 (", round(variance_explained[2] * 100, 1), "%)")
    )
  )

saveRDS(
  pca_plot,
  "figures/clustered_by_subscores.rds"
)