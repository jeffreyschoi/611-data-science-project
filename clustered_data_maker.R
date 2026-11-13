library(tidyverse)
library(cluster)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")

subscore_data <- data %>% select(c("sub_task_automation", "sub_tool_maturity", "sub_adoption", "sub_agentic_exposure"))

X <- scale(subscore_data)

set.seed(123)
kmeans <- kmeans(X, centers = 4, nstart = 50, iter.max = 100)
data$cluster <- factor(kmeans$cluster)

z_df <- as.data.frame(X)
names(z_df) <- c("sub_task_automation_z", "sub_tool_maturity_z", "sub_adoption_z", "sub_agentic_exposure_z")
data <- bind_cols(data, z_df)

write.csv(data, "derived_data/clustered_data.csv", row.names = FALSE)
