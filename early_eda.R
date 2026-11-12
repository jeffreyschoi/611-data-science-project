library(tidyverse)
library(plotly)

data <- read_csv("work/ai-career-threat-index/data/ai-career-threat-index.csv")

q1_2025_counts <- data %>% drop_na(score_q1_2025) %>% nrow()
q3_2025_counts <- data %>% drop_na(score_q3_2025) %>% nrow()
q1_2026_counts <- data %>% drop_na(score_q1_2026) %>% nrow()
q2_2026_counts <- data %>% drop_na(score_q2_2026) %>% nrow()

if(length(unique(c(q1_2025_counts, q3_2025_counts, q1_2026_counts, q2_2026_counts))) == 1){
  print(paste0(q1_2025_counts, " jobs have risks scores since 2025"))
}
  
q3_2026_counts <- data %>% drop_na(score_q3_2026) %>% nrow()


data %>% 
  ggplot(aes(x = category, y = score)) + 
  geom_boxplot() + 
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1.0, vjust = 1)) +
  labs(
    title = "AI Risk Score by Job Category",
    subtitle = "",
    x = "Job Category",
    y = "Risk Score"
  )


data <- data[order(data$score), ]
data$occupation_plot <- factor(data$title, levels = unique(data$title))

# Interactive score plot
plot_ly(
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
    title = "Occupation scores by risk label",
    xaxis = list(title = "Score"),
    yaxis = list(title = "", automargin = TRUE),
    legend = list(title = list(text = "Risk label"))
  )

