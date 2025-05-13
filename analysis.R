# analysis.R

library(tidyverse)
library(tidytuesdayR)
library(ggplot2)

# Automatically detect this week's dataset
tt_data <- tt_load(week = NULL)

# Select the first dataset from the list
df_name <- names(tt_data)[1]
df <- tt_data[[df_name]]

# Basic EDA plot - Mean of numeric columns
plot <- df %>%
  head(1000) %>%
  summarise(across(where(is.numeric), ~ mean(.x, na.rm = TRUE))) %>%
  pivot_longer(cols = everything()) %>%
  ggplot(aes(x = name, y = value)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  theme_minimal() +
  labs(title = paste("TidyTuesday:", df_name),
       subtitle = "Mean values of numeric columns")

ggsave("plot.png", plot)

# Create a basic LinkedIn-style post
post_text <- paste0(
  "This week's #TidyTuesday explores the '", df_name, "' dataset.\n",
  "Here's a quick snapshot from the initial data analysis using R.\n\n",
  "Visualized with #ggplot2 and #rstats 🚀"
)

writeLines(post_text, "post.txt")