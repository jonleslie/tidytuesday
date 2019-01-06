library(tidyverse)
library(fivethirtyeight)

data(package = "fivethirtyeight")
data(package = "dplyr")

df <- read_csv("../tidytuesday/data/week7_starwars.csv")
df
head(dplyr::starwars)
