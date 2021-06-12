library(tidyverse)
library(lubridate)

summary <- read.csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-06-01/summary.csv")


dim(summary)
glimpse(summary)

summary %>% 
  mutate(across(where(is.character), as.factor)) %>% 
  glimpse()

# Calculate time intervals for airdates and filming
summary %>% 
  mutate(days_filming = time_length(interval(filming_started, filming_ended), unit = "days")) %>% 
  mutate(days_aired = time_length(interval(premiered, ended), unit = "days")) %>% 
  select(-premiered: -filming_ended) 

# Pivot Data - Combining metrics for our show type

summary %>% 
  pivot_longer(
    cols = viewers_premier : viewers_reunion,
    names_to = "show_type",
    names_prefix = "viewers_", 
    values_to = "total_views",
    values_drop_na = TRUE
  )

# Create a tidy dataset

summary_tidy <- summary %>% 
  # Convert character to factors
  mutate(across(where(is.character), as.factor)) %>% 
  # Calculate time intervals
  mutate(days_filming = time_length(interval(filming_started, filming_ended), 
                                    unit = "days")) %>% 
  mutate(days_aired = time_length(interval(premiered, ended), unit = "days")) %>% 
  # Drop original data columns
  select(-premiered: -filming_ended) %>% 
  # Combine metrics for our show type
  pivot_longer(
    cols = viewers_premier : viewers_reunion,
    names_to = "show_type",
    names_prefix = "viewers_", 
    values_to = "total_views",
    values_drop_na = TRUE
  )

  
