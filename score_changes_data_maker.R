library(tidyverse)

trajectory_data <- read_csv("derived_data/trajectory_data.csv")

score_changes <- trajectory_data %>%
  group_by(title, category) %>%
  summarize(
    first_score = score[quarter == "Q1 2025"][1],
    last_score  = score[quarter == "Q3 2026"][1],
    .groups = "drop"
  ) %>%
  mutate(
    score_change = last_score - first_score,
    direction = if_else(score_change >= 0, "Increased", "Decreased"),
  )
  
write.csv(score_changes, "derived_data/score_changes_data.csv", row.names = FALSE)