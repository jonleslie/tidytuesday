library(tidyverse)
library(here)
library(lubridate)

here::here()
pris_sum_raw <- read_csv(here::here("data", "2019", "2019-01-22", "prison_summary.csv")) %>% 
  mutate(urbanicity = factor(urbanicity),
         pop_category = factor(pop_category))

pris_sum_raw

# as_date(as.character(pris_sum_raw$year[1]))

pris_sum_raw %>% 
  group_by(year, pop_category) %>% 
  summarise(av_rate = mean(rate_per_100000)) %>% 
  ggplot(aes(x = year, y = av_rate, colour = pop_category)) +
  geom_line() +
  ggtitle("Incarceration rates by ethnicity") 

pris_sum_raw %>% 
  group_by(year, urbanicity) %>% 
  summarise(av_rating = mean(rate_per_100000)) %>% 
  ggplot(aes(x = year, y = av_rating, colour = urbanicity)) +
  geom_line()

# Population --------------------------------------------------------------

pris_pop_raw <- read_csv(here::here("data", "2019", "2019-01-22", "prison_population.csv")) %>% 
  mutatae
pris_pop_raw
