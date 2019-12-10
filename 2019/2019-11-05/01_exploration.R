library(tidyverse)
library(here)

df <- read_csv(here("data", "2019", "2019-11-05", "commute.csv"))
View(df)

table3 <- read_csv(here("data", "2019", "2019-11-05", "table_3.csv"))
table3 %>% print(n = Inf)

# First descriptive plots -------------------------------------------------

df %>% 
  ggplot(aes(x = percent, color = mode)) +
  geom_freqpoly()

# How many n = 0 rows are there?

table(df$n == 0)

df_nz <- df %>% 
  filter(n != 0)

df_nz %>% 
  ggplot(aes(x = percent, color = mode)) +
  geom_density()
df_nz %>% 
  ggplot(aes(x = log(percent + 1), color = mode)) +
  geom_freqpoly(bins = 30)



# first mapping -----------------------------------------------------------

usa <- map_data("usa")
usa
ggplot(usa, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")
ggplot(usa, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()


table(usa$group)
map('usa')
table(usa$region)
data("usaMapEnv")
map.cities()
us.cities
library(maps)

all_cities <- as.tibble(us.cities) %>% 
  mutate(name = str_sub(name, start = 1, end = -4))
all_cities
all_cities %>% 
  filter(name == "New York")



table(df$city %in% all_cities$name)
length(all_cities$name[1])
df$city

test <- df$city[1:10]

strings_to_remove <- c(" city", " town", " village", " borough", "CDP")
str_remove_all(df$city, strings_to_remove)  
test2 <- df$city %>% str_sub(start = -5)
test2
table(test2)
str_split(test, " ")[[6]]

all_cities
df
str_


deeps <- read_csv(here("data", "2019", "2019-11-05", "deeps.csv"))
deeps
table(deeps$city %in%all_cities$name)
deeps$city %>% 
  filter(city %in% all_cities$name)

deeps[!(deeps$city %in% all_cities$name),]
deeps

all_cities %>% 
  filter(name == "Aberdeen")
