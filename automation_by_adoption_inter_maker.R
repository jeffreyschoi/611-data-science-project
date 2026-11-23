library(readr)
library(plotly)
library(htmlwidgets)

data <- read_csv("ai-career-threat-index/data/ai-career-threat-index.csv")

plot <- plot_ly(
  data,
  x = ~sub_task_automation,
  y = ~sub_adoption,
  type = "scatter",
  mode = "markers",
  size = ~sub_tool_maturity,
  sizes = c(10, 100),
  text = ~paste0(
    "<b>", title, "</b>",
    "<br>Task automation: ", sub_task_automation,
    "<br>Employer adoption: ", sub_adoption,
    "<br>Agentic exposure: ", sub_agentic_exposure,
    "<br>Tool maturity: ", sub_tool_maturity
  ),
  hoverinfo = "text",
  marker = list(
    color = ~sub_agentic_exposure,
    colorscale = "Viridis",
    colorbar = list(
      title = list(text = "Agentic exposure")
    ),
    opacity = 0.75
  )
) %>%
  layout(
    title = "Task Automation, Employer Adoption, and Agentic Exposure",
    xaxis = list(title = "Task automation"),
    yaxis = list(title = "Employer adoption"),
    shapes = list(
      list(
        type = "line",
        x0 = median(data$sub_task_automation), x1 = median(data$sub_task_automation),
        y0 = 0, y1 = 1,
        xref = "x", yref = "paper",
        line = list(color = "black", dash = "dash")
      ),
      list(
        type = "line",
        x0 = 0, x1 = 1,
        y0 = median(data$sub_adoption), y1 = median(data$sub_adoption),
        xref = "paper", yref = "y",
        line = list(color = "black", dash = "dash")
      )
    )
  )

saveRDS(
  plot,
  "figures/automation_by_adoption.rds"
)