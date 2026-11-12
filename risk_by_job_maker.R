library(tidyverse)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")

plot <- data %>% 
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

ggsave("figures/risk_by_job.pdf", plot = plot)