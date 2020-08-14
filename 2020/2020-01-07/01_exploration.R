library(tidyverse)
library(here)

rainfall <- read_csv(here("data", "2020", "2020-01-07", "rainfall.csv"))
rainfall
temp <- read_csv(here("data", "2020", "2020-01-07", "temperature.csv"))                     
temp
glimpse(rainfall)


rainfall %>% 
  mutate(date = paste(year, month, day, sep = "-")) %>% 
  select(date)


temp %>% 
  filter(city_name == "PERTH", temp_type == "max") %>% 
  filter(date > "2015-01-01") %>% 
  ggplot(aes(x = date, y = temperature)) +
  geom_line()

perth <- temp %>% 
  filter(city_name == "PERTH", temp_type == "max")

library(smooth)
library(Mcomp)
sma(perth$temperature)
?sma

perth %>% 
  mutate(year = lubridate::year(date)) %>% 
  filter(year < "2019-01-01") %>% 
  group_by(year) %>% 
  summarise(mean_temp = mean(temperature, na.rm = TRUE)) %>% 
  ungroup() %>% 
  ggplot(aes(x = year, y = mean_temp)) +
  geom_line()
