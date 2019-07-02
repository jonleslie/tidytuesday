#########################################################################
# Project: WineMag Data
# Script purpose: First exploration into the winemag dataset 2019-05-28
# Date: 2019-06-04
# Author: Jon Leslie
#########################################################################

library(tidyverse)
library(here)
library(janitor)

df_raw <- read_csv(here(
  "data", "2019", "2019-05-28", "winemag-data-130k-v2.csv"),
  )

df_raw

glimpse(df_raw)

df_raw %>% 
  select(points, country) %>% 
  ggplot(aes(points)) +
  geom_density()

df_raw %>% 
  group_by(country) %>% 
  count() %>% 
  arrange(desc(n))

df_raw %>% 
  select(points, country) %>% 
  filter(country %in% c("US", "France", "Italy")) %>% 
  ggplot(aes(points, col = country)) +
  geom_density()

df_raw %>% 
  filter(winery == "Veritas") %>% 
  ggplot(aes(points)) +
  geom_histogram()
