library(tidyverse)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")

score_cols <- c(
  "score_q1_2025",
  "score_q3_2025",
  "score_q1_2026",
  "score_q2_2026",
  "score_q3_2026"
)

trajectory_data <- data %>%
  filter(if_all(all_of(score_cols), ~ !is.na(.x))) %>%
  select(title, category, all_of(score_cols)) %>%
  pivot_longer(
    cols = all_of(score_cols),
    names_to = "quarter",
    values_to = "score"
  ) %>%
  mutate(
    quarter = factor(
      quarter,
      levels = score_cols,
      labels = c("Q1 2025", "Q3 2025", "Q1 2026", "Q2 2026", "Q3 2026")
    )
  )

write.csv(trajectory_data, "derived_data/trajectory_data.csv", row.names = FALSE)
