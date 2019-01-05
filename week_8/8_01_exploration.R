library(tidyverse)

df <- read_csv("../tidytuesday/data/week8_honey_production/honeyproduction.csv")
df
df %>% 
  filter(state == "AL")
