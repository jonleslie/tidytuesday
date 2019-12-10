#########################################################################
# Project: Media franchises
# Script purpose: EDA
# Date: 2019-07-02
# Author: Jon Leslie
#########################################################################

library(tidyverse)
library(janitor)

df <- read_csv("data/2019/2019-07-02/media_franchises.csv")

df
View(df)
glimpse(df)


df %>% 
  group_by(franchise) %>% 
  select(original_media) %>% 
  summarise(no = length(unique(original_media))) %>% 
  arrange(desc(no))


# How much did each franchise make in revenue? ----------------------------


df %>% 
  group_by(franchise, year_created) %>% 
  summarise(tot_revenue = sum(revenue)) %>% 
  arrange(desc(tot_revenue)) %>% 
  ggplot(aes(x = year_created, y = tot_revenue)) +
  geom_col()
