library(tidyverse)
library(ggplot2)

plot_data <- read_csv("derived_data/income_plot_data.csv")
model_data <- read_csv("derived_data/income_model_data.csv")

plot <- ggplot(plot_data, aes(x = subscore_value, y = income_10k)) +
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ x) +
  geom_label(
    data = model_data,
    aes(label = label),
    x = -Inf,
    y = Inf,
    inherit.aes = FALSE,
    hjust = -0.05,
    vjust = 1.05,
    size = 3
  ) +
  facet_wrap(~subscore, ncol = 2) +
  labs(
    title = "AI-risk subscores vs. salary midpoint",
    x = "Subscore",
    y = "Income (by $10,000)"
  ) +
  theme_minimal()

ggsave("figures/subscores_by_income_model.pdf", plot = plot)