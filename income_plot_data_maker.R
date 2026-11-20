library(tidyverse)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")

score_labels <- c(
  sub_task_automation = "Task automation",
  sub_tool_maturity = "Tool maturity",
  sub_adoption = "AI adoption",
  sub_agentic_exposure = "Agentic exposure"
)

plot_data <- data %>%
  mutate(
    salary_low_usd = as.numeric(salary_low_usd),
    salary_high_usd = as.numeric(salary_high_usd),
    income_10k = ((salary_low_usd + salary_high_usd) / 2) / 10000
  ) %>%
  pivot_longer(
    cols = all_of(names(score_labels)),
    names_to = "subscore",
    values_to = "subscore_value"
  ) %>%
  mutate(
    subscore_value = as.numeric(subscore_value),
    subscore = factor(
      subscore,
      levels = names(score_labels),
      labels = unname(score_labels)
    )
  )

write.csv(plot_data, "derived_data/income_plot_data.csv")