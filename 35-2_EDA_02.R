library(tidyverse)
source("week_35/35-2_functions.R")

df <- read_csv("../tidytuesday/data/2018-11-27/baltimore_bridges.csv")

# Tidy up columns ---------------------------------------------------------

df$bridge_condition <- as_factor(df$bridge_condition)
df$bridge_condition <- fct_relevel(df$bridge_condition, "Poor")

df$county <- as_factor(map_chr(df$county, fix_county))

# Examine number of bridge in what condition per county:
df %>% 
  group_by(county, bridge_condition) %>% 
  count() %>% 
  ggplot(aes(x = county, y = n, fill = bridge_condition)) +
  geom_col() +
  coord_flip()

# Examine distribution of repair costs
df %>% 
  ggplot(aes(x = log(total_improve_cost_thousands), colour = bridge_condition)) +
  geom_freqpoly()
table(is.na(df$total_improve_cost_thousands))
df %>% 
  ggplot(aes(x = total_improve_cost_thousands, colour = bridge_condition)) +
  geom_freqpoly()
df %>% 
  ggplot(aes(x = bridge_condition, y = total_improve_cost_thousands)) +
  geom_boxplot()
max(df$total_improve_cost_thousands, na.rm = TRUE)
summary(df$total_improve_cost_thousands)

# Do the same but filter out the maximum value outlier
df %>% 
  filter(total_improve_cost_thousands < max(total_improve_cost_thousands, na.rm = TRUE)) %>% 
  ggplot(aes(bridge_condition, log(total_improve_cost_thousands))) +
  geom_boxplot()

# Explore the inspection dates --------------------------------------------

range(df$inspection_yr)
glimpse(df)
yr <- as_Date(str_c("20", df$inspection_yr, sep = "") )
as.Date(yr)
