library(tidyverse)
library(sandwich)
library(lmtest)

plot_data <- read_csv("derived_data/income_plot_data.csv")

model_data <- bind_rows(
  lapply(split(plot_data, plot_data$subscore), function(d) {
    model <- lm(subscore_value ~ income_10k, data = d)
    robust_test <- coeftest(model, vcov. = vcovHC(model, type = "HC3"))
    
    slope <- robust_test["income_10k", "Estimate"]
    robust_se <- robust_test["income_10k", "Std. Error"]
    p_value <- robust_test["income_10k", "Pr(>|t|)"]
    critical_value <- qt(0.975, df = df.residual(model))
    
    data.frame(
      subscore = as.character(d$subscore[1]),
      slope = slope,
      ci_low = slope - critical_value * robust_se,
      ci_high = slope + critical_value * robust_se,
      p_value = p_value
    )
  })
) %>%
  mutate(
    label = sprintf(
      "Slope = %.2f\n95%% CI: [%.2f, %.2f]\np-value = %.3f",
      slope, ci_low, ci_high, p_value
    )
  )

write.csv(model_data, "derived_data/income_model_data.csv")