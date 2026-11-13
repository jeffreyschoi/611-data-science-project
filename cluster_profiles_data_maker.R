library(tidyverse)

data <- read_csv("derived_data/clustered_data.csv")

cluster_profiles <- data %>% 
  group_by(cluster) %>% 
  summarise(
    n_occupations = n(),
    mean_overall_score = mean(score),
    median_salary = median(salary_low_usd),
    across(c("sub_task_automation_z", "sub_tool_maturity_z", "sub_adoption_z", "sub_agentic_exposure_z"), ~ mean(.x)),
    .groups = "drop"
  )

write.csv(cluster_profiles, "derived_data/cluster_profiles_data.csv", row.names = FALSE)