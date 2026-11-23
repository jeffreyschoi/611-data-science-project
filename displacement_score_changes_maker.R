library(tidyverse)

score_changes <- read_csv("derived_data/score_changes_data.csv")

plot <- ggplot(score_changes,aes(x = fct_reorder(title, score_change), y = score_change, fill = direction)) +
  geom_col() +
  geom_hline(yintercept = 0, color = "gray40") +
  coord_flip() +
  scale_fill_manual(
    values = c("Decreased" = "#2878B5", "Increased" = "#D95F02")
  ) +
  labs(
    title = "Change in AI Displacement Score by Occupation",
    subtitle = "Q3 2026 score - Q1 2025 score",
    x = NULL,
    y = "Score change",
    fill = "Change"
  ) +
  theme_minimal()


ggsave("figures/displacement_score_changes.png", plot = plot, width = 10, height = 12)
