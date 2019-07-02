library(tidyverse)
library(here)

jobs <- read_csv(here::here("data", "2019", "2019-03-05", "jobs_gender.csv"))
jobs

earnings <- read_csv(here::here("data", "2019", "2019-03-05", "earnings_female.csv"))
earnings

employed <- read_csv(here::here("data", "2019", "2019-03-05", "employed_gender.csv"))
employed

jobs
glimpse(jobs)
unique(jobs$major_category)

jobs %>% 
  group_by(major_category, year) %>% 
  summarise(average = mean(total_workers))

jobs %>% 
  group_by(major_category, year) %>% 
  summarise(av_perc_fem = mean(percent_female))

jobs %>% 
  group_by(major_category, year) %>% 
  summarise(av_perc_fem = mean(percent_female)) %>% 
  ggplot(aes(x = year, y = av_perc_fem)) +
  geom_point() +
  geom_line() +
  facet_wrap(~major_category)

stem <- jobs %>% 
  filter(major_category == "Computer, Engineering, and Science") 

stem %>% 
  group_by(minor_category, year) %>% 
  summarise(av_perc_fem = mean(percent_female)) %>% 
  ggplot(aes(x = year, y = av_perc_fem)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ minor_category)

glimpse(jobs)

jobs %>% 
  group_by(major_category, year) %>% 
  summarise(av_perc_fem = mean(wage_percent_of_male, na.rm = TRUE)) %>% 
  ggplot(aes(x = year, y = av_perc_fem)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ major_category)
